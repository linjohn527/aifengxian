//
//  BaseNavigationController.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "BaseNavigationController.h"

@implementation BaseNavigationController

- (void)viewDidLoad {

    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

    viewController.navigationItem.hidesBackButton = YES;
    if (self.viewControllers.count > 0) {
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.titleLabel.hidden = YES;
        [backButton setImage:[UIImage imageNamed:@"v2_goback"] forState:UIControlStateNormal];
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        CGFloat btnW = SCREEN_WIDTH > 375?50:40;
        backButton.frame = CGRectMake(0, 0, btnW, 40);
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        [viewController hidesBottomBarWhenPushed];
    }
    
    [super pushViewController:viewController animated:animated];
}

- (void)backButtonClick {

    [self popViewControllerAnimated:YES];
}

@end
