//
//  FreshHotResource.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/15/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "FreshHotResource.h"
#import "MJExtension.h"
#import "FreshHot.h"

@implementation FreshHotResource

+(void)loadFreshHotData:(void(^)(FreshHot *freshhot,NSError *error))completion {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"首页新鲜热卖" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    FreshHot *freshhot = [FreshHot mj_objectWithKeyValues:dict];
    
    !completion?:completion(freshhot,error);
}

@end
