//
//  HotView.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/13/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HeadData;

@interface HotView : UIView

/**  */
@property(nonatomic,strong)HeadData *headData;



- (instancetype)initWithFrame:(CGRect)frame iconClick:(void (^)(NSInteger index))iconClick;

@end
