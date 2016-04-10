//
//  GuideViewController.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/9/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideViewCell.h"

@interface GuideViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

/** Collection View */
@property(nonatomic,weak)UICollectionView *collectionView;

/** PageControl */
@property(nonatomic,weak)UIPageControl *pageControl;


/** ImageNames */
@property(nonatomic,strong)NSArray *imageNames;


@end

@implementation GuideViewController


- (NSArray *)imageNames {

    if (!_imageNames) {
        
        _imageNames = [[NSArray alloc] initWithObjects:@"guide_40_1", @"guide_40_2", @"guide_40_3", @"guide_40_4", nil];
        
    }
    
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //
    [self setupCollectionView];
    
    //
    [self setupPageControl];
    
    
}

- (BOOL)prefersStatusBarHidden {

    return YES;
}

#pragma mark - 初始化设置
static NSString *const cellIdentifier = @"guidecell";
- (void)setupCollectionView {

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = SCREEN_BOUNDS.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:SCREEN_BOUNDS collectionViewLayout:flowLayout];
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.bounces = NO;
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[GuideViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}

- (void)setupPageControl {

    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50.0, SCREEN_WIDTH, 20.0)];
    
    pageControl.numberOfPages = self.imageNames.count;
    pageControl.currentPage = 0;
    
    [self.view addSubview:pageControl];
    
    self.pageControl = pageControl;
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    GuideViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    cell.imageName = self.imageNames[indexPath.row];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    [self scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    NSInteger currentPage = contentOffsetX / SCREEN_WIDTH + 0.5;
    
    self.pageControl.currentPage = currentPage;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentPage inSection:0];
    GuideViewCell *cell = (GuideViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];

    if (currentPage == self.imageNames.count - 1) {
        
        cell.showNextButton = YES;
    
    } else {
    
        cell.showNextButton = NO;
    }
}


@end
