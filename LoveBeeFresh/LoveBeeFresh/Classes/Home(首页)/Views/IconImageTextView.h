//
//  IconImageTextView.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/13/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Activities;

@interface IconImageTextView : UIView

/**  */
@property(nonatomic,strong)Activities *activities;

- (instancetype)initWithFrame:(CGRect)frame PlaceholderImage:(UIImage *)placeholder;


@end
