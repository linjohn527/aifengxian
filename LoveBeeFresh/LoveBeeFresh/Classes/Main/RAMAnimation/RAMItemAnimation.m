//
//  RAMItemAnimation.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "RAMItemAnimation.h"

@implementation RAMItemAnimation

- (instancetype)init {

    self = [super init];
    
    if (self) {
        
        _duration = 0.6;
        _textSelectedColor = [UIColor grayColor];
    }
    
    return self;
}

- (void)playAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabeL {

}
- (void)deselectAnimation:(UIImageView *)icon textLabel:(UILabel *)textLabel defaultTextColor:(UIColor *)color {

}
- (void)selectedState:(UIImageView *)icon textLabel:(UILabel *)textLabel {

    
}

@end
