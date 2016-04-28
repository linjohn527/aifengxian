//
//  DiscountPriceView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/14/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "DiscountPriceView.h"
#import "NSString+Extension.h"

@interface DiscountPriceView ()

/**  */
@property(nonatomic,strong)UILabel *marketPriceLabel;
/**  */
@property(nonatomic,strong)UILabel *priceLabel;
/**  */
@property(nonatomic,strong)UIView *lineView;
/**  */
@property(assign,nonatomic)BOOL hasMarketPrice;
/**  */
@property(copy,nonatomic)UIColor *priceColor;
/**  */
@property(copy,nonatomic)UIColor *marketPriceColor;


@end

@implementation DiscountPriceView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}


- (void)setup {

    UILabel *marketPriceLabel = [[UILabel alloc] init];
    marketPriceLabel.textColor = RGB(80, 80, 80);
    marketPriceLabel.font = HOME_COLLECTIONVIEW_TEXTFONT;
    [self addSubview:marketPriceLabel];
    self.marketPriceLabel = marketPriceLabel;
    
    //
    UILabel *priceLabel = [[UILabel alloc] init];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = HOME_COLLECTIONVIEW_TEXTFONT;
    [self addSubview:priceLabel];
    self.priceLabel = priceLabel;
    
    //
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = RGB(80, 80, 80);
    [self.marketPriceLabel addSubview:lineView];
     self.lineView = lineView;
}

- (instancetype)initWithPrice:(NSString *)price marketPrice:(NSString *)marketPrice {

    self = [self init];
    
    if (price != nil && price.length > 0) {
        
        self.priceLabel.text = [NSString stringWithFormat:@"$%@",[price cleanDecimalPointZero]];
        
        [self.priceLabel sizeToFit];
    }
    
    if (marketPrice != nil && marketPrice.length > 0) {
        
        self.marketPriceLabel.text = [NSString stringWithFormat:@"$%@",[marketPrice cleanDecimalPointZero]];
        
        self.hasMarketPrice = YES;
        [self.marketPriceLabel sizeToFit];
        
    } else {
    
        self.hasMarketPrice = NO;
    }
    
    if (price == marketPrice) {
        
        self.hasMarketPrice = NO;
    
    } else {
    
        self.hasMarketPrice = YES;
    }
    
    self.marketPriceLabel.hidden = !self.hasMarketPrice;
    
    return self;
}

- (void)setMarketPriceColor:(UIColor *)marketPriceColor {

    _marketPriceColor = marketPriceColor;
    if (self.marketPriceLabel != nil) {
        
        self.marketPriceLabel.textColor = marketPriceColor;
    }
    if (self.lineView != nil) {
        
        self.lineView.backgroundColor = marketPriceColor;
    }
}

- (void)setPriceColor:(UIColor *)priceColor {

    _priceColor = priceColor;
    
    if (self.priceLabel != nil) {
        
        self.priceLabel.textColor = priceColor;
    }
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.priceLabel.frame = CGRectMake(0, 0, self.priceLabel.width, self.height);
    self.marketPriceLabel.frame = CGRectMake(CGRectGetMaxX(self.priceLabel.frame) + 3, 0, self.marketPriceLabel.width + 5, self.height);
    self.lineView.frame = CGRectMake(0, self.marketPriceLabel.height * 0.5 - 0.5, self.marketPriceLabel.width, 1);
    
}

@end
