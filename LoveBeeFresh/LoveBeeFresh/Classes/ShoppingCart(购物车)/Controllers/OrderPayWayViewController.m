//
//  OrderPayWayViewController.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "OrderPayWayViewController.h"
#import "PayView.h"
#import "ShopCartGoodsListView.h"
#import "CostDetailView.h"
#import "UserShopCartTool.h"

#define LEFT_MARGIN 15

@interface OrderPayWayViewController ()

/**  */
@property(nonatomic,strong)UIScrollView *scrollView;
/**  */
@property(nonatomic,strong)UIView *tableHeaderView;



@end

@implementation OrderPayWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setup];
    
    [self buildNavigationItem];
    
    [self buildScrollView];
}

- (void)setup {

    _scrollView = [[UIScrollView alloc] init];
    _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 50);
    
    _tableHeaderView = [[UIView alloc] init];
    _tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40 + 15 + 190 + 30);
    
}

- (void)buildNavigationItem {

    self.navigationItem.title = @"结算付款";
    
}

- (void)buildScrollView {

    _scrollView.contentSize = CGSizeMake(0, 10000);
    _scrollView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_scrollView];
    
    [self buildTableHeaderView];
    
    [_scrollView addSubview:_tableHeaderView];
}

- (void)buildTableHeaderView {

    _tableHeaderView.backgroundColor = [UIColor clearColor];
    
    [self buildCoupView];
    [self buildPayView];
    [self buildCarefullyView];
}

- (void)buildCoupView {

    UIView *couponView = [[UIView alloc] init];
    couponView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    couponView.backgroundColor = [UIColor whiteColor];
    [_tableHeaderView addSubview:couponView];
    
    UIImageView *couponImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"v2_submit_Icon"]];
    couponImageView.frame = CGRectMake(LEFT_MARGIN, 10, 20, 20);
    [couponView addSubview:couponImageView];
    
    UILabel *couponLabel = [[UILabel alloc] init];
    couponLabel.frame = CGRectMake(CGRectGetMaxX(couponImageView.frame) + 10, 0, SCREEN_WIDTH * 0.4, 40);
    couponLabel.text = @"一张优惠券";
    couponLabel.textColor = [UIColor redColor];
    couponLabel.font = [UIFont systemFontOfSize:14];
    [couponView addSubview:couponLabel];
    
    //
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_go"]];
    arrowImageView.frame = CGRectMake(SCREEN_WIDTH - LEFT_MARGIN, 15, 5, 10);
    [couponView addSubview:arrowImageView];
    
    //
    UIButton *checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    checkBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 0, 40, 40);
    [checkBtn setTitle:@"查看" forState:UIControlStateNormal];
    [checkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    checkBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [couponView addSubview:checkBtn];
    
    //
    [self buildLineViewForView:couponView withFrame:CGRectMake(0, 40 - 1, SCREEN_WIDTH, 1)];
    
    
}

- (void)buildPayView {

    UIView *payView = [[UIView alloc] init];
    payView.frame = CGRectMake(0, 55, SCREEN_WIDTH, 190);
    payView.backgroundColor = [UIColor whiteColor];
    [_tableHeaderView addSubview:payView];

    //
    [self buildLableForView:payView withFrame:CGRectMake(LEFT_MARGIN, 0, 150, 30) textColor:[UIColor lightGrayColor] title:@"选择支付方式" font:[UIFont systemFontOfSize:12]];
    
    //
    PayView *payV = [[PayView alloc] init];
    payV.frame = CGRectMake(0, 30, SCREEN_WIDTH, 160);
    [payView addSubview:payV];
    
    //
    [self buildLineViewForView:payV withFrame:CGRectMake(0, 189, SCREEN_WIDTH, 1)];
    
}

- (void)buildCarefullyView {

    UIView *carefullyView = [[UIView alloc] init];
    carefullyView.frame = CGRectMake(0, 40+15+190+15, SCREEN_WIDTH, 30);
    carefullyView.backgroundColor = [UIColor whiteColor];
    [_tableHeaderView addSubview:carefullyView];
    
     //
    [self buildLableForView:carefullyView withFrame:CGRectMake(LEFT_MARGIN, 0, 150, 30) textColor:[UIColor lightGrayColor] title:@"精选商品" font:[UIFont systemFontOfSize:12]];
    
    //
    ShopCartGoodsListView *goodsListView = [[ShopCartGoodsListView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(carefullyView.frame), SCREEN_WIDTH, 300)];
    goodsListView.height = goodsListView.goodsHeight;
    [_scrollView addSubview:goodsListView];
    
    //
    CostDetailView *costDetailView = [[CostDetailView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(goodsListView.frame) + 10, SCREEN_WIDTH, 135)];
    [_scrollView addSubview:costDetailView];
    
    _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(costDetailView.frame) + 15);
    
    //
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50 -64, SCREEN_WIDTH, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self buildLineViewForView:bottomView withFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    [self.view addSubview:bottomView];
    
    //
    [self buildLableForView:bottomView withFrame:CGRectMake(LEFT_MARGIN, 0, 80, 50) textColor:[UIColor blackColor] title:@"实付金额" font:[UIFont systemFontOfSize:14]];
    
    
    NSString *priceText = [[UserShopCartTool sharedUserShopCart] getAllProductsPrice];
    
    if ([priceText floatValue] < 30) {
        
        priceText = [[NSString stringWithFormat:@"%.2f",[priceText floatValue] + 8] cleanDecimalPointZero];
    }
    
    [self buildLableForView:bottomView withFrame:CGRectMake(85, 0, 150, 50) textColor:[UIColor redColor] title:[NSString stringWithFormat:@"$%@",priceText] font:[UIFont systemFontOfSize:14]];
    
    //
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    payButton.frame = CGRectMake(SCREEN_WIDTH - 100, 1, 100, 49);
    payButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [payButton setTitle:@"确认付款" forState:UIControlStateNormal];
    payButton.backgroundColor = NAVIGATION_YELLOW_COLOR;
    [payButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bottomView addSubview:payButton];
    
}


- (void)buildLineViewForView:(UIView *)view withFrame:(CGRect)frame {

    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.3;
    [view addSubview:lineView];
}


- (void)buildLableForView:(UIView *)view withFrame:(CGRect)frame textColor:(UIColor *)textColor title:(NSString *)title font:(UIFont *)font {

    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = textColor;
    label.text = title;
    label.font = font;
    
    [view addSubview:label];
}

@end
