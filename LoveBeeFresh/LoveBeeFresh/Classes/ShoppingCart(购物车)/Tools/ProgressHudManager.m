//
//  ProgressHudManager.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/1/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ProgressHudManager.h"
#import "SVProgressHUD.h"

@implementation ProgressHudManager

+ (void)setBackgroudColor:(UIColor *)color {

    [SVProgressHUD setBackgroundColor:color];
}
+ (void)setForegroudColor:(UIColor *)color {

    [SVProgressHUD setForegroundColor:color];
}
+ (void)setSuccessImage:(UIImage *)image {

    [SVProgressHUD setSuccessImage:image];
}
+ (void)setErrorImage:(UIImage *)image {

    [SVProgressHUD setErrorImage:image];
}
+ (void)setFont:(UIFont *)font {

    [SVProgressHUD setFont:font];
}
+ (void)showImage:(UIImage *)image status:(NSString *)status {

    [SVProgressHUD showImage:image status:status];
}
+ (void)show {

    [SVProgressHUD show];
}
+ (void)dismiss {

    [SVProgressHUD dismiss];
}
+ (void)showWithStatus:(NSString *)status {

    [SVProgressHUD showWithStatus:status];
}
+ (BOOL)isVisible {

    return [SVProgressHUD isVisible];
}
+ (void)showSuccessWithStatus:(NSString *)status {

    [SVProgressHUD showSuccessWithStatus:status];
}

@end
