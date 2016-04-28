//
//  HomeViewController.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/10/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeTableHeadView.h"
#import "HeadResource.h"
#import "BaseCollectionView.h"
#import "HomeCollectionHeadView.h"
#import "HomeCollectionFooterView.h"
#import "FreshHotResource.h"
#import "FreshHot.h"
#import "Goods.h"
#import "HeadData.h"
#import "HomeCell.h"
#import "SVProgressHUD.h"
#import "RefreshHeader.h"
#import "MainTabBarController.h"
#import "WebViewController.h"
#import "Activities.h"
#import "ProductDetailViewController.h"

@interface HomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**  */
@property(nonatomic,weak)HomeTableHeadView *headView;
/**  */
@property(nonatomic,weak)BaseCollectionView *collectionView;

/**  */
@property(nonatomic,strong)FreshHot *freshhot;
/**  */
@property(nonatomic,strong)HeadResource *headdata;

/**  */
@property(assign,nonatomic)CGFloat lastContentOffsetY;

/**  */
@property(assign,nonatomic)BOOL isAnimation;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.navigationController.navigationBar.barTintColor = NAVIGATION_YELLOW_COLOR;
    
    [self addHomeNotification];
    
    [self buildCollectionView];
    
      [self buildHeadTableView];
    
    [self buildProgressHUD];
}

#pragma mark - Notification
- (void)addHomeNotification {

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeTableHeadViewHeightDidChange:) name:HomeTableHeadViewDidChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeGoodsInventoryProblem:) name:HomeGoodsInventoryProblem object:nil];
}

- (void)homeTableHeadViewHeightDidChange:(NSNotification *)notif {

    
    CGFloat headViewHeight = [notif.object doubleValue];
    
    
    self.collectionView.contentInset = UIEdgeInsetsMake(headViewHeight, 0, NavigationH, 0);
    
    
    [self.collectionView setContentOffset:CGPointMake(0, -self.collectionView.contentInset.top) animated:NO];
    

    self.lastContentOffsetY = self.collectionView.contentOffset.y;
}



- (void)homeGoodsInventoryProblem:(NSNotification *)notif {

    NSString *goodsName = notif.object;
    
    NSString *info = [NSString stringWithFormat:@"%@库存不足了,先买这么多\n过段时间再来看看",goodsName];
    [SVProgressHUD showImage:[UIImage imageNamed:@"v2_orderSuccess"] status:info];
    
    
}


- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Initial setup
- (void)buildHeadTableView {

    HomeTableHeadView *headView = [[HomeTableHeadView alloc] init];
    self.headView = headView;
    
       __weak typeof(self) weakSelf = self;
    [HeadResource loadHomeHeadData:^(HeadResource *resource, NSError *error) {
        
        headView.headData = resource;
        weakSelf.headdata = resource;
        [weakSelf.collectionView reloadData];
    }];
    
   
    [self.collectionView addSubview:headView];
    

    [FreshHotResource loadFreshHotData:^(FreshHot *freshhot, NSError *error) {
        
        weakSelf.freshhot = freshhot;
        [weakSelf.collectionView reloadData];
        //weakSelf.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    }];
    
}

static NSString *const cellIdentifier = @"Cell";
static NSString *const headerIdentifier = @"Head";
static NSString *const footerIdentifier = @"Foot";
- (void)buildCollectionView {

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 8;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(0, HomeCollectionViewCellMargin, 0, HomeCollectionViewCellMargin);
    
    layout.headerReferenceSize = CGSizeMake(0, HomeCollectionViewCellMargin);
    
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    BaseCollectionView *collectionView = [[BaseCollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = GLOBAL_BACKGROUD_COLOR;
    [collectionView registerClass:[HomeCell class] forCellWithReuseIdentifier:cellIdentifier];
    [collectionView registerClass:[HomeCollectionHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier];
    [collectionView registerClass:[HomeCollectionFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier];
    
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:collectionView];
    
    self.collectionView = collectionView;
    
    //
    RefreshHeader *refreshHeaderView = [RefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    
    collectionView.mj_header = refreshHeaderView;

}

- (void)headRefresh {

    
    self.headView.headData = nil;
    self.headdata = nil;
    self.freshhot = nil;
    __block BOOL headDataLoadFinished = NO;
    __block BOOL freshhotLoadFinished = NO;
    
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [HeadResource loadHomeHeadData:^(HeadResource *resource, NSError *error) {
            
            if (error == nil) {
                
                headDataLoadFinished = YES;
                weakSelf.headView.headData = resource;
                weakSelf.headdata = resource;
                
                if (headDataLoadFinished && freshhotLoadFinished) {
                    [weakSelf.collectionView reloadData];
                    [weakSelf.collectionView.mj_header endRefreshing];

                }
            }
            
        }];
        
    });
    
    [FreshHotResource loadFreshHotData:^(FreshHot *freshhot, NSError *error) {
        
        if (error == nil) {
            
            freshhotLoadFinished = YES;
            weakSelf.freshhot = freshhot;
            
            if (headDataLoadFinished && freshhotLoadFinished) {
                [weakSelf.collectionView reloadData];
                [weakSelf.collectionView.mj_header endRefreshing];
                
            }

        }
        
    }];
}

- (void)buildProgressHUD {

    [SVProgressHUD setBackgroundColor:RGB(240, 240, 240)];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:16]];
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    if (self.headdata.data.activities.count <= 0 || self.freshhot.data.count <=0) {
        return 0;
    }
    
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    if (self.headdata.data.activities.count <= 0 || self.freshhot.data.count <=0) {
        return 0;
    }
    
    if (section == 0) {
        
        if (self.headdata.data.activities.count >0) {
            
            return self.headdata.data.activities.count;
        } else {
        
            return 0;
        }
    
    } else if(section == 1) {
    
        if (self.freshhot.data.count > 0) {
            return self.freshhot.data.count;
        
        } else {
        
            return 0;
        }
    }
    
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    
    if (self.headdata.data.activities.count <=0) {
        
        return cell;
    }
    
    if (indexPath.section == 0) {
        
        cell.activities = self.headdata.data.activities[indexPath.row];
        
    } else if(indexPath.section == 1) {
    
        cell.goods = self.freshhot.data[indexPath.row];
        
        __weak typeof(self) weakSelf = self;
        cell.addButtonClick = ^(UIImageView *imageV) {
        
            [weakSelf addProductsAnimation:imageV];
        };
    }
    
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1 && [kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        HomeCollectionHeadView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerIdentifier forIndexPath:indexPath];
        
        return header;
    }
    
    HomeCollectionFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerIdentifier forIndexPath:indexPath];
    
    if (indexPath.section ==  1 && [kind isEqualToString:UICollectionElementKindSectionFooter] ) {
        
        [footer showLabel];
        
    } else {
    
        [footer hideLabel];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreGoodsClick:)];
    
    [footer addGestureRecognizer:tap];
    
    return footer;
    
}

- (void)moreGoodsClick:(UITapGestureRecognizer *)tap {

    MainTabBarController *mainTab = (MainTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [mainTab setSelectedIndex:0 to:1];
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

    CGSize itemSize = CGSizeZero;
    
    if (indexPath.section == 0) {
        
        itemSize = CGSizeMake(SCREEN_WIDTH - 2 * HomeCollectionViewCellMargin, 140);
    
    } else if(indexPath.section == 1) {
    
        itemSize = CGSizeMake((SCREEN_WIDTH - 2 * HomeCollectionViewCellMargin)* 0.5 - 4, 250);
    }
    
    return itemSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    CGSize size = CGSizeZero;
    
    if (section == 0) {
        
        size = CGSizeMake(SCREEN_WIDTH, HomeCollectionViewCellMargin);
    
    } else if(section == 1) {
    
        size = CGSizeMake(SCREEN_WIDTH, HomeCollectionViewCellMargin * 2);
    }
    
    return size;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {

    CGSize size = CGSizeZero;
    
    if (section == 0) {
        
        size = CGSizeMake(SCREEN_WIDTH, HomeCollectionViewCellMargin);
        
    } else if(section == 1) {
        
        size = CGSizeMake(SCREEN_WIDTH, HomeCollectionViewCellMargin * 5);
    }
    
    return size;
}



#pragma mark - <UICollectionViewDelegate>
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    if (self.animationLayers.count > 0) {
        
        CALayer *animLayer = self.animationLayers[0];
        animLayer.hidden = YES;
    }
    
    
    if (scrollView.contentOffset.y <= scrollView.contentSize.height) {
        
        self.isAnimation = self.lastContentOffsetY < scrollView.contentOffset.y;
        self.lastContentOffsetY = scrollView.contentOffset.y;
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && (indexPath.row == 0 || indexPath.row == 1)) {
        
        return;
    }
    
    
    if (self.isAnimation) {
        
        [self startAnimationView:cell offsetY:80 duration:1.0];
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 1 && self.isAnimation && self.headdata != nil && self.freshhot != nil) {
        
        [self startAnimationView:view offsetY:60.0 duration:1.0];
    }
}

- (void)startAnimationView:(UIView *)view offsetY:(CGFloat)offsetY duration:(CGFloat)duration {

    view.transform = CGAffineTransformMakeTranslation(0, offsetY);
    
    [UIView animateWithDuration:duration animations:^{
        
        view.transform = CGAffineTransformIdentity;
    }];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        
        Activities *activity = self.headdata.data.activities[indexPath.row];
        WebViewController *webVC = [[WebViewController alloc] initWithTitle:activity.name urlStr:activity.customURL];
        
        [self.navigationController pushViewController:webVC animated:YES];
    
    } else {
    
        ProductDetailViewController *proVC = [[ProductDetailViewController alloc] initWithGoods:self.freshhot.data[indexPath.row]];
        
        [self.navigationController pushViewController:proVC animated:YES];
    }
}

@end
