//
//  UIView+Extension.h
//  百思不得姐(模仿)
//
//  Created by linjohn on 2/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property(nonatomic,assign)CGSize size;

/** X */
@property(assign,nonatomic)CGFloat x;

/** Y */
@property(assign,nonatomic)CGFloat y;

/** height */
@property(assign,nonatomic)CGFloat height;

/** width */
@property(assign,nonatomic)CGFloat width;

/** centerX */
@property(assign,nonatomic)CGFloat centerX;

/** centerY */
@property(assign,nonatomic)CGFloat centerY;



//是否在主窗口显示
-(BOOL)isShowInKeyWindow;



+(instancetype)viewFromXib;

@end
