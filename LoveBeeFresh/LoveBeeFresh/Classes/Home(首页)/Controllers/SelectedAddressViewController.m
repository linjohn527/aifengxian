//
//  SelectedAddressViewController.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/11/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "SelectedAddressViewController.h"
#import "UIBarButtonItem+Extension.h"
#import "AddressTitleView.h"
#import "UserInfo.h"
#import "Address.h"

@implementation SelectedAddressViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    [self buildNavigationItem];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    if ([[UserInfo sharedUserInfo] hasDefaultAddress]) {
        
        AddressTitleView *titleView = (AddressTitleView *)self.navigationItem.titleView;
        Address *defaultAddress = [[UserInfo sharedUserInfo] defaultAddress];
        [titleView setTitle:defaultAddress.address];
        MY_LOG(@"%f",titleView.addressWidth);
        titleView.frame = CGRectMake(0, 0,titleView.addressWidth, 30);
        [titleView layoutIfNeeded];
        
    }
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    AddressTitleView *titleView = (AddressTitleView *)self.navigationItem.titleView;
    
    MY_LOG(@"%@",NSStringFromCGRect(titleView.frame));
}

- (void)buildNavigationItem {

    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"扫一扫" titleColor:[UIColor blackColor] image:@"icon_black_scancode" higlightImg:nil target:self action:@selector(leftItemClick) type:BarButtonItemTypeLeft];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"搜 索" titleColor:[UIColor blackColor] image:@"icon_search" higlightImg:nil target:self action:@selector(rightItemClick) type:BarButtonItemTypeRight];
    
    
    AddressTitleView *titleView = [[AddressTitleView alloc] init];
    titleView.frame = CGRectMake(0, 0, titleView.addressWidth,30);
    self.navigationItem.titleView = titleView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleViewClick)];
    [self.navigationItem.titleView addGestureRecognizer:tap];
}

- (void)titleViewClick {

    
}

- (void)leftItemClick {

    MY_LOG(@"扫一扫");
}

- (void)rightItemClick {

    MY_LOG(@"搜 索");
}

@end
