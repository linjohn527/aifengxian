//
//  RAMBounceAnimation.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "RAMBounceAnimation.h"

@implementation RAMBounceAnimation

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabeL {

    [self playBounceAnimation:icon];
    
    textLabeL.textColor = self.textSelectedColor;
}

- (void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel defaultTextColor:(UIColor *)color {

    textLabel.textColor = color;
    UIImage *iconImage = icon.image;
    
    if (iconImage) {
        
       UIImage *renderImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
        icon.image = renderImage;
        icon.tintColor = color;
    }
}

- (void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel {

    textLabel.textColor = self.textSelectedColor;
    
    UIImage *iconImage = icon.image;
    
    if (iconImage) {
        
        UIImage *renderImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        icon.image = renderImage;
        icon.tintColor = self.textSelectedColor;
    }
}

- (void)playBounceAnimation:(UIImageView *)icon {

    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    bounceAnimation.values = @[@1.0,@1.4,@0.9,@1.15,@0.95,@1.02,@1.0];
    bounceAnimation.duration = self.duration;
    bounceAnimation.calculationMode = kCAAnimationCubic;
    [icon.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    
    UIImage *iconImage = icon.image;
    if (iconImage) {
        
        UIImage *renderImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        icon.image = renderImage;
        icon.tintColor = self.textSelectedColor;
    }
    
}

@end
