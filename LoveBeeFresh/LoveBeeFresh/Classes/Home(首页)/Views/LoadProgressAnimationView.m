//
//  LoadProgressAnimationView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/21/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "LoadProgressAnimationView.h"

@interface LoadProgressAnimationView ()

/**  */
@property(assign,nonatomic)CGFloat viewWidth;


@end

@implementation LoadProgressAnimationView


- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        self.hidden = YES;
        self.viewWidth = frame.size.width;
        self.backgroundColor = NAVIGATION_YELLOW_COLOR;
    }
    
    return self;
}


- (void)startLoadProgressAnimation {

    self.width = 0;
    self.hidden = NO;
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        weakSelf.width = weakSelf.viewWidth * 0.6;
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            weakSelf.width = weakSelf.viewWidth * 0.8;
        });
        
    }];
}

- (void)stopLoadProgressAnimation {

    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        weakSelf.width = weakSelf.viewWidth;
        
    } completion:^(BOOL finished) {
        
        weakSelf.hidden = YES;
        
    }];

}

@end
