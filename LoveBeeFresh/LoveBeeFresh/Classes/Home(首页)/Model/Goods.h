//
//  Goods.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/14/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject

/**  */
@property(copy,nonatomic)NSString *id;
/**  */
@property(copy,nonatomic)NSString *name;
/**  */
@property(copy,nonatomic)NSString *brand_id;
/**  */
@property(copy,nonatomic)NSString *market_price;
/**  */
@property(copy,nonatomic)NSString *cid;
/**  */
@property(copy,nonatomic)NSString *category_id;
/**  */
@property(copy,nonatomic)NSString *partner_price;
/**  */
@property(copy,nonatomic)NSString *brand_name;
/**  */
@property(copy,nonatomic)NSString *pre_img;
/**  */
@property(copy,nonatomic)NSString *pre_imgs;
/**  */
@property(copy,nonatomic)NSString *specifics;
/**  */
@property(copy,nonatomic)NSString *product_id;
/**  */
@property(copy,nonatomic)NSString *dealer_id;
/**  */
@property(copy,nonatomic)NSString *price;
/**  */
@property(assign,nonatomic)int number;
/**  */
@property(copy,nonatomic)NSString *pm_desc;
/**  */
@property(assign,nonatomic)int had_pm;
/**  */
@property(copy,nonatomic)NSString *img;
/**  */
@property(assign,nonatomic)int is_xf;
/**  */
@property(assign,nonatomic)int userBuyNumber;


@end
