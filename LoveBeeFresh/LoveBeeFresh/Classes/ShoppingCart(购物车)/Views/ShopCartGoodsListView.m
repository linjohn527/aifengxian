//
//  ShopCartGoodsListView.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/13/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ShopCartGoodsListView.h"
#import "UserShopCartTool.h"
#import "Goods.h"
#import "PayGoodsDetailView.h"

@interface ShopCartGoodsListView ()


/**  */
@property(assign,nonatomic)CGFloat lastViewY;


@end

@implementation ShopCartGoodsListView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    self.backgroundColor = [UIColor whiteColor];
    
    //
    NSArray *goodsArr = [[UserShopCartTool sharedUserShopCart] getShopCartProducts];
    
    for (NSUInteger i = 0; i < goodsArr.count; i++) {
        
        Goods *goods = goodsArr[i];
        
        [self buildLineViewWithFrame:CGRectMake(15, _lastViewY, SCREEN_WIDTH - 15, 1)];
        
        if (![goods.pm_desc isEqualToString:@"买一赠一"]) {
            
            PayGoodsDetailView *goodsDetailView = [[PayGoodsDetailView alloc] init];
            goodsDetailView.frame = CGRectMake(0, _lastViewY + 10, SCREEN_WIDTH, 20);
            goodsDetailView.goods = goods;
            [self addSubview:goodsDetailView];
            
            _lastViewY += 40;
            _goodsHeight += 40;
            
        } else {
        
            PayGoodsDetailView *goodsDetailView = [[PayGoodsDetailView alloc] init];
            goodsDetailView.frame = CGRectMake(0, _lastViewY + 10, SCREEN_WIDTH, 20);
            goods.pm_desc = @"";
            goodsDetailView.goods = goods;
            [self addSubview:goodsDetailView];
            
            _lastViewY += 30;
            
            //
            PayGoodsDetailView *giftView = [[PayGoodsDetailView alloc] init];
            giftView.frame = CGRectMake(0, _lastViewY, SCREEN_WIDTH, 20);
            goods.pm_desc = @"买一赠一";
            giftView.goods = goods;
            [self addSubview:giftView];
            
            _lastViewY += 30;
            _goodsHeight += 60;
            
        }
        
    }
    
    //
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, _lastViewY - 0.5, SCREEN_WIDTH - 15, 0.5)];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    [self addSubview:lineView];
    
    _goodsHeight += 40;
    
    //
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, _lastViewY, SCREEN_WIDTH - 60, 50)];
    priceLabel.textAlignment = NSTextAlignmentRight;
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = [UIFont systemFontOfSize:14];
    priceLabel.text = [NSString stringWithFormat:@"共$%@",[[UserShopCartTool sharedUserShopCart] getAllProductsPrice]];
    [self addSubview:priceLabel];
    
    //
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, _goodsHeight - 1, SCREEN_WIDTH, 1)];
    lineView2.backgroundColor = [UIColor blackColor];
    lineView2.alpha = 0.1;
    [self addSubview:lineView2];
}

- (void)buildLineViewWithFrame:(CGRect)frame {

    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    [self addSubview:lineView];
}

@end
