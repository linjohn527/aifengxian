//
//  ShopCartSupermarketTableFooterView.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/29/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartSupermarketTableFooterView : UIView

/**  */
@property(nonatomic,strong)UILabel *priceLabel;

- (instancetype)initWithFrame:(CGRect)frame deciseButtonClick:(void (^)())deciseButtonClick;

@end
