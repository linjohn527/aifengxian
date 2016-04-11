//
//  AddressData.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "AddressData.h"
#import "MJExtension.h"


@implementation AddressData

+ (NSDictionary *)mj_objectClassInArray {

    return @{@"data":@"Address"};
}

+ (void)loadMyAddressData:(void (^)(AddressData *,NSError *))completion {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"MyAdress" ofType:nil];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    AddressData *addressData = [AddressData mj_objectWithKeyValues:dict];
    
    !completion?:completion(addressData,error);
}


@end
