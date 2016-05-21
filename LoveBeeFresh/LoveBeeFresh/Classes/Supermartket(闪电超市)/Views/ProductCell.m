//
//  ProductCell.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/17/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ProductCell.h"
#import "BuyView.h"
#import "DiscountPriceView.h"
#import "UIImageView+WebCache.m"
#import "Goods.h"

@interface ProductCell ()

/**  */
@property(nonatomic,strong)UIImageView *goodsImageView;
/**  */
@property(nonatomic,strong)UILabel *nameLabel;
/**  */
@property(nonatomic,strong)UIImageView *fineImageView;
/**  */
@property(nonatomic,strong)UIImageView *giftImageView;
/**  */
@property(nonatomic,strong)UILabel *specificsLabel;
/**  */
@property(nonatomic,strong)BuyView *buyView;
/**  */
@property(nonatomic,strong)UIView *lineView;
/**  */
@property(nonatomic,strong)DiscountPriceView *discountPriceView;


@end

@implementation ProductCell

- (UIImageView *)goodsImageView {

    if (!_goodsImageView) {
        
        _goodsImageView = [[UIImageView alloc] init];
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
        
        _fineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jingxuan.png"]];
    }
    
    return _fineImageView;
}

- (UIImageView *)giftImageView {

    if (!_giftImageView) {
        
        _giftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"buyOne.png"]];
    }
    
    return _giftImageView;
}

- (UILabel *)specificsLabel {

    if (!_specificsLabel) {
        
        _specificsLabel = [[UILabel alloc] init];
        _specificsLabel.textColor = RGB(100, 100, 100);
        _specificsLabel.font = [UIFont systemFontOfSize:12];
        _specificsLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _specificsLabel;
}

- (BuyView *)buyView {

    if (!_buyView) {
        
        _buyView = [[BuyView alloc] init];
    }
    
    return _buyView;
}

- (UIView *)lineView {

    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(100, 100, 100);
        _lineView.alpha = 0.1;
    }
    
    return _lineView;
}

- (DiscountPriceView *)discountPriceView {

    if (!_discountPriceView) {
        
        _discountPriceView = [[DiscountPriceView alloc] init];
    }
    
    return _discountPriceView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.goodsImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.fineImageView];
    [self.contentView addSubview:self.giftImageView];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.specificsLabel];
    [self.contentView addSubview:self.buyView];
    
    __weak typeof(self) weakSelf = self;
    self.buyView.clickAddShopCart = ^{
    
        !weakSelf.addProductClick?:weakSelf.addProductClick(weakSelf.goodsImageView);
    };
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {

    static NSString *identifier = @"cell";
    ProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        
        cell = [[ProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    return cell;
}

- (void)setGoods:(Goods *)goods {

    _goods = goods;
    
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:goods.img] placeholderImage:[UIImage imageNamed:@"v2_placeholder_square"]];
    self.nameLabel.text = goods.name;
    
    if ([goods.pm_desc isEqualToString:@"买一赠一"]) {
        
        self.giftImageView.hidden = false;
    
    } else {
    
        self.giftImageView.hidden = YES;
    }
    
    if(goods.is_xf == 1) {
    
        self.fineImageView.hidden = false;
        
    } else {
    
        self.fineImageView.hidden = YES;
    }
    
    if (self.discountPriceView != nil) {
        
        [self.discountPriceView removeFromSuperview];
    }
    
    self.discountPriceView = [[DiscountPriceView alloc] initWithPrice:goods.price marketPrice:goods.market_price];
    [self addSubview:self.discountPriceView];
    
    self.specificsLabel.text = goods.specifics;
    self.buyView.goods = goods;
    
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.goodsImageView.frame = CGRectMake(0, 0, self.height, self.height);
    self.fineImageView.frame = CGRectMake(CGRectGetMaxX(self.goodsImageView.frame), HotViewMargin, 30, 16);
    
    if (self.fineImageView.hidden) {
        
        self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.goodsImageView.frame) + 3, HotViewMargin - 2, self.width - CGRectGetMaxX(self.goodsImageView.frame), 20);
    } else {
    
        self.nameLabel.frame = CGRectMake(CGRectGetMaxX(self.fineImageView.frame) + 3, HotViewMargin - 2, self.width - CGRectGetMaxX(self.goodsImageView.frame), 20);
    }
    
    self.giftImageView.frame = CGRectMake(CGRectGetMaxX(self.goodsImageView.frame), CGRectGetMaxY(self.nameLabel.frame), 35, 15);
    self.specificsLabel.frame = CGRectMake(CGRectGetMaxX(self.goodsImageView.frame), CGRectGetMaxY(self.giftImageView.frame), self.width, 20);
    self.discountPriceView.frame = CGRectMake(CGRectGetMaxX(self.goodsImageView.frame), CGRectGetMaxY(self.specificsLabel.frame), 60, self.height - CGRectGetMaxY(self.specificsLabel.frame));
    self.lineView.frame = CGRectMake(HotViewMargin, self.height - 1, self.width - HotViewMargin, 1);
    self.buyView.frame = CGRectMake(self.width - 85, self.height - 30, 80, 25);
}

@end
