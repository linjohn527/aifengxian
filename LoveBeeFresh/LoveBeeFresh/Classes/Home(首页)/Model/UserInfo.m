//
//  UserInfo.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "UserInfo.h"
#import "AddressData.h"

@interface UserInfo()

/**  */
@property(nonatomic,strong)NSMutableArray *allAddress;


@end

@implementation UserInfo

- (NSMutableArray *)allAddress {

    if (!_allAddress) {
        
        _allAddress = [NSMutableArray array];
    }
    
    return _allAddress;
}

static  UserInfo *userInfo;
+ (instancetype)sharedUserInfo {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        userInfo = [[UserInfo alloc] init];
    });
    
    return userInfo;
}


- (BOOL)hasDefaultAddress {

    if (self.allAddress.count > 0) {
        return YES;
    } else {
    
        return NO;
    }
}

- (void)configAllAddress:(NSMutableArray *)allAddress {

    self.allAddress = allAddress;
}

- (void)cleanAllAddress {

    [self.allAddress removeAllObjects];
}

- (Address *)defaultAddress {

    if (self.allAddress.count == 0) {
        
        
        __weak typeof(self) weakSelf = self;
        [AddressData loadMyAddressData:^(AddressData * data, NSError *error) {
            
            if (!error) {
                
                if (data.data.count > 0) {
                    
                     weakSelf.allAddress = (NSMutableArray *)data.data;
                    
                } else {
                
                    [weakSelf.allAddress removeAllObjects];
                }
               
            }
            
           
        }];
        
        return self.allAddress.count > 1 ? [self.allAddress firstObject]:nil;
        
    } else {
    
        return [self.allAddress firstObject];
    }
}

- (void)setDefaultAddress:(Address *)address {

    if (self.allAddress.count > 0) {
        
        [self.allAddress insertObject:address atIndex:0];
    
    } else {
    
        [self.allAddress addObject:address];
    }
}

@end
