//
//  HomeCollectionHeadView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/15/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "HomeCollectionHeadView.h"

@implementation HomeCollectionHeadView

- (UILabel *)titleLabel {

    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"新鲜热卖";
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.titleLabel.frame = CGRectMake(10, 0, 200, 20);
}

@end
