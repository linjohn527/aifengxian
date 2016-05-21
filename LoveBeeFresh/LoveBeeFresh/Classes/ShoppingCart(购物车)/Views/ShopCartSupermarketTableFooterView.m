//
//  ShopCartSupermarketTableFooterView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/29/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ShopCartSupermarketTableFooterView.h"
#import "UserShopCartTool.h"


@interface ShopCartSupermarketTableFooterView ()

/**  */
@property(nonatomic,strong)UILabel *titleLabel;
/**  */
@property(nonatomic,strong)UIButton *deciseButton;



/**  */
@property(copy,nonatomic)void(^DeciseButtonClick)();


@end

@implementation ShopCartSupermarketTableFooterView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self buildView];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame deciseButtonClick:(void (^)())deciseButtonClick {

    self = [self initWithFrame:frame];
    
    _DeciseButtonClick = deciseButtonClick;
    
    return self;
}

- (void)buildView {

    UIView *backView = [[UIView alloc] init];
    backView.frame = CGRectMake(0, 0, SCREEN_WIDTH, ShopCartRowHeight);
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    //
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"共$";
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor redColor];
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(15, (ShopCartRowHeight - _titleLabel.height) * 0.5, _titleLabel.width, _titleLabel.height);
    [self addSubview:_titleLabel];
    
    
    //
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:14];
     _priceLabel.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame), 0, SCREEN_WIDTH * 0.5, ShopCartRowHeight);
    _priceLabel.text = [[UserShopCartTool sharedUserShopCart] getAllProductsPrice];
    
    [self addSubview:_priceLabel];
    
    //
    _deciseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _deciseButton.backgroundColor = NAVIGATION_YELLOW_COLOR;
    [_deciseButton setTitle:@"选好了" forState:UIControlStateNormal];
    [_deciseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _deciseButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_deciseButton addTarget:self action:@selector(deciseButtonClick) forControlEvents:UIControlEventTouchUpInside];
    _deciseButton.frame = CGRectMake(SCREEN_WIDTH - 90, 0, 90, ShopCartRowHeight);
    [self addSubview:_deciseButton];
    
    //
    UIView *lineView = [self lineViewWithFrame:CGRectMake(0, ShopCartRowHeight - 0.5, SCREEN_WIDTH, 0.5)];
    [self addSubview:lineView];
}

- (UIView *)lineViewWithFrame:(CGRect)frame {
    
    UIView *lineView = [[UIView alloc] initWithFrame:frame];
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    
    return lineView;
}

- (void)deciseButtonClick {

    !_DeciseButtonClick?:_DeciseButtonClick();
}
@end
