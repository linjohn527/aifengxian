//
//  ProductCell.h
//  LoveBeeFresh
//
//  Created by linjohn on 5/17/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Goods;

@interface ProductCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

/**  */
@property(copy,nonatomic)void(^addProductClick)(UIImageView *imageView);

/**  */
@property(nonatomic,strong)Goods *goods;

@end
