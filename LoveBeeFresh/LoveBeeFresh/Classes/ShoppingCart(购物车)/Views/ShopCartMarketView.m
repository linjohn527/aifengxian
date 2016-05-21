//
//  ShopCartMarketView.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/3/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ShopCartMarketView.h"

#define MARKET_HEIGHT 60

@implementation ShopCartMarketView

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
    UIView *lineView = [self lineView:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    [self addSubview:lineView];
    
    //
    UIImageView *rocketImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_lighting"]];
    rocketImageView.frame = CGRectMake(15, 5, 20, 20);
    [self addSubview:rocketImageView];
    
    //
    UIImageView *reddotImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reddot"]];
    reddotImageView.frame = CGRectMake(15, (MARKET_HEIGHT - CGRectGetMaxY(rocketImageView.frame) - 4) * 0.5 + CGRectGetMaxY(rocketImageView.frame), 4, 4);
    
    [self addSubview:reddotImageView];
    
    //
    UILabel *marketTitleLabel = [[UILabel alloc] init];
    marketTitleLabel.frame = CGRectMake(CGRectGetMaxX(rocketImageView.frame) + 10, 5, SCREEN_WIDTH * 0.6, 20);
    marketTitleLabel.text = @"闪电超市";
    marketTitleLabel.font = [UIFont systemFontOfSize:12];
    marketTitleLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:marketTitleLabel];
    
    //
    UILabel *marketLabel = [[UILabel alloc] init];
    marketLabel.frame = CGRectMake(CGRectGetMaxX(reddotImageView.frame) + 5, CGRectGetMaxY(rocketImageView.frame), SCREEN_WIDTH * 0.7, MARKET_HEIGHT - CGRectGetMaxY(rocketImageView.frame));
    marketLabel.font = [UIFont systemFontOfSize:10];
    marketLabel.textColor = [UIColor lightGrayColor];
    marketLabel.text = @"  22:00前满$30免运费,22:00后满$50面运费  ";
    [self addSubview:marketLabel];
    
    //
    //
    UIView *lineView2 = [self lineView:CGRectMake(0, MARKET_HEIGHT - 0.5, SCREEN_WIDTH, 0.5)];
    [self addSubview:lineView2];
    
}

- (UIView *)lineView:(CGRect)frame  {

    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.alpha = 0.1;
    lineView.backgroundColor = [UIColor blackColor];
    
    return lineView;
}

@end
