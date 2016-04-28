//
//  IconImageTextView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/13/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "IconImageTextView.h"
#import "Activities.h"
#import "UIImageView+WebCache.h"

@interface IconImageTextView ()

/**  */
@property(nonatomic,strong)UIImageView *imageView;
/**  */
@property(nonatomic,strong)UILabel *textLabel;
/**  */
@property(nonatomic,strong)UIImage *placeholderImage;



@end

@implementation IconImageTextView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame PlaceholderImage:(UIImage *)placeholder {

    self = [self initWithFrame:frame];
    
    self.placeholderImage = placeholder;
    
    return self;
}

- (void)setup {

    //
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = NO;
    imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:imageView];
    self.imageView = imageView;
    
    //
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.font = [UIFont systemFontOfSize:12];
    textLabel.textColor = [UIColor blackColor];
    textLabel.userInteractionEnabled = NO;
    [self addSubview:textLabel];
    self.textLabel = textLabel;
    
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    //
    self.imageView.frame = CGRectMake(5, 5, self.width - 15, self.height - 30);
    self.textLabel.frame = CGRectMake(5, self.height - 25, self.imageView.width, 20);
}

- (void)setActivities:(Activities *)activities {

    _activities = activities;
    
    self.textLabel.text = activities.name;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:activities.img] placeholderImage:self.placeholderImage];
}

@end
