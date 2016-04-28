//
//  HomeTableHeadView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/13/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "HomeTableHeadView.h"
#import "PageScrollView.h"
#import "HotView.h"
#import "HeadData.h"
#import "HeadResource.h"

@interface HomeTableHeadView ()

/**  */
@property(nonatomic,strong)PageScrollView *pageScrollView;
/**  */
@property(nonatomic,strong)HotView *hotView;

/**  */
@property(assign,nonatomic)CGFloat tableHeadViewHeight;


@end

@implementation HomeTableHeadView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    [self buildPageScrollView];
    [self buildHotView];
}

- (void)buildPageScrollView {

    __weak typeof(self) weakSelf = self;
    PageScrollView *pageScrollView = [[PageScrollView alloc] initWithFrame:CGRectZero PlaceHolderImage:[UIImage imageNamed:@"v2_placeholder_full_size"] imageItemClick:^(NSInteger index) {
      
        if ([weakSelf.delegate respondsToSelector:@selector(HomeTableHeadView:didClickFocusImageView:)]) {
            
            [weakSelf.delegate HomeTableHeadView:weakSelf didClickFocusImageView:index];
        }
        
    }];
    [self addSubview:pageScrollView];
    self.pageScrollView = pageScrollView;
    
}

- (void)buildHotView {

    __weak typeof(self) weakSelf = self;

    HotView *hotView = [[HotView alloc] initWithFrame:CGRectZero iconClick:^(NSInteger index) {
      
        if ([weakSelf.delegate respondsToSelector:@selector(HomeTableHeadView:didClickIcon:)]) {
            
            [weakSelf.delegate HomeTableHeadView:weakSelf didClickIcon:index];
        }
    }];
    
    [self addSubview:hotView];
    self.hotView = hotView;
}

- (void)setHeadData:(HeadResource *)headData {

    _headData = headData;
    
    self.pageScrollView.headData = headData;
    self.hotView.headData = headData.data;
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.pageScrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH * 0.31);
    self.hotView.x = 0;
    self.hotView.y = CGRectGetMaxY(self.pageScrollView.frame);
    
    self.tableHeadViewHeight = CGRectGetMaxY(self.hotView.frame);
}

- (void)setTableHeadViewHeight:(CGFloat)tableHeadViewHeight {

    _tableHeadViewHeight = tableHeadViewHeight;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HomeTableHeadViewDidChange object:@(tableHeadViewHeight)];
    
    self.frame = CGRectMake(0, -tableHeadViewHeight, SCREEN_WIDTH, tableHeadViewHeight);
}



@end
