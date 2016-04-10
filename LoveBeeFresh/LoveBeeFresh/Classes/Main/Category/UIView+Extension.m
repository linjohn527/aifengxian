//
//  UIView+Extension.m
//  百思不得姐(模仿)
//
//  Created by linjohn on 2/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)


-(CGSize)size {

    
    return self.frame.size;
    
}

-(void)setSize:(CGSize)size {

    CGRect frame = self.frame;
    
    frame.size = size;
    
    self.frame = frame;
}

-(CGFloat)x {

    return self.frame.origin.x;
}

-(void)setX:(CGFloat)x {

    CGRect frame = self.frame;
    
    frame.origin.x = x;
    
    self.frame = frame;
}


-(CGFloat)y {

    return self.frame.origin.y;
}

-(void)setY:(CGFloat)y {

    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


-(CGFloat)height {

    return self.frame.size.height;
}


-(void)setHeight:(CGFloat)height {

    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)width {

    return self.frame.size.width;
}

-(void)setWidth:(CGFloat)width {

    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(CGFloat)centerX {

    return self.center.x;
}

-(void)setCenterX:(CGFloat)centerX {

    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(CGFloat)centerY {
    
    return self.center.y;
}

-(void)setCenterY:(CGFloat)centerY {
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}



//
-(BOOL)isShowInKeyWindow {

    //主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect keyWindowBounds = keyWindow.bounds;
    
    //
    CGRect convertRect = [keyWindow convertRect:self.frame fromView:self.superview];
    BOOL isIntersect = CGRectIntersectsRect(convertRect, keyWindowBounds);
 
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && isIntersect;
}

+(instancetype)viewFromXib {

    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
}

@end
