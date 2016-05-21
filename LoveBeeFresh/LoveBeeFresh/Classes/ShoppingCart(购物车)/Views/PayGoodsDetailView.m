//
//  PayGoodsDetailView.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/13/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "PayGoodsDetailView.h"
#import "Goods.h"

@interface PayGoodsDetailView ()

/**  */
@property(nonatomic,strong)UILabel *titleLabel;
/**  */
@property(nonatomic,strong)UILabel *numberLabel;
/**  */
@property(nonatomic,strong)UILabel *priceLabel;
/**  */
@property(nonatomic,strong)UIImageView *giftImageV;

/**  */
@property(assign,nonatomic)BOOL isShowImageV;


@end

@implementation PayGoodsDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame: frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
    
}

- (void)setup {

    //
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_titleLabel];
    
    //
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = [UIFont systemFontOfSize:13];
    _numberLabel.textColor = [UIColor blackColor];
    _numberLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_numberLabel];
    
    //
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor blackColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_priceLabel];
    
    //
    _giftImageV = [[UIImageView alloc] init];
    _giftImageV.hidden = YES;
    _giftImageV.image = [UIImage imageNamed:@"zengsong"];
    [self addSubview:_giftImageV];
    
}


- (void)setGoods:(Goods *)goods {

    _goods = goods;
    
    //
    if (goods.is_xf) {
        
        _titleLabel.text = [NSString stringWithFormat:@"[精选]%@",goods.name];
    } else {
    
        _titleLabel.text = goods.name;
    }
    
    //
    _numberLabel.text = [NSString stringWithFormat:@"x%i",goods.userBuyNumber];
    _priceLabel.text = [NSString stringWithFormat:@"$%@",[goods.price cleanDecimalPointZero]];
    
    if (![goods.pm_desc isEqualToString:@"买一赠一"]) {
        
        _giftImageV.hidden = YES;
        _isShowImageV = NO;
        [self layoutSubviews];
    
    } else {
    
        _giftImageV.hidden = NO;
        _isShowImageV = YES;
        _priceLabel.hidden = YES;
        _titleLabel.text = [NSString stringWithFormat:@"[精选]%@赠",goods.name];
        
    }
}


- (void)layoutSubviews {

    [super layoutSubviews];
    
    if (_isShowImageV) {
        
        _giftImageV.frame = CGRectMake(15, (self.height - 20) * 0.5, 40, 20);
        _titleLabel.frame = CGRectMake(CGRectGetMaxX(_giftImageV.frame) + 5, 0, self.width * 0.5, self.height);
        _numberLabel.frame = CGRectMake(SCREEN_WIDTH * 0.7, 0, 50,self.height);
    
    } else {
    
        _titleLabel.frame = CGRectMake(15, 0, self.width * 0.6, self.height);
        _numberLabel.frame = CGRectMake(SCREEN_WIDTH * 0.7, 0, 50, self.height);
    }
    
    _priceLabel.frame = CGRectMake(self.width - 60 - 10, 0, 60, 20);
}

@end
