//
//  ProductsViewController.h
//  LoveBeeFresh
//
//  Created by linjohn on 5/16/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "AnimationViewController.h"
@class SuperMarket;

@protocol ProductsViewControllerDelegate <NSObject>

- (void)didEndDisplayingHeaderViewForSection:(NSUInteger)section;
- (void)willDisplayingHeaderViewForSection:(NSUInteger)section;


@end

@interface ProductsViewController : AnimationViewController

/**  */
@property(nonatomic,strong)SuperMarket *supermarketData;

/**  */
@property(nonatomic,strong)UITableView *productsTableView;
/**  */
@property(nonatomic,strong)NSIndexPath *categorySelectedIndexPath;
/**  */
@property(copy,nonatomic)void (^refreshPull)();

/**  */
@property(nonatomic,weak)id<ProductsViewControllerDelegate> delegate;

- (void)setCategorySelectedIndexPath:(NSIndexPath *)categorySelectedIndexPath;
@end
