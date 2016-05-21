//
//  PayWayView.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/12/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "PayWayView.h"

@interface PayWayView ()

/**  */
@property(nonatomic,strong)UIImageView *payIconImageView;
/**  */
@property(nonatomic,strong)UILabel *payTitleLabel;



@end

@implementation PayWayView


- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame payType:(PayWayType)payType SelectedCallBack:(void (^)(PayWayType payWayType))SelectedCallBack {

    self = [self initWithFrame:frame];
    
    self.SelectedCallback = SelectedCallBack;
    self.payType = payType;
    
    switch (payType) {
        case PayWayTypeWeChat:
            _payIconImageView.image = [UIImage imageNamed:@"v2_weixin"];
            _payTitleLabel.text = @"微信支付";
            break;
        case PayWayTypeAliPay:
            _payIconImageView.image = [UIImage imageNamed:@"zhifubaoA"];
            _payTitleLabel.text = @"支付宝支付";
            break;
        case PayWayTypeQQPurse:
            _payIconImageView.image = [UIImage imageNamed:@"icon_qq"];
            _payTitleLabel.text = @"QQ钱包";
            break;
        case PayWayTypeDelevery:
            _payIconImageView.image = [UIImage imageNamed:@"v2_dao"];
            _payTitleLabel.text = @"到货付款";
            break;
            
        default:
            break;
    }
    
    return self;
}

- (void)setup {

    //
    _payIconImageView = [[UIImageView alloc] init];
    _payIconImageView.frame = CGRectMake(20, 10, 20, 20);
    _payIconImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_payIconImageView];
    
    //
    _payTitleLabel = [[UILabel alloc] init];
    _payTitleLabel.frame = CGRectMake(55, 0, 150, 40);
    _payTitleLabel.textColor = [UIColor blackColor];
    _payTitleLabel.font = [UIFont systemFontOfSize:14];
    [self addSubview:_payTitleLabel];
    
    //
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectedButton.frame = CGRectMake(SCREEN_WIDTH -16 -10, (40 - 16) * 0.5, 16, 16);
    [_selectedButton setImage:[UIImage imageNamed:@"v2_noselected"] forState:UIControlStateNormal];
    [_selectedButton setImage:[UIImage imageNamed:@"v2_selected"] forState:UIControlStateSelected];
    _selectedButton.userInteractionEnabled = false;
    [self addSubview:_selectedButton];
    
    //
    UIView *lineView = [[UIView alloc] init];
    lineView.frame = CGRectMake(15, 0, SCREEN_WIDTH - 15, 0.5);
    lineView.backgroundColor = [UIColor blackColor];
    lineView.alpha = 0.1;
    [self addSubview:lineView];
    
    //
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedPayView)];
    [self addGestureRecognizer:tap];
}


- (void)selectedPayView {

    _selectedButton.selected = YES;
    
    !_SelectedCallback?:_SelectedCallback(_payType);
}

@end
