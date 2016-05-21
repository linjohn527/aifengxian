//
//  ShopCartCell.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/4/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ShopCartCell.h"
#import "Goods.h"
#import "BuyView.h"
#import "NSString+Extension.h"

@interface ShopCartCell ()

/**  */
@property(nonatomic,strong)UILabel *titleLabel;
/**  */
@property(nonatomic,strong)UILabel *priceLabel;

/**  */
@property(nonatomic,strong)BuyView *buyView;
/**  */
@property(nonatomic,strong)UIView *lineView;


@end

@implementation ShopCartCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
    
}

- (void)setup {

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont systemFontOfSize:15];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    
    //
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.textColor = [UIColor blackColor];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLabel];
    
    //
    _buyView = [[BuyView alloc] init];
    [self.contentView addSubview:_buyView];
    
    //
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor blackColor];
    _lineView.alpha = 0.1;
    [self.contentView addSubview:_lineView];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(15, 0, SCREEN_WIDTH * 0.5, ShopCartRowHeight);
    _buyView.frame = CGRectMake(SCREEN_WIDTH - 85, (ShopCartRowHeight - 25) * 0.5, 80, 25);
    _priceLabel.frame = CGRectMake(CGRectGetMinX(_buyView.frame) - 100 - 5, 0, 100, ShopCartRowHeight);
    _lineView.frame = CGRectMake(10, ShopCartRowHeight - 0.5, SCREEN_WIDTH - 10, 0.5);
}

+ (instancetype)shopCartCellInTableView:(UITableView *)tableView {

    static NSString *reuseIdentifier = @"cell";
    ShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        
        cell = [[ShopCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    return cell;
}

- (void)setGoods:(Goods *)goods {

    _goods = goods;
    
    if (goods.is_xf) {
        
        _titleLabel.text = [NSString stringWithFormat:@"[精选]%@",goods.name];
    
    } else {
    
        _titleLabel.text = goods.name;
    }
    
    _priceLabel.text = [NSString stringWithFormat:@"$%@",[goods.price cleanDecimalPointZero]];
    _buyView.goods = goods;
}

@end
