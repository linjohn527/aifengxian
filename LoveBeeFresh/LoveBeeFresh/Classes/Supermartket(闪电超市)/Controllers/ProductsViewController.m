//
//  ProductsViewController.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/16/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ProductsViewController.h"
#import "SuperMarketHeaderView.h"
#import "RefreshHeader.h"
#import "SuperMarketData.h"
#import "SuperMarket.h"
#import "SuperMarketResource.h"
#import "ProductCell.h"
#import "Category.h"
#import "ProductDetailViewController.h"

@interface ProductsViewController ()<UITableViewDataSource,UITableViewDelegate>

/**  */
@property(assign,nonatomic)CGFloat lastOffsetY;
/**  */
@property(assign,nonatomic)BOOL isScrollDown;

/** */
@property(nonatomic,strong)NSArray *goodsArray;

@end

@implementation ProductsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
}

- (void)setup {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopCartProductBuyNumberDidChange) name:ShopCartProductBuyNumberDidChange  object:nil];
    
    self.view.frame = CGRectMake(SCREEN_WIDTH * 0.25, 0, SCREEN_WIDTH * 0.75, SCREEN_HEIGHT - NavigationH);
    
    [self buildProductsTableView];
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)shopCartProductBuyNumberDidChange {

    
}

static NSString *SuperMarketHeaderViewIdentifier = @"header";
- (void)buildProductsTableView {

    _productsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _productsTableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    _productsTableView.backgroundColor = GLOBAL_BACKGROUD_COLOR;
    _productsTableView.dataSource = self;
    _productsTableView.delegate = self;
    
    [_productsTableView registerClass:[SuperMarketHeaderView class] forHeaderFooterViewReuseIdentifier:SuperMarketHeaderViewIdentifier];
    _productsTableView.tableFooterView = [self buildProductsTableViewFooterView];
    
    //
    RefreshHeader *refreshHeader = [RefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(startRefreshUpPull)];
    _productsTableView.mj_header = refreshHeader;
    
    [self.view addSubview:_productsTableView];
    
}

- (UIView *)buildProductsTableViewFooterView {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _productsTableView.width, 70)];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.image = [UIImage imageNamed:@"v2_common_footer"];

    return imageView;
}

- (void)startRefreshUpPull {

    !_refreshPull?:_refreshPull();
}


#pragma mark - <Set>

- (void)setSupermarketData:(SuperMarket *)supermarketData {

    _supermarketData = supermarketData;
    
    _goodsArray = [SuperMarketData searchSuperMarketMatchProduct:(supermarketData.data)];
    
    [_productsTableView reloadData];
}

- (void)setCategorySelectedIndexPath:(NSIndexPath *)categorySelectedIndexPath {

    _categorySelectedIndexPath = categorySelectedIndexPath;
    
    [_productsTableView selectRowAtIndexPath:categorySelectedIndexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _supermarketData.data.categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSArray *goodsArr = _goodsArray[section];
    
    return goodsArr.count>0?goodsArr.count:0;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductCell *cell = [ProductCell cellWithTableView:tableView];
    
    __weak typeof(self) weakSelf = self;
    cell.addProductClick = ^(UIImageView *imageView) {
    
        [weakSelf addProductsAnimation:imageView];
    };
    
    cell.goods = _goodsArray[indexPath.section][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return  85.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return 25.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    SuperMarketHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:SuperMarketHeaderViewIdentifier];
    
    Category2 *category = (Category2 *)_supermarketData.data.categories[section];
    if (_supermarketData.data.categories.count > 0 && category.name != nil) {
        
        headerView.titleLabel.text = category.name;
    }
    
    return headerView;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {

    if (_delegate && [_delegate respondsToSelector:@selector(didEndDisplayingHeaderViewForSection:)] && !_isScrollDown) {
        
        [_delegate didEndDisplayingHeaderViewForSection:section];
    }
    
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {

    if (_delegate && [_delegate respondsToSelector:@selector(willDisplayingHeaderViewForSection:)] && !_isScrollDown) {
        
        [_delegate willDisplayingHeaderViewForSection:section];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    Goods *goods = _goodsArray[indexPath.section][indexPath.row];
    
    ProductDetailViewController *detailVC = [[ProductDetailViewController alloc] initWithGoods:goods];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (self.animationLayers.count > 0) {
        
        CALayer *animLayer = [self.animationLayers firstObject];
        animLayer.hidden = YES;
    }
    
    _isScrollDown = _lastOffsetY < scrollView.contentOffset.y;
    _lastOffsetY = scrollView.contentOffset.y;
}



@end
