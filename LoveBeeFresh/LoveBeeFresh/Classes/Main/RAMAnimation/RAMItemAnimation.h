//
//  RAMItemAnimation.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RAMItemAnimation : NSObject

/** duration */
@property(assign,nonatomic)CGFloat duration;
/** text selected color */
@property(nonatomic,strong)UIColor *textSelectedColor;
/** icon selected color */
@property(nonatomic,strong)UIColor *iconSelectedColor;

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabeL;
- (void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel defaultTextColor:(UIColor *)color;
- (void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel;

@end
