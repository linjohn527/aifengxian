//
//  HeadResource.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/12/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HeadData;

@interface HeadResource : NSObject

/**  */
@property(nonatomic,copy)NSString *msg;
/**  */
@property(copy,nonatomic)NSString *reqid;

/**  */
@property(strong,nonatomic)HeadData *data;


+ (void)loadHomeHeadData:(void (^)(HeadResource *,NSError *))completion;

@end
