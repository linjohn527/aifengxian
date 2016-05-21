//
//  SuperMarketHeaderView.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/16/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "SuperMarketHeaderView.h"

@interface SuperMarketHeaderView ()




@end

@implementation SuperMarketHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self setup];
    }
    return self;
}

- (void)setup {

    self.backgroundView = [[UIView alloc] init];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.8];
    
    [self buildTitleLable];
    
}

- (void)buildTitleLable {

    _titleLabel = [[UILabel alloc] init];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.textColor = RGB(100, 100, 100);
    _titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_titleLabel];
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    _titleLabel.frame = CGRectMake(HotViewMargin, 0, self.width - HotViewMargin, self.height);
}




@end
