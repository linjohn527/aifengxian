//
//  AnimationViewController.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "BaseViewController.h"

@interface AnimationViewController : BaseViewController

/** layers */
@property(nonatomic,strong)NSMutableArray<CALayer *> *animationLayers;
/** big layers */
@property(nonatomic,strong)NSMutableArray<CALayer *> *animationBigLayers;


- (void)addProductsAnimation:(UIImageView *)imageView;
- (void)addProductsToBigShopCartAnimation:(UIImageView *)imageView;

@end
