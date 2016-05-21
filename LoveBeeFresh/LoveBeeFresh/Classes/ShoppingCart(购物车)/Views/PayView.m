//
//  PayView.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/12/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "PayView.h"
#import "PayWayView.h"

@interface PayView ()

/**  */
@property(nonatomic,strong)PayWayView *wechatView;
/**  */
@property(nonatomic,strong)PayWayView *qqpurseView;
/**  */
@property(nonatomic,strong)PayWayView *alipayView;
/**  */
@property(nonatomic,strong)PayWayView *deliveryView;


@end



@implementation PayView


- (instancetype)initWithFrame:(CGRect)frame {

    self = [super initWithFrame: frame];
    
    if (self) {
        
        [self setup];
    }
    
    return self;
}

- (void)setup {

    __weak typeof(self) weakSelf = self;
    _wechatView = [[PayWayView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40) payType:PayWayTypeWeChat SelectedCallBack:^(PayWayType payWayType) {
        
        [weakSelf setSelectedPayView:payWayType];
        
    }];
    
    _wechatView.selectedButton.selected = YES;
    
    _qqpurseView = [[PayWayView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 40) payType:PayWayTypeQQPurse SelectedCallBack:^(PayWayType payWayType) {
        
        [weakSelf setSelectedPayView:payWayType];
        
    }];
    
    _alipayView = [[PayWayView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 40) payType:PayWayTypeAliPay SelectedCallBack:^(PayWayType payWayType) {
        
        [weakSelf setSelectedPayView:payWayType];
        
    }];
    
    _deliveryView = [[PayWayView alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, 40) payType:PayWayTypeDelevery SelectedCallBack:^(PayWayType payWayType) {
        
        [weakSelf setSelectedPayView:payWayType];
        
    }];
    
    [self addSubview:_wechatView];
    [self addSubview:_qqpurseView];
    [self addSubview:_alipayView];
    [self addSubview:_deliveryView];
}


- (void)setSelectedPayView:(PayWayType)payType {

    _wechatView.selectedButton.selected = (payType == PayWayTypeWeChat);
    _qqpurseView.selectedButton.selected = (payType == PayWayTypeQQPurse);
    _alipayView.selectedButton.selected = (payType == PayWayTypeAliPay);
    _deliveryView.selectedButton.selected = (payType == PayWayTypeDelevery);

}

@end
