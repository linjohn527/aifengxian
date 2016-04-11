//
//  UIBarButtonItem+Extension.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

    BarButtonItemTypeLeft,
    BarButtonItemTypeRight,
    
}BarButtonItemType;

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)itemWithTitle:(NSString *)title titleColor:(UIColor *)titleColor image:(NSString *)image higlightImg:(NSString *)higlightImg target:(id)target action:(SEL)action type:(BarButtonItemType)type;

@end
