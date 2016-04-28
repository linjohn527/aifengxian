//
//  HomeCell.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/14/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Activities,Goods;

typedef enum {

    HomeCellTypeHorizontal,
    HomeCellTypeVertical,
    
}HomeCellType;

@interface HomeCell : UICollectionViewCell

/**  */
@property(assign,nonatomic)HomeCellType type;

/**  */
@property(copy,nonatomic)void(^addButtonClick)(UIImageView *imageView);

/**  */
@property(nonatomic,strong)Activities *activities;
/**  */
@property(nonatomic,strong)Goods *goods;


@end
