//
//  PayWayView.h
//  LoveBeeFresh
//
//  Created by linjohn on 5/12/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,PayWayType) {

    PayWayTypeWeChat = 0,
    PayWayTypeQQPurse = 1,
    PayWayTypeAliPay = 2,
    PayWayTypeDelevery = 3,
};

@interface PayWayView : UIView

/**  */
@property(assign,nonatomic)PayWayType payType;

/**  */
@property(copy,nonatomic)void (^SelectedCallback)(PayWayType paywayType);

@property(nonatomic,strong)UIButton *selectedButton;


- (instancetype)initWithFrame:(CGRect)frame payType:(PayWayType)payType SelectedCallBack:(void (^)(PayWayType payWayType))SelectedCallBack;

@end
