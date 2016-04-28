//
//  UIBarButtonItem+Extension.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#import "LeftBarButton.h"
#import "RightBarButton.h"

@implementation UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor image:(NSString *)image higlightImg:(NSString *)higlightImg target:(id)target action:(SEL)action type:(BarButtonItemType)type {

    UIButton *btn = nil;
    
    if (type == BarButtonItemTypeLeft) {
        
        btn = [LeftBarButton buttonWithType:UIButtonTypeCustom];
    
    } else {
    
        btn = [RightBarButton buttonWithType:UIButtonTypeCustom];
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:higlightImg] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    btn.frame = CGRectMake(0, 0, 60, 44);
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return barButtonItem;
}


+ (instancetype)itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor target:(id)target action:(SEL)action {

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 60, 44);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -25);
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
