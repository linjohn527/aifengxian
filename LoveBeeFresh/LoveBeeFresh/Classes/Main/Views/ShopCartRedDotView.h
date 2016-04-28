//
//  ShopCartRedDotView.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartRedDotView : UIView

/** buy number */
@property(assign,nonatomic)int buyNumber;


+ (instancetype)shareRedDotView;

- (void)addProductToRedDotView:(BOOL)animated;
- (void)reduceProductFromRedDotView:(BOOL)animated;


@end
