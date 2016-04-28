//
//  ShopCartRedDotView.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ShopCartRedDotView.h"

@interface ShopCartRedDotView ()

/** Number Label */
@property(nonatomic,strong)UILabel *numberLabel;
/** Red ImageView */
@property(nonatomic,strong)UIImageView *redImageView;


@end

@implementation ShopCartRedDotView


static ShopCartRedDotView *sharedInstance;

+ (instancetype)shareRedDotView {

    if (!sharedInstance) {
        
        sharedInstance = [[self alloc] init];
    }
    
    return sharedInstance;
}



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, 20, 20)];
    
    if (self) {
        
        [self setup];
        
    }
    
    return self;
    
}

- (void)setup {

    self.backgroundColor = [UIColor clearColor];
    
    _redImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"reddot"]];
    [self addSubview:_redImageView];
    
    _numberLabel = [[UILabel alloc] init];
    _numberLabel.font = [UIFont systemFontOfSize:10];
    _numberLabel.textColor = [UIColor whiteColor];
    _numberLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_numberLabel];
    
    self.hidden = YES;
}

- (void)layoutSubviews {

    [super layoutSubviews];
    
    _redImageView.frame = self.bounds;
    _numberLabel.frame = CGRectMake(0, 0, self.width, self.height);
}

- (void)setBuyNumber:(int)buyNumber {

    _buyNumber = buyNumber;
    
    if (buyNumber == 0) {
        
        _numberLabel.text = @"";
        self.hidden = YES;
    
    } else {
    
        if (buyNumber > 99) {
            
            _numberLabel.font = [UIFont systemFontOfSize:8];
            
        } else {
        
            _numberLabel.font = [UIFont systemFontOfSize:10];
        }
        
        self.hidden = NO;
        _numberLabel.text = [NSString stringWithFormat:@"%d",buyNumber];
    }
    
}

- (void)addProductToRedDotView:(BOOL)animated {

    self.buyNumber++;
    
    if (animated) {
        
        [self reddotAnimation];
    }
}

- (void)reduceProductFromRedDotView:(BOOL)animated {

    if (_buyNumber > 0) {
        
        self.buyNumber--;
    }
    
    if (animated) {
        
        [self reddotAnimation];
    }
}

- (void)reddotAnimation {

    [UIView animateWithDuration:ShopCartRedDotViewAnimationDuration animations:^{
        
        self.transform = CGAffineTransformMakeScale(1.5, 1.5);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:ShopCartRedDotViewAnimationDuration animations:^{
            
            self.transform = CGAffineTransformIdentity;
        }];
        
    }];
}

@end
