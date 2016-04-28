//
//  PageScrollView.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/12/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeadResource;

@interface PageScrollView : UIView

/**  */
@property(copy,nonatomic)HeadResource *headData;

- (instancetype)initWithFrame:(CGRect)frame PlaceHolderImage:(UIImage *)placeholder imageItemClick:(void (^)(NSInteger))itemClick;

@end
