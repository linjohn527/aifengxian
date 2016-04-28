//
//  PageScrollView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/12/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "PageScrollView.h"
#import "HeadResource.h"
#import "HeadData.h"
#import "UIImageView+WebCache.h"
#import "Activities.h"

#define IMAGEVIEW_MAX_COUNT 3

@interface PageScrollView ()<UIScrollViewDelegate>

/**  */
@property(nonatomic,strong)UIScrollView *imageScrollView;
/**  */
@property(nonatomic,strong)UIPageControl *pageControl;
/**  */
@property(nonatomic,strong)NSTimer *timer;
/**  */
@property(nonatomic,strong)UIImage *placeholderImage;

/**  */
@property(copy,nonatomic)void(^itemClick)(NSInteger);


@end

@implementation PageScrollView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame PlaceHolderImage:(UIImage *)placeholder imageItemClick:(void (^)(NSInteger))itemClick {

    self =  [self initWithFrame:frame];
    
    self.placeholderImage = placeholder;
    self.itemClick = itemClick;
    
    return self;
}

- (void)setup {

    [self buildImageScrollView];
    [self buildPageControl];
}

- (void)buildImageScrollView {

    UIScrollView *imageScrollView = [[UIScrollView alloc] init];
    imageScrollView.bounces = NO;
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.showsVerticalScrollIndicator = NO;
    imageScrollView.pagingEnabled = YES;
    imageScrollView.delegate = self;
    [self addSubview:imageScrollView];
    self.imageScrollView = imageScrollView;
    
    for (NSInteger i = 0; i < 3; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewClick:)];
        [imageView addGestureRecognizer:tap];
        [imageScrollView addSubview:imageView];
    }
}

- (void)buildPageControl {

    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.hidesForSinglePage = YES;
    pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"v2_home_cycle_dot_normal"]];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"v2_home_cycle_dot_selected"]];
    [self addSubview:pageControl];
    self.pageControl = pageControl;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.imageScrollView.frame = self.bounds;
    self.imageScrollView.contentSize = CGSizeMake(IMAGEVIEW_MAX_COUNT * self.width, 0);
    for (NSInteger i = 0; i < IMAGEVIEW_MAX_COUNT; i++) {
        
        UIImageView *imageView = self.imageScrollView.subviews[i];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(i * self.imageScrollView.width, 0, self.imageScrollView.width, self.imageScrollView.height);
    }
    
    //
    CGFloat pageW = 80;
    CGFloat pageH = 20;
    CGFloat pageX = self.imageScrollView.width - pageW;
    CGFloat pageY = self.imageScrollView.height - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
    [self updatePageScrollView];
}

- (void)updatePageScrollView {

    for (NSInteger i = 0 ; i < self.imageScrollView.subviews.count; i++) {
        
        UIImageView *imageView = self.imageScrollView.subviews[i];
        NSInteger index = self.pageControl.currentPage;
        
        if (i == 0) {
            index --;
        } else if(i == 2) {
        
            index ++;
        }
        
        if (index < 0) {
            index = self.pageControl.numberOfPages - 1;
        
        } else if(index >= self.pageControl.numberOfPages) {
        
            index = 0;
        }
        
        imageView.tag = index;
        
        if (self.headData.data.focus.count > 0) {
            
            Activities *activity = self.headData.data.focus[index];
            NSURL *imgUrl = [NSURL URLWithString:activity.img];
            [imageView sd_setImageWithURL:imgUrl placeholderImage:self.placeholderImage];
            
        }
    }
    
    self.imageScrollView.contentOffset = CGPointMake(self.imageScrollView.width, 0);
}

- (void)imageViewClick:(UITapGestureRecognizer *)tap  {

    if (self.itemClick != nil) {
        
        self.itemClick(tap.view.tag);
    }
    
}

- (void)setHeadData:(HeadResource *)headData {

    _headData = headData;
    
    if (self.timer != nil) {
        
        [self stopTimer];
    }
    
    if (self.headData.data.focus.count > 0) {
        
        self.pageControl.numberOfPages = self.headData.data.focus.count;
        self.pageControl.currentPage = 0;
        [self updatePageScrollView];
        
        [self startTimer];
    }
}

- (void)startTimer {

    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(next) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {

    [self.timer invalidate];
    self.timer = nil;
}

- (void)next {

    [self.imageScrollView setContentOffset:CGPointMake(2 * self.imageScrollView.width, 0) animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    
    for (NSInteger i = 0; i < self.imageScrollView.subviews.count; i++) {
        
        UIImageView *imageView = self.imageScrollView.subviews[i];
        
        CGFloat distance = ABS(imageView.x - scrollView.contentOffset.x);
        
        if (distance < minDistance) {
            
            minDistance = distance;
            page = imageView.tag;
        }
    }
    
    self.pageControl.currentPage = page;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    [self startTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self updatePageScrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {

    [self updatePageScrollView];
}

@end
