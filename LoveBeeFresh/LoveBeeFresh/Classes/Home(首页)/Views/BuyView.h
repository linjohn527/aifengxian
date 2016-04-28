//
//  BuyView.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/14/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Goods;

@interface BuyView : UIView

/**  */
@property(nonatomic,strong)Goods *goods;
/**  */
@property(assign,nonatomic)BOOL zeroIsShow;

/**  */
@property(copy,nonatomic)void(^clickAddShopCart)();;


@end
