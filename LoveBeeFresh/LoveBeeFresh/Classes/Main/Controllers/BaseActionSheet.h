//
//  BaseActionSheet.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/21/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ShareType) {

    ShareTypeWeiXinFriend = 0,
    ShareTypeWeiXinCircus,
    ShareTypeSinaWeiBo,
    ShareTypeQQZone,
};

@interface BaseActionSheet : UIAlertController

/**  */
@property(copy,nonatomic)void(^selectedShareType)(ShareType type);
+ (void)showActionSheetInVC:(UIViewController *)vc selectedShareType:(void(^)(ShareType type))selectedShareType;


@end
