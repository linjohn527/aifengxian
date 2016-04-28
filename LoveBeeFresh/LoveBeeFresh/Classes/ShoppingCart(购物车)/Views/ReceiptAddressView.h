//
//  ReceiptAddressView.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/28/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Address;

typedef void (^ModifyButtonClickCallBack)();

@interface ReceiptAddressView : UIView

/**  */
@property(copy,nonatomic)ModifyButtonClickCallBack callback;
/**  */
@property(nonatomic,strong)Address *address;

- (instancetype)initWithFrame:(CGRect)frame ModifyButtonClick:(ModifyButtonClickCallBack)callback;

@end
