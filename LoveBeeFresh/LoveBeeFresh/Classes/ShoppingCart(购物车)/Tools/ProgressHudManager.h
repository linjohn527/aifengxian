//
//  ProgressHudManager.h
//  LoveBeeFresh
//
//  Created by linjohn on 5/1/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProgressHudManager : NSObject

+ (void)setBackgroudColor:(UIColor *)color;
+ (void)setForegroudColor:(UIColor *)color;
+ (void)setSuccessImage:(UIImage *)image;
+ (void)setErrorImage:(UIImage *)image;
+ (void)setFont:(UIFont *)font;
+ (void)showImage:(UIImage *)image status:(NSString *)status;
+ (void)show;
+ (void)dismiss;
+ (void)showWithStatus:(NSString *)status;
+ (BOOL)isVisible;
+ (void)showSuccessWithStatus:(NSString *)status;

@end
