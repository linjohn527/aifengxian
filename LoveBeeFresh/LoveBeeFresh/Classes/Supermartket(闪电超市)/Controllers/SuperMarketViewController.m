//
//  SuperMarketViewController.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "SuperMarketViewController.h"
#import "SuperMarketData.h"
#import "SuperMarketResource.h"
#import "SuperMarket.h"
#import "ProductsViewController.h"
#import "ProgressHudManager.h"
#import "MJRefresh.h"
#import "Category.h"
#import "CategoryCell.h"

@interface SuperMarketViewController ()<UITableViewDelegate,UITableViewDataSource,ProductsViewControllerDelegate>

/**  */
@property(nonatomic,strong)SuperMarket *supermarketData;


/**  */
@property(nonatomic,strong)UITableView *categoriesTableView;

/**  */
@property(nonatomic,strong)ProductsViewController *productsVC;

/**  */
@property(assign,nonatomic)BOOL categoriesTableViewIsLoaded;
/**  */
@property(assign,nonatomic)BOOL productsTableViewIsLoaded;


@end


@implementation SuperMarketViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    //
    [self addNotification];
    [self showProcessHUD];
    [self buildCategoriesTableView];
    [self buildProductsViewController];
    [self loadSuperMarketData];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    if (_productsVC.productsTableView != nil) {
        
        [_productsVC.productsTableView reloadData];
    }
    
    self.navigationController.navigationBar.barTintColor = NAVIGATION_YELLOW_COLOR;
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addNotification {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCartBuyNumberDidChange) name:ShopCartProductBuyNumberDidChange object:nil];
}


- (void)showProcessHUD {

    [ProgressHudManager setBackgroudColor:RGB(230, 230, 230)];
    self.view.backgroundColor = [UIColor whiteColor];
    if (![ProgressHudManager isVisible]) {
        
        [ProgressHudManager showWithStatus:@"正在加载中"];
    }
    
}

- (void)buildCategoriesTableView {

    _categoriesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH * 0.25, SCREEN_HEIGHT) style:UITableViewStylePlain];
    _categoriesTableView.backgroundColor = GLOBAL_BACKGROUD_COLOR;
    _categoriesTableView.delegate = self;
    _categoriesTableView.dataSource= self;
    _categoriesTableView.showsHorizontalScrollIndicator = false;
    _categoriesTableView.showsVerticalScrollIndicator = false;
    _categoriesTableView.contentInset = UIEdgeInsetsMake(0, 0, NavigationH, 0);
    _categoriesTableView.hidden = YES;
    [self.view addSubview:_categoriesTableView];
}

- (void)buildProductsViewController {

    _productsVC = [[ProductsViewController alloc] init];
    _productsVC.delegate = self;
    _productsVC.view.hidden = YES;
    [self addChildViewController:_productsVC];
    [self.view addSubview:_productsVC.view];
    
    __weak typeof(self) weakSelf = self;
    _productsVC.refreshPull = ^{
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [SuperMarketData loadSuperMarketData:^(SuperMarket *data, NSError *error) {
                
                if (!error) {
                    
                    weakSelf.supermarketData = data;
                    weakSelf.productsVC.supermarketData = data;
                    [weakSelf.productsVC.productsTableView.mj_header endRefreshing];
                    [weakSelf.categoriesTableView reloadData];
                    [weakSelf.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
                }
            }];
        });

    };
}

- (void)loadSuperMarketData {

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        __weak typeof(self) weakSelf = self;
        [SuperMarketData loadSuperMarketData:^(SuperMarket *data, NSError *error) {
            
            if (!error) {
                
                weakSelf.supermarketData = data;
                weakSelf.productsVC.supermarketData = data;
                [weakSelf.productsVC.productsTableView.mj_header endRefreshing];
                weakSelf.supermarketData = data;
                [weakSelf.categoriesTableView reloadData];
                [weakSelf.categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
                
                weakSelf.categoriesTableViewIsLoaded = YES;
                weakSelf.productsTableViewIsLoaded = YES;
                
                if (weakSelf.categoriesTableViewIsLoaded && weakSelf.productsTableViewIsLoaded) {
                    
                    weakSelf.categoriesTableView.hidden = false;
                    weakSelf.productsVC.productsTableView.hidden = false;
                    
                    weakSelf.productsVC.view.hidden = false;
                    [ProgressHudManager dismiss];
                    weakSelf.view.backgroundColor = GLOBAL_BACKGROUD_COLOR;
                    
                }
            }

        }];
        
    });
    
}

- (void)shopCartBuyNumberDidChange {

    if (_productsVC.productsTableView != nil) {
        
        [_productsVC.productsTableView reloadData];
    }
}


#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return !(_supermarketData.data.categories.count>0)?:_supermarketData.data.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    CategoryCell *cell = [CategoryCell cellWithTableView:tableView];
    
    cell.categories = _supermarketData.data.categories[indexPath.row];
    
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (_productsVC != nil) {
        
        
        [_productsVC setCategorySelectedIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row]];
    }
}

#pragma mark - <ProductVC Delegate>
- (void)didEndDisplayingHeaderViewForSection:(NSUInteger)section {

    [_categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section+1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)willDisplayingHeaderViewForSection:(NSUInteger)section {

    [_categoriesTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    
}

@end
