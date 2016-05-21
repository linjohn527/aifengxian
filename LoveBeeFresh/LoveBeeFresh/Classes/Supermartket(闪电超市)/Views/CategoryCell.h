//
//  CategoryCell.h
//  LoveBeeFresh
//
//  Created by linjohn on 5/19/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Category2;

@interface CategoryCell : UITableViewCell

/**  */
@property(nonatomic,strong)Category2 *categories;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
