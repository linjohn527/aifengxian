//
//  SuperMarketData.m
//  LoveBeeFresh
//
//  Created by linjohn on 5/15/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "SuperMarketData.h"
#import "SuperMarket.h"
#import "MJExtension.h"
#import "Products.h"
#import "SuperMarketResource.h"
#import "Category.h"

@implementation SuperMarketData

+ (void)loadSuperMarketData:(void (^)(SuperMarket *, NSError *))completion {

    NSString *path = [[NSBundle mainBundle] pathForResource:@"supermarket" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    if (data) {
        
        NSError *error = nil;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        SuperMarket *supermarketData = [SuperMarket mj_objectWithKeyValues:dict];
        
        !completion?:completion(supermarketData,error);
    }
}

+ (NSArray *)searchSuperMarketMatchProduct:(SuperMarketResource *)supermarketResource {

    NSMutableArray *arr = [NSMutableArray array];
    
    Products  *products = supermarketResource.products;
    NSArray *categories = supermarketResource.categories;
    for (NSUInteger i = 0; i < categories.count; i++) {
        
        Category2 *category = (Category2 *)categories[i];
        NSArray *goods = [products valueForKey:category.id];
        [arr addObject:goods];
    }
    
    return arr;
    
}

@end
