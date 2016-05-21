//
//  SuperMarketResource.h
//  LoveBeeFresh
//
//  Created by linjohn on 5/15/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Products;

@interface SuperMarketResource : NSObject

/**  */
@property(nonatomic,strong)NSArray *categories;
/**  */
@property(nonatomic,strong)Products *products;
/**  */
@property(copy,nonatomic)NSString *trackid;


@end
