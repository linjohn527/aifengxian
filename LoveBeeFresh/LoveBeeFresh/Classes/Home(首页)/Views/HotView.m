//
//  HotView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/13/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "HotView.h"
#import "HeadData.h"
#import "IconImageTextView.h"

#define HOTVIEW_MARGIN 10
#define MAX_COLUMN 4
#define ICON_HEIGHT 80
#define ICON_WIDTH (SCREEN_WIDTH / MAX_COLUMN)

@interface HotView ()

/**  */
@property(assign,nonatomic)NSInteger row;

/**  */
@property(copy,nonatomic)void (^IconClick)(NSInteger index);

@end

@implementation HotView

- (instancetype)initWithFrame:(CGRect)frame iconClick:(void (^)(NSInteger))iconClick {

    self = [super initWithFrame:frame];
    self.IconClick = iconClick;
    
    return self;
}

- (void)setHeadData:(HeadData *)headData {

    _headData = headData;
    
    if (headData.icons.count > 0) {
    
        if (headData.icons.count % MAX_COLUMN) {
            
            self.row = headData.icons.count / MAX_COLUMN + 1;
        
        } else {
        
            self.row = headData.icons.count / MAX_COLUMN;
        }
        
        self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, self.row * ICON_HEIGHT);
        
        for (NSInteger i = 0; i < self.headData.icons.count; i++) {
            
            NSInteger row = i / MAX_COLUMN;
            NSInteger col = i % MAX_COLUMN;
            
            CGFloat iconX = col * ICON_WIDTH;
            CGFloat iconY = row * ICON_HEIGHT;
            
            CGRect frame = CGRectMake(iconX, iconY, ICON_WIDTH, ICON_HEIGHT);
            IconImageTextView *icon = [[IconImageTextView alloc] initWithFrame:frame PlaceholderImage:[UIImage imageNamed:@"icon_icons_holder"]];
            
            icon.activities = self.headData.icons[i];
            icon.tag = i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(iconTap:)];
            [icon addGestureRecognizer:tap];
            [self addSubview:icon];
            
        }
    }
    
    [self layoutIfNeeded];
}

- (void)iconTap:(UITapGestureRecognizer *)tap {

    !self.IconClick?:self.IconClick(tap.view.tag);
}

- (void)layoutSubviews {

    [super layoutSubviews];
}

@end
