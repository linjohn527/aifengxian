//
//  AddressTitleView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "AddressTitleView.h"
#import "UserInfo.h"
#import "Address.h"

@interface AddressTitleView ()

/** play label */
@property(nonatomic,strong)UILabel *playLabel;
/** title label */
@property(nonatomic,strong)UILabel *titleLabel;
/** arrow image view */
@property(nonatomic,strong)UIImageView *arrowImageView;




@end

@implementation AddressTitleView

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    //
    UILabel *playLabel = [[UILabel alloc] init];
    playLabel.text = @"配送至";
    playLabel.textColor = [UIColor blackColor];
    playLabel.backgroundColor = [UIColor clearColor];
    playLabel.layer.borderWidth = 0.5;
    playLabel.layer.borderColor = [UIColor blackColor].CGColor;
    playLabel.font = [UIFont systemFontOfSize:10];
    playLabel.textAlignment = NSTextAlignmentCenter;
    [playLabel sizeToFit];
    [self addSubview:playLabel];
    self.playLabel = playLabel;
    
    //
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    
    Address *address = [[UserInfo sharedUserInfo] defaultAddress];
    
    if (address != nil) {
        
        NSString *addressStr = address.address;
        
        if (addressStr != nil) {
            
            if ([addressStr componentsSeparatedByString:@" "].count > 1) {
                
                titleLabel.text = [addressStr componentsSeparatedByString:@" "][0];
            }

        } else {
        
            titleLabel.text = addressStr;
        }
        
    } else {
    
        titleLabel.text = @"你在哪里";
    }
    
    [titleLabel sizeToFit];
   
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    //
   UIImageView  *arrorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"allowBlack"]];
    
    [self addSubview:arrorImageView];
    self.arrowImageView = arrorImageView;
}


- (void)layoutSubviews {

    [super layoutSubviews];
    
    self.playLabel.frame = CGRectMake(0, (self.height - self.playLabel.height - 2) * 0.5, self.playLabel.width + 6, self.playLabel.height + 2);
     self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.playLabel.frame) + 4, 0, self.titleLabel.width, self.height);
    self.arrowImageView.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + 4, (self.height - 6) * 0.5, 10, 6);
    
    
    self.addressWidth = CGRectGetMaxX(self.arrowImageView.frame);
}

- (void)setTitle:(NSString *)title {

    if ([title componentsSeparatedByString:@" "].count > 1) {
        
        self.titleLabel.text = [title componentsSeparatedByString:@" "][0];
    
    } else {
    
        self.titleLabel.text = title;
    }
    
    [self.titleLabel sizeToFit];
    
    [self layoutIfNeeded];
    
}

@end
