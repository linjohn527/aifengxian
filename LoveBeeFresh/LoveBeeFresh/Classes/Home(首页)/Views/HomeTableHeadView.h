//
//  HomeTableHeadView.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/13/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeTableHeadView,HeadResource;

@protocol HomeTableHeadViewDelegate <NSObject>

- (void)HomeTableHeadView:(HomeTableHeadView *)headView didClickFocusImageView:(NSInteger)index;

- (void)HomeTableHeadView:(HomeTableHeadView *)headView didClickIcon:(NSInteger)index;
@end

@interface HomeTableHeadView : UIView

/**  */
@property(nonatomic,strong)HeadResource *headData;

/**  */
@property(nonatomic,weak)id<HomeTableHeadViewDelegate> delegate;


@end
