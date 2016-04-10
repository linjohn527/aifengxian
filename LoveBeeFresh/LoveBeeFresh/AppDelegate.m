//
//  AppDelegate.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/8/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "GuideViewController.h"
#import "AD.h"
#import "MainAD.h"
#import "ADViewController.h"
#import "MJExtension.h"
#import "MainTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupUM];
    
    [self setupAppTheme];
    
    [self addNotifications];
    
    [self setupKeyWindow];
    
    return YES;
}


#pragma mark - 初始化设置

/**
 *  设置友盟
 */
- (void)setupUM {

    [UMSocialData setAppKey:@"5704fd28e0f55a3f92000e7c"];
    [UMSocialWechatHandler setWXAppId:@"wxb81a61739edd3054" appSecret:@"c62eba630d950ff107e62fe08391d19d" url:@"https://github.com"];
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialQQHandler setQQWithAppId:@"" appKey:@"" url:@""];
    
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatSession,UMShareToQzone,UMShareToQQ,UMShareToSina,UMShareToWechatTimeline]];
    
}

/**
 *  设置APP主题
 */
- (void)setupAppTheme {

    UITabBar *tabBarAppearence = [UITabBar appearance];
    [tabBarAppearence setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    
    UINavigationBar *navigationBarAppearence = [UINavigationBar appearance];
    navigationBarAppearence.translucent = NO;
    
}

/**
 *  添加通知
 */
- (void)addNotifications {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainTabbarControllerSuccess:) name:ADLoadImageSuccess object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainTabbarControllerFailure:) name:ADLoadImageFailure object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMainTabbarController) name:GuideViewControllerDidFinished object:nil];
}

- (void)showMainTabbarControllerSuccess:(NSNotification *)notif {

    UIImage *adImage = notif.object;
    
    MainTabBarController *mainTaBarVC = [[MainTabBarController alloc] init];
    mainTaBarVC.adImage = adImage;
    
    self.window.rootViewController = mainTaBarVC;
}

- (void)showMainTabbarControllerFailure:(NSNotification *)notif {

    MainTabBarController *mainTaBarVC = [[MainTabBarController alloc] init];
    self.window.rootViewController = mainTaBarVC;
}

- (void)showMainTabbarController {

    MainTabBarController *mainTaBarVC = [[MainTabBarController alloc] init];
    self.window.rootViewController = mainTaBarVC;
}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 *  创建主窗口
 */
- (void)setupKeyWindow {

    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
   
    
    NSString *isFirstOpenApp = [[NSUserDefaults standardUserDefaults] objectForKey:@"isFirstOpenApp"];
   
   
    
    if (!isFirstOpenApp) {//第一次打开APP,播放导航页
        
        [[NSUserDefaults standardUserDefaults] setObject:@"isFirstOpenApp" forKey:@"isFirstOpenApp"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
         self.window.rootViewController = [[GuideViewController alloc] init];
        
    } else {//不是第一次打开APP，加载广告页
    
        NSError *error = nil;
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"AD" ofType:nil];
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        //MY_LOG(@"%@",dict);
        MainAD *mainAD = [MainAD mj_objectWithKeyValues:dict];
        
       ADViewController *adVC = [[ADViewController alloc] init];
        
        adVC.imageName = mainAD.data.img_name;
        
        self.window.rootViewController = adVC;
    }
    
     [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
