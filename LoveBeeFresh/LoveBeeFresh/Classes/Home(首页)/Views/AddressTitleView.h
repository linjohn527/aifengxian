//
//  AddressTitleView.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTitleView : UIView

/** title width */
@property(assign,nonatomic)CGFloat addressWidth;

- (void)setTitle:(NSString *)title;

@end
