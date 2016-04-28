//
//  BuyView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/14/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "BuyView.h"
#import "Goods.h"
#import "ShopCartRedDotView.h"
#import "UserShopCartTool.h"

@interface BuyView ()



/**  */
@property(nonatomic,strong)UIButton *addGoodsButton;
/**  */
@property(nonatomic,strong)UIButton *reduceGoodsButton;
/**  */
@property(nonatomic,strong)UILabel *buyCountLabel;
/**  */
@property(nonatomic,strong)UILabel *supplentLabel;
/**  */
@property(assign,nonatomic)int buyNumber;


@end

@implementation BuyView

- (UIButton *)addGoodsButton {

    if (!_addGoodsButton) {
        
        _addGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addGoodsButton setImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
        [_addGoodsButton addTarget:self action:@selector(addGoodsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addGoodsButton;
}

- (UIButton *)reduceGoodsButton {

    if (!_reduceGoodsButton) {
        
        _reduceGoodsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_reduceGoodsButton setImage:[UIImage imageNamed:@"v2_reduce"] forState:UIControlStateNormal];
        [_reduceGoodsButton addTarget:self action:@selector(reduceGoodsButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _reduceGoodsButton;
}

- (UILabel *)buyCountLabel {

    if (!_buyCountLabel) {
        
        _buyCountLabel = [[UILabel alloc] init];
        _buyCountLabel.hidden = NO;
        _buyCountLabel.text = @"0";
        _buyCountLabel.textColor = [UIColor blackColor];
        _buyCountLabel.textAlignment = NSTextAlignmentCenter;
        _buyCountLabel.font = HOME_COLLECTIONVIEW_TEXTFONT;
    }
    
    return _buyCountLabel;
}

- (UILabel *)supplentLabel {

    if (!_supplentLabel) {
        
        _supplentLabel = [[UILabel alloc] init];
        _supplentLabel.hidden = YES;
        _supplentLabel.text = @"补货中";
        _supplentLabel.textAlignment = NSTextAlignmentRight;
        _supplentLabel.textColor = [UIColor redColor];
        _supplentLabel.font = HOME_COLLECTIONVIEW_TEXTFONT;
    }
    
    return _supplentLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    [self addSubview:self.addGoodsButton];
    [self addSubview:self.reduceGoodsButton];
    [self addSubview:self.buyCountLabel];
    [self addSubview:self.supplentLabel];
}

- (void)setBuyNumber:(int)buyNumber {

    _buyNumber = buyNumber;
    
    if (buyNumber > 0) {
        
        self.reduceGoodsButton.hidden = NO;
        self.buyCountLabel.text = [NSString stringWithFormat:@"%d",buyNumber];
        
    } else {
    
        self.reduceGoodsButton.hidden = YES;
        self.buyCountLabel.hidden = NO;
        self.buyCountLabel.text = [NSString stringWithFormat:@"%d",buyNumber];
    }
}



- (void)layoutSubviews {

    [super layoutSubviews];
    
    CGFloat buyCountWidth = 25;
    
    self.addGoodsButton.frame = CGRectMake(self.width - self.height - 2, 0, self.height, self.height);
    
    self.buyCountLabel.frame = CGRectMake(CGRectGetMinX(self.addGoodsButton.frame) - buyCountWidth, 0, buyCountWidth, self.height);
    
    self.reduceGoodsButton.frame = CGRectMake(CGRectGetMinX(self.buyCountLabel.frame) - self.height, 0, self.height, self.height);
    self.supplentLabel.frame = CGRectMake(CGRectGetMinX(self.reduceGoodsButton.frame), 0, self.height + buyCountWidth + self.height, buyCountWidth);

    
}

- (void)setGoods:(Goods *)goods {

    _goods = goods;
    
    self.buyNumber = goods.userBuyNumber;
    
    if (goods.number <= 0) {
        
        [self showSupplementLabel];
    
    } else {
    
        [self hideSupplementLabel];
    }
    
    if (goods.userBuyNumber == 0) {
        self.reduceGoodsButton.hidden = YES && !self.zeroIsShow;
        self.buyCountLabel.hidden = YES && !self.zeroIsShow;
    } else {
    
        self.reduceGoodsButton.hidden = NO;
        self.buyCountLabel.hidden = NO;
        self.buyCountLabel.text = [NSString stringWithFormat:@"%d",goods.userBuyNumber];
    }
}

- (void)showSupplementLabel {

    self.supplentLabel.hidden = NO;
    self.addGoodsButton.hidden = YES;
    self.reduceGoodsButton.hidden = YES;
    self.buyCountLabel.hidden = YES;
}

- (void)hideSupplementLabel {
    
    self.supplentLabel.hidden = YES;
    self.addGoodsButton.hidden = NO;
    self.reduceGoodsButton.hidden = NO;
    self.buyCountLabel.hidden = NO;
}
- (void)addGoodsButtonClick {
    
    if (self.buyNumber >= self.goods.number) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:HomeGoodsInventoryProblem object:self.goods.name];
        return;
    }
    
    self.reduceGoodsButton.hidden = NO;
    self.buyNumber++;
    self.goods.userBuyNumber = self.buyNumber;
    self.buyCountLabel.hidden = NO;
    self.buyCountLabel.text = [NSString stringWithFormat:@"%d",self.buyNumber];
    
    !self.clickAddShopCart?:self.clickAddShopCart();
    
    [[ShopCartRedDotView shareRedDotView] addProductToRedDotView:YES];
    
    //MARK: - TODO
    //添加到购物车
    [[UserShopCartTool sharedUserShopCart] addSupermarketProductToShopCart:self.goods];
    
    //MARK: TODO
    //发出购买结算总价变化的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ShopCartBuyPriceDidChange object:nil];;
}

- (void)reduceGoodsButtonClick {
    
    if (self.buyNumber <= 0) {
        return;
    }
    
    self.buyNumber--;
    self.goods.userBuyNumber = self.buyNumber;
    
    if (self.buyNumber == 0) {
        
        self.reduceGoodsButton.hidden = YES && !self.zeroIsShow;
        self.buyCountLabel.hidden = YES && !self.zeroIsShow;
        self.buyCountLabel.text = self.zeroIsShow?@"0":@"";
        
        //移除购物车
    [[UserShopCartTool sharedUserShopCart] removeSuperMarketProduct:self.goods];

    } else {
    
        self.buyCountLabel.text = [NSString stringWithFormat:@"%d",self.buyNumber];
        
    }
    
    //TabBar购物车图标数字变化
    [[ShopCartRedDotView shareRedDotView] reduceProductFromRedDotView:YES];
    
    
    //MARK: TODO
    //发出购买总价格已经变化的通知
    //发出购买结算总价变化的通知
    [[NSNotificationCenter defaultCenter] postNotificationName:ShopCartBuyPriceDidChange object:nil];;
}

@end
