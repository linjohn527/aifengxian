//
//  HeadResource.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/12/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "HeadResource.h"
#import "HeadData.h"
#import "MJExtension.h"

@implementation HeadResource


+ (void)loadHomeHeadData:(void (^)(HeadResource *,NSError *))completion {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"首页焦点按钮" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    HeadResource *resource = [HeadResource mj_objectWithKeyValues:dict];
    
    !completion?:completion(resource,error);
}

@end
