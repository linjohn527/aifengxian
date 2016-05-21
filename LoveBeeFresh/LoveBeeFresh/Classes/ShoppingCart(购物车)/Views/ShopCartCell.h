//
//  ShopCartCell.h
//  LoveBeeFresh
//
//  Created by linjohn on 5/4/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Goods;

@interface ShopCartCell : UITableViewCell

/**  */
@property(nonatomic,strong)Goods *goods;


+ (instancetype)shopCartCellInTableView:(UITableView *)tableView;

@end
