//
//  SuperMarket.h
//  LoveBeeFresh
//
//  Created by linjohn on 5/15/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SuperMarketResource;

@interface SuperMarket : NSObject
/**  */
@property(assign,nonatomic)int code;
/**  */
@property(copy,nonatomic)NSString *msg;
/**  */
@property(copy,nonatomic)NSString *reqid;
/**  */
@property(nonatomic,strong)SuperMarketResource *data;

@end
