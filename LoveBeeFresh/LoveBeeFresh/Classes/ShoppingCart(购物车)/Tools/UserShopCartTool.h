//
//  UserShopCartTool.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/16/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Goods;

@interface UserShopCartTool : NSObject

/**  */
@property(nonatomic,strong)NSMutableArray<Goods *> *supermarketProducts;

+ (instancetype)sharedUserShopCart;

- (NSInteger)userShopCartProductsNumber;

- (BOOL)isEmpty;

- (void)addSupermarketProductToShopCart:(Goods *)goods;

- (NSArray *)getShopCartProducts;

- (void)removeSuperMarketProduct:(Goods *)goods;

- (NSString *)getAllProductsPrice;

- (NSArray *)getShopCartProducts;

@end
