//
//  AnimationTabBarController.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationTabBarController : UITabBarController


/** iconsImageName */
@property(nonatomic,strong)NSArray *iconsImageName;
/** iconsSelectedImageName */
@property(nonatomic,strong)NSArray *iconsSelectedImageName;
/** shopCartIcon */
@property(nonatomic,strong)UIImageView *shopCartIcon;

- (void)createCustomIcons:(NSDictionary<__kindof NSString *,UIView *> *)containers;
- (NSDictionary<__kindof NSString *,UIView *> *)createViewContainsers;

@end
