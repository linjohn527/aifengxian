//
//  HomeCell.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/14/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "HomeCell.h"
#import "DiscountPriceView.h"
#import "BuyView.h"
#import "Activities.h"
#import "Goods.h"
#import "UIImageView+WebCache.h"

@interface HomeCell()

/**  */
@property(nonatomic,strong)UIImageView *backImageView;

/**  */
@property(nonatomic,strong)UIImageView *goodsImageView;
/**  */
@property(nonatomic,strong)UILabel *nameLabel;
/**  */
@property(nonatomic,strong)UIImageView *fineImageView;
/**  */
@property(nonatomic,strong)UIImageView *giveImageView;
/**  */
@property(nonatomic,strong)UILabel *specialsLabel;
/**  */
@property(nonatomic,strong)DiscountPriceView *discountPriceView;
/**  */
@property(nonatomic,strong)BuyView *buyView;

@end

@implementation HomeCell

- (UIImageView *)backImageView {

    if (!_backImageView) {
        
        _backImageView = [[UIImageView alloc] init];
    }
    
    return _backImageView;
}

- (UIImageView *)goodsImageView {

    if (!_goodsImageView) {
        
        _goodsImageView = [[UIImageView alloc] init];
        _goodsImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
    return _goodsImageView;
}

- (UILabel *)nameLabel {

    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.font = HOME_COLLECTIONVIEW_TEXTFONT;
        _nameLabel.textColor = [UIColor blackColor];
        
    }
    
    return _nameLabel;
}

- (UIImageView *)fineImageView {

    if (!_fineImageView) {
        
        _fineImageView = [[UIImageView alloc] init];
        _fineImageView.image = [UIImage imageNamed:@"jingxuan.png"];
    }
    
    return _fineImageView;
}

- (UIImageView *)giveImageView {

    if (!_giveImageView) {
        
        _giveImageView = [[UIImageView alloc] init];
        _giveImageView.image = [UIImage imageNamed:@"buyOne.png"];
    }
    
    return _giveImageView;
}

- (UILabel *)specialsLabel {

    if (!_specialsLabel) {
        
        _specialsLabel = [[UILabel alloc] init];
        _specialsLabel.textColor = RGB(100, 100, 100);
        _specialsLabel.font = [UIFont systemFontOfSize:12];
        _specialsLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    
    return _specialsLabel;
}



- (BuyView *)buyView {

    if (!_buyView) {
        
        _buyView = [[BuyView alloc] init];
    }
    
    return _buyView;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    [self addSubview:self.backImageView];
    [self addSubview:self.goodsImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.specialsLabel];
    [self addSubview:self.fineImageView];
    [self addSubview:self.giveImageView];
    [self addSubview:self.discountPriceView];
    [self addSubview:self.buyView];
    
    __weak typeof(*&self) weakSelf = self;
    self.buyView.clickAddShopCart = ^{
    
        if (weakSelf.addButtonClick != nil) {
            
            weakSelf.addButtonClick(weakSelf.goodsImageView);
        }
    };
}

- (void)setType:(HomeCellType)type {

    _type = type;
    
    BOOL isHidden = (type == HomeCellTypeHorizontal);
    self.backImageView.hidden = !isHidden;
    self.goodsImageView.hidden = isHidden;
    self.nameLabel.hidden = isHidden;
    self.fineImageView.hidden =isHidden;
    self.giveImageView.hidden = isHidden;
    self.specialsLabel.hidden = isHidden;
    self.discountPriceView.hidden = isHidden;
    self.buyView.hidden = isHidden;
}

- (void)setActivities:(Activities *)activities {

    _activities = activities;
    
    self.type = HomeCellTypeHorizontal;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:activities.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_full_size"]];
}

- (void)setGoods:(Goods *)goods {

    _goods = goods;
    
    self.type = HomeCellTypeVertical;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goods.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
     
     self.nameLabel.text = goods.name;
    
    if ([goods.pm_desc isEqualToString:@"买一赠一"]) {
        
        self.giveImageView.hidden = NO;
    } else {
    
        self.giveImageView.hidden = YES;
    }
    
    if (self.discountPriceView != nil) {
        
        [self.discountPriceView removeFromSuperview];
    
    }
    
    DiscountPriceView *discountPriceView = [[DiscountPriceView alloc] initWithPrice:goods.price marketPrice:goods.market_price];
    [self addSubview:discountPriceView];
    self.discountPriceView = discountPriceView;
    
    self.buyView.goods = goods;
    
    self.specialsLabel.text = goods.specifics;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.backImageView.frame = self.bounds;
    self.goodsImageView.frame = CGRectMake(0, 0, self.width, self.width);
    self.nameLabel.frame = CGRectMake(5, self.width, self.width - 15, 20);
    self.fineImageView.frame = CGRectMake(self.nameLabel.x, CGRectGetMaxY(self.nameLabel.frame), 30, 15);
    self.giveImageView.frame = CGRectMake(CGRectGetMaxX(self.fineImageView.frame) + 3, CGRectGetMaxY(self.nameLabel.frame), 35, 15);
    self.specialsLabel.frame = CGRectMake(self.nameLabel.x, CGRectGetMaxY(self.fineImageView.frame), self.width, 20);
    self.discountPriceView.frame = CGRectMake(self.nameLabel.x, CGRectGetMaxY(self.specialsLabel.frame), 60, self.height - CGRectGetMaxY(self.specialsLabel.frame));
    self.buyView.frame = CGRectMake(self.width - 85, self.height -30, 80, 25);
}


@end
