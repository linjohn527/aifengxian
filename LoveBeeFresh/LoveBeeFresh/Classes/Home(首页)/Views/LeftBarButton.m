//
//  LeftBarButton.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "LeftBarButton.h"

@implementation LeftBarButton

- (void)layoutSubviews {

    [super layoutSubviews];
    
    CGFloat offset = 15;
    
    
    self.titleLabel.frame = CGRectMake(-offset, self.height - 15, self.width - offset, self.titleLabel.height);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.frame = CGRectMake(-offset, 0, self.width - offset, self.height - 15);
    self.imageView.contentMode = UIViewContentModeCenter;
}

@end
