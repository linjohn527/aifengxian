//
//  SuperMarketData.h
//  LoveBeeFresh
//
//  Created by linjohn on 5/15/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SuperMarket;
@class SuperMarketResource;

@interface SuperMarketData : NSObject

+ (void)loadSuperMarketData:(void (^)(SuperMarket *data,NSError *error))completion;

+ (NSArray *)searchSuperMarketMatchProduct:(SuperMarketResource *)supermarketResource;

@end
