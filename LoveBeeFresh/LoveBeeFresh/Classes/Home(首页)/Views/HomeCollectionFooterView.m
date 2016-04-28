//
//  HomeCollectionFooterView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/15/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "HomeCollectionFooterView.h"

@interface HomeCollectionFooterView ()

/**  */
@property(nonatomic,strong)UILabel *titleLable;

@end

@implementation HomeCollectionFooterView

- (UILabel *)titleLable {

    if (!_titleLable) {
        
        _titleLable = [[UILabel alloc] init];
        _titleLable.text = @"点击查看更多商品>>";
        _titleLable.font = [UIFont systemFontOfSize:16];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.textColor = RGB(150, 150, 150);
    }
    
    return _titleLable;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    [self addSubview:self.titleLable];
}

- (void)hideLabel {

    self.titleLable.hidden = YES;
}

- (void)showLabel {

    self.titleLable.hidden = NO;
}

- (void)setTitle:(NSString *)title textColor:(UIColor *)textColor {

    self.titleLable.text = title;
    self.titleLable.textColor = textColor;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.titleLable.frame = CGRectMake(0, 0, self.width, self.height);
    self.titleLable.centerX = CGRectGetWidth(self.frame) * 0.5;
}

@end
