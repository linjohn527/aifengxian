//
//  YelloShopCartView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/21/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "YelloShopCartView.h"
#import "ShopCartRedDotView.h"

@interface YelloShopCartView ()

/**  */
@property(copy,nonatomic)void(^shopcartClick)();

/**  */
@property(nonatomic,strong)UIImageView *yelloImageView;
/**  */
@property(nonatomic,strong)UIImageView *yelloShopCartImageView;

/**  */
@property(nonatomic,strong)ShopCartRedDotView *reddotView;

@end

@implementation YelloShopCartView

- (UIImageView *)yelloImageView {

    if (!_yelloImageView) {
        
        _yelloImageView = [[UIImageView alloc] init];
    }
    
    return _yelloImageView;
}

- (UIImageView *)yelloShopCartImageView {

    if (!_yelloShopCartImageView) {
        
        _yelloShopCartImageView = [[UIImageView alloc] init];
    }
    
    return _yelloShopCartImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup {

    //
    self.yelloImageView.image = [UIImage imageNamed:@"v2_shopNoBorder"];
    [self addSubview:self.yelloImageView];
    
    //
    self.yelloShopCartImageView.image = [UIImage imageNamed:@"v2_whiteShopBig"];
    [self addSubview:self.yelloShopCartImageView];
    
    //
    self.reddotView = [ShopCartRedDotView shareRedDotView];
    [self addSubview:self.reddotView];
    
    //
    self.userInteractionEnabled = YES;
    
}

- (instancetype)initWithFrame:(CGRect)frame shopcartClick:(void (^)())shopcartClick {

    self = [self initWithFrame:frame];
    
    self.shopcartClick = shopcartClick;
    
    //
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showShopCartView)];
    
    [self addGestureRecognizer:tap];
    
    return self;
}

- (void)showShopCartView {

    !self.shopcartClick?:self.shopcartClick();
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.yelloImageView.frame = CGRectMake(0, 0, 61, 61);
    self.yelloShopCartImageView.frame = CGRectMake((61 - 45) * 0.5, (61 - 45) * 0.5, 45, 45);
    self.reddotView.frame = CGRectMake(self.width - 20, 0, 20, 20);
}

@end
