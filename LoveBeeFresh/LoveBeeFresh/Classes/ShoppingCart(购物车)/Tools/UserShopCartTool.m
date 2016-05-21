//
//  UserShopCartTool.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/16/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "UserShopCartTool.h"
#import "Goods.h"
#import "ShopCartRedDotView.h"
#import "NSString+Extension.h"

@implementation UserShopCartTool

- (NSMutableArray<Goods *> *)supermarketProducts {

    if (!_supermarketProducts) {
        
        _supermarketProducts = [NSMutableArray array];
    }
    
    return _supermarketProducts;
}

static  UserShopCartTool *instance;

+ (instancetype)sharedUserShopCart {

    if (instance == nil) {
        
        instance = [[UserShopCartTool alloc] init];
    }
    
    return instance;
}

- (NSInteger)userShopCartProductsNumber {

    return [ShopCartRedDotView shareRedDotView].buyNumber;
}

- (BOOL)isEmpty {

    return self.supermarketProducts.count == 0;
}

- (void)addSupermarketProductToShopCart:(Goods *)goods {

    for (Goods *gd in self.supermarketProducts) {
        
        if (goods.id == gd.id) {
            
            return;
        }
    }
    
    [self.supermarketProducts addObject:goods];
    
}

- (NSArray *)getShopCartProducts {

    return self.supermarketProducts;
}

- (void)removeSuperMarketProduct:(Goods *)goods {

    for (Goods *gd in self.supermarketProducts) {
        
        if (gd.id == goods.id) {
            
            [self.supermarketProducts removeObject:gd];
        }
    }
    
}

- (NSString *)getAllProductsPrice {
    
    CGFloat totalPrice = 0;
    
    for (Goods *goods in self.supermarketProducts) {
        
        CGFloat price = [goods.partner_price floatValue] * goods.userBuyNumber;
        
        totalPrice += price;
    }

    return [[NSString stringWithFormat:@"%.2f",totalPrice] cleanDecimalPointZero];
}

@end
