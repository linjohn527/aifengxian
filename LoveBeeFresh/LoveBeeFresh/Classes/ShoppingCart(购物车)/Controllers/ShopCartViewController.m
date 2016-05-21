//
//  ShopCartViewController.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ShopCartViewController.h"
#import "UserShopCartTool.h"
#import "ReceiptAddressView.h"
#import "ShopCartCommentView.h"
#import "ProductsTableView.h"
#import "ShopCartSupermarketTableFooterView.h"
#import "UIBarButtonItem+Extension.h"
#import "ProgressHudManager.h"
#import "UserInfo.h"
#import "AddressData.h"
#import "ShopCartMarketView.h"
#import "ShopCartCell.h"
#import "OrderPayWayViewController.h"

@interface ShopCartViewController ()<UITableViewDelegate,UITableViewDataSource>

/**  */
@property(nonatomic,strong)UIImageView *shopImageView;
/**  */
@property(nonatomic,strong)UILabel *emptyLabel;
/**  */
@property(nonatomic,strong)UIButton *emptyButton;

/**  */
@property(nonatomic,strong)ReceiptAddressView *receiptAddressView;
/**  */
@property(nonatomic,strong)UIView *tableHeadView;
/**  */
@property(nonatomic,strong)UILabel *signTimeLabel;
/**  */
@property(nonatomic,strong)UILabel *reserverLabel;
/**  */
@property(nonatomic,strong)UIPickerView *signTimePickerView;
/**  */
@property(nonatomic,strong)ShopCartCommentView *commentView;

/**  */
@property(nonatomic,strong)ProductsTableView *supermarketTableView;

/**  */
@property(nonatomic,strong)ShopCartSupermarketTableFooterView *tableFooterView;

/**  */
@property(assign,nonatomic)BOOL isFirstLoad;



@end

@implementation ShopCartViewController

- (UIImageView *)shopImageView {

    if (!_shopImageView) {
        
        _shopImageView = [[UIImageView alloc] init];
    }
    
    return _shopImageView;
}

- (UILabel *)emptyLabel {

    if (!_emptyLabel) {
        
        _emptyLabel = [[UILabel alloc] init];
        
    }
    
    return _emptyLabel;
}

- (UIButton *)emptyButton {

    if (!_emptyButton) {
        
        _emptyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    
    return _emptyButton;
}

- (UIView *)tableHeadView {

    if (!_tableHeadView) {
        
        _tableHeadView = [[UIView alloc] init];
    }
    
    return _tableHeadView;
}

- (ReceiptAddressView *)receiptAddressView {

    if (!_receiptAddressView) {
        
        CGRect frame = CGRectMake(0, 10, self.view.width, 70);
        _receiptAddressView = [[ReceiptAddressView alloc] initWithFrame:frame ModifyButtonClick:^{
            
            
        }];
    }
    
    return _receiptAddressView;
}

- (ProductsTableView *)supermarketTableView {

    if (!_supermarketTableView) {
        
        CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50);
        _supermarketTableView = [[ProductsTableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    }
    
    return _supermarketTableView;
}

- (ShopCartSupermarketTableFooterView *)tableFooterView {

    if (!_tableFooterView) {
        
        CGRect frame = CGRectMake(0, SCREEN_HEIGHT - 64- 50, SCREEN_WIDTH, 50);
        __weak typeof(self) weakSelf = self;
        _tableFooterView = [[ShopCartSupermarketTableFooterView alloc] initWithFrame:frame deciseButtonClick:^{
            
            OrderPayWayViewController *orderPayWayVC = [[OrderPayWayViewController alloc] init];
            [weakSelf.navigationController pushViewController:orderPayWayVC animated:YES];
        }];
    }
    
    return _tableFooterView;
}

- (UILabel *)signTimeLabel {

    if (!_signTimeLabel) {
        
        _signTimeLabel = [[UILabel alloc] init];
    }
    
    return _signTimeLabel;
}

- (UILabel *)reserverLabel {

    if (!_reserverLabel) {
        
        _reserverLabel = [[UILabel alloc] init];
    }
    
    return _reserverLabel;
}

- (ShopCartCommentView *)commentView {

    if (!_commentView) {
        
        
        _commentView = [[ShopCartCommentView alloc] init];
  
      
    }
    
      return _commentView;
}

- (void)viewDidLoad {

    [super viewDidLoad];
        
    [self addNotification];
    [self buildNavigationItem];
    [self buildEmptyUI];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    UserShopCartTool *shopcartTool = [UserShopCartTool sharedUserShopCart];
    
    if ([shopcartTool isEmpty]) {
        
        [self showShopCartEmptyUI];
        
    } else {
    
        if (![ProgressHudManager isVisible]) {
            
            [ProgressHudManager setBackgroudColor:RGB(230, 230, 230)];
            [ProgressHudManager showWithStatus:@"正在加载信息"];
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self showProductView];
            [ProgressHudManager dismiss];
        });
    }
}

- (void)addNotification {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopcartProductsDidRemove) name:ShopCartProductDidRemove object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shopcartBuyPriceDidChange) name:ShopCartBuyPriceDidChange object:nil];
}



- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)buildNavigationItem {

    self.navigationItem.title = @"购物车";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:nil titleColor:nil image:@"v2_goback" higlightImg:nil target:self action:@selector(leftNavigationItemClick) type:BarButtonItemTypeLeft];
}

- (void)buildEmptyUI {

    self.shopImageView.image = [UIImage imageNamed:@"v2_shop_empty"];
    self.shopImageView.contentMode = UIViewContentModeCenter;
    self.shopImageView.frame = CGRectMake((self.view.width - self.shopImageView.width) * 0.5, self.shopImageView.height * 0.25 + NavigationH, self.shopImageView.width, self.shopImageView.height);
    self.shopImageView.hidden = YES;
    [self.view addSubview:self.shopImageView];
    
    //
    self.emptyLabel.text = @"购物车空空如也，快来购买哦";
    self.emptyLabel.textColor = RGB(100, 100, 100);
    self.emptyLabel.textAlignment = NSTextAlignmentCenter;
    self.emptyLabel.font = [UIFont systemFontOfSize:16];
    self.emptyLabel.frame = CGRectMake(0, CGRectGetMaxY(self.shopImageView.frame)+ 55, self.view.width, 50);
    self.emptyLabel.hidden = YES;
    [self.view addSubview:self.emptyLabel];
    
    //
    self.emptyButton.frame = CGRectMake((self.view.width - 150) * 0.5, CGRectGetMaxY(self.emptyLabel.frame) + 15, 150, 30);
    [self.emptyButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [self.emptyButton setTitle:@"去逛逛" forState:UIControlStateNormal];
    [self.emptyButton setTitleColor:RGB(100, 1001, 100) forState:UIControlStateNormal];
    [self.emptyButton addTarget:self action:@selector(leftNavigationItemClick) forControlEvents:UIControlEventTouchUpInside];
    self.emptyButton.hidden = YES;
    [self.view addSubview:self.emptyButton];
    
}

- (void)shopcartProductsDidRemove {

    
}

- (void)shopcartBuyPriceDidChange {

    NSLog(@"%@",[[UserShopCartTool sharedUserShopCart] getAllProductsPrice]);
    
    self.tableFooterView.priceLabel.text = [[UserShopCartTool sharedUserShopCart] getAllProductsPrice];
    
}

- (void)leftNavigationItemClick {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showShopCartEmptyUI {

    self.shopImageView.hidden = NO;
    self.emptyLabel.hidden = NO;
    self.emptyButton.hidden = NO;
}

- (void)showProductView {

    if (!self.isFirstLoad) {
        
        [self buildTableHeadView];
        [self buildSupermarkeTabletView];
        self.isFirstLoad = YES;
    }
}

- (void)buildTableHeadView {

    self.tableHeadView.backgroundColor = self.view.backgroundColor;
    self.tableHeadView.frame = CGRectMake(0, 0, self.view.width, 250);
    
    [self buildReceiptAddressView];
    [self buildMarketView];
    [self buildSignTimeView];
    [self buildSignComment];
    
}

- (void)buildSupermarkeTabletView {

    self.supermarketTableView.tableHeaderView = self.tableHeadView;
    self.supermarketTableView.delegate = self;
    self.supermarketTableView.dataSource = self;
    self.supermarketTableView.contentInset = UIEdgeInsetsMake(0, 0, 15, 0);
    self.supermarketTableView.rowHeight = ShopCartRowHeight;
    self.supermarketTableView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:self.supermarketTableView];
    
    [self.view addSubview:self.tableFooterView];
    
}

- (void)buildReceiptAddressView {

    [self.tableHeadView addSubview:self.receiptAddressView];
    
    if ([[UserInfo sharedUserInfo] hasDefaultAddress]) {
        
        self.receiptAddressView.address = [[UserInfo sharedUserInfo] defaultAddress];
    
    } else {
    
        __weak typeof(self) weakSelf = self;
        
        [AddressData loadMyAddressData:^(AddressData *data, NSError *error) {
            
            if (error == nil) {
                
                [[UserInfo sharedUserInfo] configAllAddress:(NSMutableArray *)data.data];
                weakSelf.receiptAddressView.address = [[UserInfo sharedUserInfo] defaultAddress];
            }
        }];
    }
}

- (void)buildMarketView {

    CGRect frame = CGRectMake(0, 90, SCREEN_WIDTH, 60);
    ShopCartMarketView *marketView = [[ShopCartMarketView alloc] initWithFrame:frame];
    
    [self.tableHeadView addSubview:marketView];
}

- (void)buildSignTimeView {

    CGRect frame = CGRectMake(0, 150, SCREEN_WIDTH, ShopCartRowHeight);
    UIView *signTimeView = [[UIView alloc] initWithFrame:frame];
    signTimeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:signTimeView];
    
    //
    UILabel *signTimeTitleLabel = [[UILabel alloc] init];
    signTimeTitleLabel.text = @"收货时间";
    signTimeTitleLabel.textColor = [UIColor blackColor];
    signTimeTitleLabel.font = [UIFont systemFontOfSize:15];
    [signTimeTitleLabel sizeToFit];
    signTimeTitleLabel.frame = CGRectMake(15, 0, signTimeTitleLabel.width, ShopCartRowHeight);
    [signTimeView addSubview:signTimeTitleLabel];
    
    //
    self.signTimeLabel.frame = CGRectMake(CGRectGetMaxX(signTimeTitleLabel.frame) + 10, 0, SCREEN_WIDTH * 0.5, ShopCartRowHeight);
    self.signTimeLabel.textColor = [UIColor redColor];
    self.signTimeLabel.font = [UIFont systemFontOfSize:15];
    self.signTimeLabel.text = @"闪电送，及时达";
    [signTimeView addSubview:self.signTimeLabel];
    
    //
    self.reserverLabel.frame = CGRectMake(self.view.width - 72, 0, 60, ShopCartRowHeight);
    self.reserverLabel.text = @"可预订";
    self.reserverLabel.textColor = [UIColor redColor];
    self.reserverLabel.font = [UIFont systemFontOfSize:15];
    [signTimeView addSubview:self.reserverLabel];
    
    //
    UIImageView *arrorwImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_go"]];
    arrorwImageView.frame = CGRectMake(self.view.width  -15, (ShopCartRowHeight - arrorwImageView.height) * 0.5, arrorwImageView.width, arrorwImageView.height);
    [signTimeView addSubview:arrorwImageView];
    
}

- (void)buildSignComment {

    self.commentView.frame = CGRectMake(0, 200, self.view.width, ShopCartRowHeight);
    [self.tableHeadView addSubview:self.commentView];
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[UserShopCartTool sharedUserShopCart] getShopCartProducts].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    ShopCartCell *cell = [ShopCartCell shopCartCellInTableView:tableView];
    
    cell.goods = [[UserShopCartTool sharedUserShopCart] getShopCartProducts][indexPath.row];
    
    
    return cell;
}

#pragma mark - <UITableViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    [self.commentView endEditing:YES];
}

@end
