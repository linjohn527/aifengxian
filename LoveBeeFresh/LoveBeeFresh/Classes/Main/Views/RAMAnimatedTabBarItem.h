//
//  RAMAnimatedTabBarItem.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RAMItemAnimation;

@interface RAMAnimatedTabBarItem : UITabBarItem

/** animation */
@property(nonatomic,strong)RAMItemAnimation *animation;
/** text color */
@property(nonatomic,strong)UIColor *textColor;

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel;
- (void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel;
- (void)setSelectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel;

@end
