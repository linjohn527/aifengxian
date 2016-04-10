//
//  RAMAnimatedTabBarItem.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "RAMAnimatedTabBarItem.h"
#import "RAMItemAnimation.h"

@implementation RAMAnimatedTabBarItem

- (UIColor *)textColor {

    if (!_textColor) {
        
        _textColor = [UIColor grayColor];
    }
    
    return _textColor;
}

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel {

    if (_animation) {
        
        [_animation playAnimation:icon textLabel:textLabel];
    }
}
- (void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel {
    
    [_animation deselectAnimation:icon textLabel:textLabel defaultTextColor:self.textColor];

}

- (void)setSelectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel {

    [_animation selectedState:icon textLabel:textLabel];
}

@end
