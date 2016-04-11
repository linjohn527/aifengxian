//
//  AddressData.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressData : NSObject

/**  */
@property(assign,nonatomic)int code;
/**  */
@property(copy,nonatomic)NSString *msg;
/**  */
@property(nonatomic,strong)NSArray *data;


+ (void)loadMyAddressData:(void (^)(AddressData *,NSError *))completion;

@end
