//
//  HomeCollectionFooterView.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/15/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionFooterView : UICollectionReusableView


- (void)showLabel;
- (void)hideLabel;

- (void)setTitle:(NSString *)title textColor:(UIColor *)textColor;

@end
