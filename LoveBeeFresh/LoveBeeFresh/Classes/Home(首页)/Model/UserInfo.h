//
//  UserInfo.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Address;

@interface UserInfo : UIView


+ (instancetype)sharedUserInfo;

/** Address List */

- (BOOL)hasDefaultAddress;
- (void)configAllAddress:(NSMutableArray *)allAddress;
- (void)cleanAllAddress;

- (Address *)defaultAddress;

- (void)setDefaultAddress:(Address *)address;

@end
