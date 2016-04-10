//
//  AnimationTabBarController.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "AnimationTabBarController.h"
#import "ShopCartRedDotView.h"
#import "RAMAnimatedTabBarItem.h"
#import "BaseNavigationController.h"


@interface AnimationTabBarController ()

/** icons view */
@property(nonatomic,strong)NSMutableArray *iconsView;


@end


@implementation AnimationTabBarController

- (NSMutableArray *)iconsView {

    if (!_iconsView) {
        
      _iconsView = [NSMutableArray array];
    }
    
    return _iconsView;
}

- (void)viewDidLoad {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchViewControllerDeinit) name:SearchViewControllerDeinit object:nil];
    
    _iconsImageName = @[@"v2_home", @"v2_order", @"shopCart", @"v2_my"];
    _iconsSelectedImageName = @[@"v2_home_r", @"v2_order_r", @"shopCart_r", @"v2_my_r"];
    

}

- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)searchViewControllerDeinit {

    if (self.shopCartIcon) {
        
        ShopCartRedDotView *reddotView = [ShopCartRedDotView shareRedDotView];
        reddotView.frame = CGRectMake(22, -3, 15, 15);
        [self.shopCartIcon addSubview:reddotView];
    }
}

- (NSDictionary<__kindof NSString *,UIView *> *)createViewContainsers {

    NSMutableDictionary *containerDict = [NSMutableDictionary dictionary];
    
    NSArray *customItems = self.tabBar.items;
    
    for (int i = 0; i <customItems.count; i++) {
        
        UIView *viewContainer = [self createViewContainer:i];
        NSString *key = [NSString stringWithFormat:@"container%d",i];
        containerDict[key] = viewContainer;
    }
    
    return containerDict;
}


- (UIView *)createViewContainer:(int)index {

    CGFloat viewW = SCREEN_WIDTH / self.tabBar.items.count;
    CGFloat viewH = self.tabBar.height;
    
    UIView *viewContainer = [[UIView alloc] initWithFrame:CGRectMake(viewW * index, 0, viewW, viewH)];
    
    viewContainer.backgroundColor = [UIColor clearColor];
    viewContainer.userInteractionEnabled = YES;
    viewContainer.tag = index;
    
    [self.tabBar addSubview:viewContainer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabBarClick:)];
    [viewContainer addGestureRecognizer:tap];
    
    return viewContainer;
}

- (void)createCustomIcons:(NSDictionary<__kindof NSString *,UIView *> *)containers {

    NSArray *items = self.tabBar.items;
    
    if (items) {
        
        [items enumerateObjectsUsingBlock:^(UITabBarItem   *item, NSUInteger idx, BOOL * _Nonnull stop) {
           
            NSString *key = [NSString stringWithFormat:@"container%zd",idx];
            UIView *container = containers[key];
            
            if (container) {
                
                container.tag = idx;
                
                CGFloat imageW = 21;
                CGFloat imageX = (SCREEN_WIDTH / self.tabBar.items.count - imageW) * 0.5;
                CGFloat imageY = 8;
                CGFloat imageH = 21;
                UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(imageX, imageY, imageW, imageH)];
                icon.image = item.image;
                icon.tintColor = [UIColor clearColor];
                
                //text
                UILabel *textLabel = [[UILabel alloc] init];
                textLabel.frame = CGRectMake(0, 32, SCREEN_WIDTH / items.count, 49 - 32);
                
                textLabel.text = item.title;
                textLabel.backgroundColor = [UIColor clearColor];
                textLabel.font = [UIFont systemFontOfSize:10];
                textLabel.textAlignment = NSTextAlignmentCenter;
                textLabel.textColor = [UIColor grayColor];
                textLabel.translatesAutoresizingMaskIntoConstraints = NO;
                
                [container addSubview:icon];
                [container addSubview:textLabel];
                
                if (2 == idx) {
                    
                    ShopCartRedDotView *reddotView = [ShopCartRedDotView shareRedDotView];
                    
                    reddotView.frame = CGRectMake(imageH + 3, -3, 15, 15);
                    [icon addSubview:reddotView];
                    self.shopCartIcon = icon;
                }
                
                NSMutableDictionary *iconView = [NSMutableDictionary dictionary];
                iconView[@"icon"] = icon;
                iconView[@"textLabel"] = textLabel;
                [self.iconsView addObject:iconView];
                
                item.image = nil;
                item.title = nil;
                
                if (idx == 0) {
                    
                    self.selectedIndex = 0;
                    [self selectedItem:0];
                }
            }
            
        }];
    }
}

- (void)selectedItem:(int)index {

    NSArray *items = self.tabBar.items;
    RAMAnimatedTabBarItem *item = (RAMAnimatedTabBarItem *)items[index];
    UIImageView *selectedIcon = self.iconsView[index][@"icon"];
    UILabel *textLabel = self.iconsView[index][@"textLabel"];
    selectedIcon.image = [UIImage imageNamed:_iconsSelectedImageName[index]];
    
    [item setSelectedState:selectedIcon textLabel:textLabel];
}

- (void)tabBarClick:(UIView *)viewContainer {

    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {

    [self setSelectedIndex:self.selectedIndex to:item.tag];
}

- (void)setSelectedIndex:(NSUInteger)from to:(NSUInteger)to {

    if (to == 2) {
        
        UIViewController *vc = self.childViewControllers[self.selectedIndex];
        
        UIViewController *rootVC = [[UIViewController alloc] init];
        BaseNavigationController *nav = [[BaseNavigationController alloc] initWithRootViewController:rootVC];
        
        [vc presentViewController:nav animated:YES completion:nil];
        
        
        return;
    }
    
    self.selectedIndex = to;
    
    NSArray *items =self.tabBar.items;
    RAMAnimatedTabBarItem *fromItem = items[from];
    UIImageView *fromIV = self.iconsView[from][@"icon"];
    fromIV.image = [UIImage imageNamed:self.iconsImageName[from]];
    UILabel *fromLabel = self.iconsView[from][@"textLabel"];
    [fromItem deselectAnimation:fromIV textLabel:fromLabel];
    
    RAMAnimatedTabBarItem *toItem = items[to];
    UIImageView *toIV = self.iconsView[to][@"icon"];
    toIV.image = [UIImage imageNamed:self.iconsSelectedImageName[to]];
    UILabel *toLabel = self.iconsView[to][@"textLabel"];
    [toItem playAnimation:toIV textLabel:toLabel];
}

@end
