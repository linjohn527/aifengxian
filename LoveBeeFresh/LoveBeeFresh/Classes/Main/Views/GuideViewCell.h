//
//  GuideViewCell.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/9/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewCell : UICollectionViewCell

/** imageName */
@property(copy,nonatomic)NSString *imageName;

/** Show Next Button */
@property(assign,nonatomic)BOOL showNextButton;


@end
