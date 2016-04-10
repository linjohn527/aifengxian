//
//  MainTabBarController.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "MainTabBarController.h"
#import "RAMAnimatedTabBarItem.h"
#import "RAMBounceAnimation.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "SuperMarketViewController.h"
#import "ShopCartViewController.h"
#import "MineViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

/** ad imageView */
@property(nonatomic,strong)UIImageView *adImageView;

/**  */
@property(assign,nonatomic)bool isFirstLoadTabBarVC;


@end

@implementation MainTabBarController

- (UIImageView *)adImageView {

    if (!_adImageView) {
        
        _adImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    }
    
    return _adImageView;
}



- (void)setAdImage:(UIImage *)adImage {

    _adImage = adImage;
    
    self.adImageView.image = adImage;
    [self.view addSubview:self.adImageView];
    
    [UIView animateWithDuration:2.0 animations:^{
        
        self.adImageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.adImageView.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self.adImageView removeFromSuperview];
        self.adImageView = nil;
    }];
    
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.delegate = self;
    
    [self buildMainTabBarViewController];
}

- (void)viewDidAppear:(BOOL)animated {

    [super viewDidAppear:animated];
    
    if (!self.isFirstLoadTabBarVC) {
        NSDictionary *containers = [self createViewContainsers];
        [self createCustomIcons:containers];
        
    } else {
    
        self.isFirstLoadTabBarVC = YES;
    }
    
   
}

- (void)buildMainTabBarViewController {

    HomeViewController *homeVC = [[HomeViewController alloc] init];
    [self tabBarControllerAddChildViewController:homeVC title:@"首页" image:@"v2_home" selectedImg:@"v2_home_r" tag:0];
    
    SuperMarketViewController *supermartketVC = [[SuperMarketViewController alloc] init];
    [self tabBarControllerAddChildViewController:supermartketVC title:@"闪电超市" image:@"v2_order" selectedImg:@"v2_order_r" tag:1];
    
    
    ShopCartViewController *shopcartVC = [[ShopCartViewController alloc] init];
    [self tabBarControllerAddChildViewController:shopcartVC title:@"购物车" image:@"shopCart" selectedImg:@"shopCart" tag:2];
    
    MineViewController *mineVC = [[MineViewController alloc] init];
    [self tabBarControllerAddChildViewController:mineVC title:@"我的" image:@"v2_my" selectedImg:@"v2_my_r" tag:3];
}


- (void)tabBarControllerAddChildViewController:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImg:(NSString *)selectedImg tag:(NSInteger)tag {

     childVC.title = title;
    RAMAnimatedTabBarItem *item = [[RAMAnimatedTabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImg]];
   
    item.tag = tag;
    item.animation = [[RAMBounceAnimation alloc] init];
    
    childVC.tabBarItem = item;
    
    BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:childVC];
    
    [self addChildViewController:nav];
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {

    NSArray *viewControllers = self.viewControllers;
    NSUInteger index = [viewControllers indexOfObject:viewController];
    
    if (index == 2) {
        return NO;
    } else {
    
        return YES;
    }
}

@end
