//
//  BaseActionSheet.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/21/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "BaseActionSheet.h"

@interface BaseActionSheet ()


@end

@implementation BaseActionSheet


+ (void)showActionSheetInVC:(UIViewController *)vc selectedShareType:(void(^)(ShareType type))selectedShareType {
    
    BaseActionSheet *alertVC = [BaseActionSheet alertControllerWithTitle:@"分享到" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"微信好友" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
         selectedShareType(ShareTypeWeiXinFriend);
    }];
    
    [alertVC addAction:action1];
    
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"微信朋友圈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        selectedShareType(ShareTypeWeiXinCircus);
    }];
    
    [alertVC addAction:action2];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"新浪微博" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        selectedShareType(ShareTypeSinaWeiBo);
    }];
    
    [alertVC addAction:action3];
    
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"QQ空间" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        selectedShareType(ShareTypeQQZone);
    }];
    
    [alertVC addAction:action4];
    
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        [alertVC dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertVC addAction:cancle];
    
    [vc presentViewController:alertVC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
