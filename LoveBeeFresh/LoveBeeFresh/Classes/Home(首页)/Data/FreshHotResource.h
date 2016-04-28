//
//  FreshHotResource.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/15/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FreshHot;

@interface FreshHotResource : NSObject

+(void)loadFreshHotData:(void(^)(FreshHot *freshhot,NSError *error))completion;

@end
