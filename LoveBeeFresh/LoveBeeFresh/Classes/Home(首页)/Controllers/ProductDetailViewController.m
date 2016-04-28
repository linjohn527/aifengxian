//
//  ProductDetailViewController.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/21/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "Goods.h"
#import "DiscountPriceView.h"
#import "YelloShopCartView.h"
#import "BuyView.h"
#import "BaseActionSheet.h"
#import "UIImageView+WebCache.h"
#import "DiscountPriceView.h"
#import "UIBarButtonItem+Extension.h"
#import "BaseActionSheet.h"
#import "ShopCartViewController.h"
#import "BaseNavigationController.h"

#define GRAY_BACKGROUD_COLOR RGB(248,248,248)

@interface ProductDetailViewController ()

/**  */
@property(nonatomic,strong)Goods *goods;

/**  */
@property(nonatomic,strong)UIScrollView *scrollView;
/**  */
@property(nonatomic,strong)UIImageView *productImageView;
/**  */
@property(nonatomic,strong)UIView *nameView;
/**  */
@property(nonatomic,strong)UILabel *titleNameLabel;
/**  */
@property(nonatomic,strong)UIView *presentView;
/**  */
@property(nonatomic,strong)UIView *detailView;
/**  */
@property(nonatomic,strong)UILabel *brandTitleLabel;
/**  */
@property(nonatomic,strong)UILabel *detailTitleLabel;
/**  */
@property(nonatomic,strong)UIView *promptView;

/**  */
@property(nonatomic,strong)UIImageView *detailImageView;
/**  */
@property(nonatomic,strong)UIView *bottomView;
/**  */
@property(nonatomic,strong)YelloShopCartView *yellowShopCartView;
/**  */
@property(nonatomic,strong)BuyView *buyView;

/**  */
@property(nonatomic,strong)BaseActionSheet *shareActionsheet;

/**  */
@property(nonatomic,strong)DiscountPriceView *priceView;


@end

@implementation ProductDetailViewController


- (instancetype)init {

    self = [super init];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    //
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = [UIColor whiteColor];
    scrollView.bounces = NO;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    //
    UIImageView *productImageView = [[UIImageView alloc] init];
    productImageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 400);
    productImageView.contentMode = UIViewContentModeScaleAspectFit;
    [scrollView addSubview:productImageView];
    self.productImageView = productImageView;
    
    [self buildLineViewWithFrame:CGRectMake(0, CGRectGetMaxY(productImageView.frame) - 1, SCREEN_WIDTH, 1) inView:productImageView];
    
    //
    CGFloat leftMargin = 15;
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(productImageView.frame), SCREEN_WIDTH, 80)];
    nameView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:nameView];
    self.nameView = nameView;
    
    //
    UILabel *titleNameLabel = [[UILabel alloc] init];
    titleNameLabel.frame = CGRectMake(leftMargin, 0, SCREEN_WIDTH, 60);
    titleNameLabel.textColor = [UIColor blackColor];
    titleNameLabel.font = [UIFont systemFontOfSize:16];
    [nameView addSubview:titleNameLabel];
    self.titleNameLabel = titleNameLabel;
    
    [self buildLineViewWithFrame:CGRectMake(0, 80 - 1, SCREEN_WIDTH, 1) inView:nameView];
    
    //
    UIView *presentView = [[UIView alloc] init];
    presentView.frame = CGRectMake(0, CGRectGetMaxY(nameView.frame), SCREEN_WIDTH, 50);
    presentView.backgroundColor = RGB(248, 248, 248);
    [scrollView addSubview:presentView];
    self.presentView = presentView;
    
    //
    UIButton *presentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    presentButton.frame = CGRectMake(leftMargin, 13, 55, 24);
    [presentButton setTitle:@"促销" forState:UIControlStateNormal];
    presentButton.backgroundColor = RGB(252, 85, 88);
    presentButton.layer.cornerRadius = 8;
    [presentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [presentView addSubview:presentButton];
    
    //
    UILabel *presentLabel = [[UILabel alloc] init];
    presentLabel.frame = CGRectMake(100, 0, SCREEN_WIDTH * 0.7, 50);
    presentLabel.textColor = [UIColor whiteColor];
    presentLabel.font = [UIFont systemFontOfSize:14];
    presentLabel.text = @"买一赠一,送完为止";
    [presentView addSubview:presentLabel];
    
    [self buildLineViewWithFrame:CGRectMake(0, CGRectGetMaxY(presentView.frame), SCREEN_WIDTH, 1) inView:presentView];
    
    //
    UIView *detailView = [[UIView alloc] init];
    detailView.frame = CGRectMake(0, CGRectGetMaxY(presentView.frame), SCREEN_WIDTH, 150);
    detailView.backgroundColor = GRAY_BACKGROUD_COLOR;
    [scrollView addSubview:detailView];
    self.detailView = detailView;
    
    //
    UILabel *brandLabel = [[UILabel alloc] init];
    brandLabel.frame = CGRectMake(leftMargin, 0, 80, 50);
    brandLabel.textColor = RGB(150, 150, 150);
    brandLabel.text = @"品   牌";
    brandLabel.font = [UIFont systemFontOfSize:14];
    [detailView addSubview:brandLabel];
    
    //
    UILabel *brandTitleLabel = [[UILabel alloc] init];
    brandTitleLabel.frame = CGRectMake(100, 0, SCREEN_WIDTH * 0.6, 50);
    brandTitleLabel.font = [UIFont systemFontOfSize:14];
    brandTitleLabel.textColor = [UIColor blackColor];
    [detailView addSubview:brandTitleLabel];
    self.brandTitleLabel = brandTitleLabel;
    
    [self buildLineViewWithFrame:CGRectMake(0, CGRectGetMaxY(detailView.frame), SCREEN_WIDTH, 1) inView:detailView];
    
    //
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.frame = CGRectMake(leftMargin,50, 80, 50);
    detailLabel.textColor = [UIColor blackColor];
    detailLabel.font = [UIFont systemFontOfSize:14];
    detailLabel.text = @"产品规格";
    [detailView addSubview:detailLabel];
    
    //
    UILabel *detailTitleLabel = [[UILabel alloc] init];
    detailTitleLabel.frame = CGRectMake(100, 50, SCREEN_WIDTH * 0.6, 50);
    detailTitleLabel.font = [UIFont systemFontOfSize:14];
    detailTitleLabel.textColor = [UIColor blackColor];
    [detailView addSubview:detailTitleLabel];
    self.detailTitleLabel = detailTitleLabel;
    
    [self buildLineViewWithFrame:CGRectMake(0, CGRectGetMaxY(detailLabel.frame) - 1,SCREEN_WIDTH, 1) inView:detailView];
    
    //
    UILabel *textImageLabel = [[UILabel alloc] init];
    textImageLabel.frame = CGRectMake(leftMargin, 100, 80, 80);
    textImageLabel.font = brandLabel.font;
    textImageLabel.textColor = brandLabel.textColor;
    textImageLabel.text = @"图文详情";
    [detailView addSubview:textImageLabel];
    
    
    //
    UIView *promptView = [[UIView alloc] init];
    promptView.frame = CGRectMake(0, CGRectGetMaxY(detailView.frame), SCREEN_WIDTH, 80);
    promptView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:promptView];
    self.promptView = promptView;
    
    //
    UILabel *promptLabel = [[UILabel alloc] init];
    promptLabel.frame = CGRectMake(leftMargin, 5, SCREEN_WIDTH, 20);
    promptLabel.text = @"温馨提示";
    promptLabel.textColor = [UIColor blackColor];
    [promptView addSubview:promptLabel];
    
    //
    UILabel *promptDetailLabel = [[UILabel alloc] init];
    promptDetailLabel.frame = CGRectMake(leftMargin, 25, SCREEN_WIDTH - 30, 60);
    promptDetailLabel.textColor = presentButton.backgroundColor;
    promptDetailLabel.numberOfLines = 2;
    promptDetailLabel.font = [UIFont systemFontOfSize:14];
    promptDetailLabel.text = @"商品签收后, 如有问题请您在24小时内联系4008484842,并将商品及包装保留好,拍照发给客服";
    [promptView addSubview:promptDetailLabel];
    
    [self buildLineViewWithFrame:CGRectMake(0, CGRectGetMaxY(promptView.frame) - 1, SCREEN_WIDTH, 1) inView:promptView];
    
    //
    UIView *bottomView = [[UIView alloc] init];
    bottomView.frame = CGRectMake(0, SCREEN_HEIGHT - 50 - NavigationH , SCREEN_WIDTH, 50);
    bottomView.backgroundColor = RGB(248, 248, 248);
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    
    //
    UILabel *addProductLabel = [[UILabel alloc] init];
    addProductLabel.frame = CGRectMake(leftMargin, 0, 70, 50);
    addProductLabel.textColor = [UIColor blackColor];
    addProductLabel.font = [UIFont systemFontOfSize:14];
    addProductLabel.text = @"添加商品";
    [bottomView addSubview:addProductLabel];
    
}


- (instancetype)initWithGoods:(Goods *)goods {

    self = [self init];
    
    self.goods = goods;
    
    //
    [self.productImageView sd_setImageWithURL:[NSURL URLWithString:goods.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
    
    self.titleNameLabel.text = goods.name;
    self.priceView = [[DiscountPriceView alloc] initWithPrice:goods.price marketPrice:goods.market_price];
    self.priceView.frame = CGRectMake(15, 40, SCREEN_WIDTH * 0.6, 40);
    
    [self.nameView addSubview:self.priceView];
    
    if ([goods.pm_desc isEqualToString:@"买一赠一"]) {
        
        self.presentView.height = 50;
        self.presentView.hidden = NO;
    
    } else {
    
        self.presentView.height = 0;
        self.presentView.hidden = YES;
        self.detailView.y -= 50;
        self.promptView.y -= 50;
    }
    
    self.brandTitleLabel.text = goods.brand_name;
    self.detailTitleLabel.text = goods.specifics;
    
    self.detailImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aaaa"]];
    
    CGFloat scale = 320 / SCREEN_WIDTH;
    self.detailImageView.frame = CGRectMake(0, CGRectGetMaxY(self.promptView.frame), SCREEN_WIDTH, self.detailImageView.height / scale);
    
    [self.scrollView addSubview:self.detailImageView];
    self.scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetMaxY(self.detailImageView.frame) + NavigationH + 50);
    
    self.buyView = [[BuyView alloc] init];
    self.buyView.frame = CGRectMake(85, 12, 80, 25);
    self.buyView.zeroIsShow = YES;
    self.buyView.goods = goods;
    [self.bottomView addSubview:self.buyView];
    
    CGRect frame = CGRectMake(SCREEN_WIDTH - 70, 50 - 61 - 10, 61, 61);
    __weak typeof(self) weakSelf = self;
    self.yellowShopCartView = [[YelloShopCartView alloc] initWithFrame:frame shopcartClick:^{
        
        ShopCartViewController *shopcartVC = [[ShopCartViewController alloc] init];
        
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:shopcartVC];
        
        [weakSelf presentViewController:nav animated:YES completion:nil];
    }];
    
    [self.bottomView addSubview:self.yellowShopCartView];
    
    //
    
    [self buildNavigationItem];
    
    
    return self;
}

- (void)buildNavigationItem {

    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"分享" titleColor:RGB(100, 100, 100) target:self action:@selector(rightItemClick)];

}

- (void)rightItemClick {

    [BaseActionSheet showActionSheetInVC:self selectedShareType:^(ShareType type) {
        
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = NAVIGATION_WHITE_COLOR;
}

- (void)buildLineViewWithFrame:(CGRect)frame inView:(UIView *)view {

    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.alpha = 0.1;
    lineView.backgroundColor = [UIColor blackColor];
    [view addSubview:lineView];
}

@end
