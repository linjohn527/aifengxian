//
//  GuideViewCell.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/9/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "GuideViewCell.h"

@interface GuideViewCell ()

/** Image View */
@property(nonatomic,strong)UIImageView *guideImgView;

/** NextButton */
@property(nonatomic,strong)UIButton *nextButton;


@end

@implementation GuideViewCell

- (UIImageView *)guideImgView {

    if (!_guideImgView) {
        
        _guideImgView = [[UIImageView alloc] init];
        
    }
    
    return _guideImgView;
}

- (UIButton *)nextButton {

    if (!_nextButton) {
        
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _nextButton;
}

- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor redColor];
        //
        self.guideImgView.frame = SCREEN_BOUNDS;
        [self.contentView addSubview:self.guideImgView];
        
        //
        self.nextButton.frame = CGRectMake((SCREEN_WIDTH - 100.0) * 0.5, SCREEN_HEIGHT - 110.0, 100.0, 33.0);
        [self.nextButton setBackgroundImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
        [self.nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.nextButton.hidden = YES;
        [self.contentView addSubview:self.nextButton];
    }
    
    return self;
}

- (void)nextButtonClick {

    [[NSNotificationCenter defaultCenter] postNotificationName:GuideViewControllerDidFinished object:nil];
}

- (void)setImageName:(NSString *)imageName {

    _imageName = imageName;
    
    self.guideImgView.image = [UIImage imageNamed:imageName];
}

- (void)setShowNextButton:(BOOL)showNextButton {

    _showNextButton = showNextButton;
    
    self.nextButton.hidden = !showNextButton;
}

@end
