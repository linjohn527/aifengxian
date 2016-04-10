//
//  ADViewController.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/8/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "ADViewController.h"
#import "UIImageView+WebCache.h"

@interface ADViewController ()

/** Image View */
@property(nonatomic,strong)UIImageView *imageView;


@end

@implementation ADViewController

- (UIImageView *)imageView {

    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithFrame:SCREEN_BOUNDS];
        
        [self.view addSubview:_imageView];
    }
    
    return _imageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
}

- (BOOL)prefersStatusBarHidden {

    return YES;
}



- (void)setImageName:(NSString *)imageName {

    _imageName = imageName;
    
    NSString *placeholderImgName = nil;
    
    
    switch ([UIDevice currentDeviceScreenMeasurement]) {
        case DeviceScreenType3Dot5:
            placeholderImgName = @"iphone4";
            break;
        case DeviceScreenType4:
            placeholderImgName = @"iphone5";
            break;
        case DeviceScreenType4Dot7:
            placeholderImgName = @"iphone6";
            break;
        case DeviceScreenType5Dot5:
            placeholderImgName = @"iphone6s";
            break;
        default:
            break;
    }
    
    //MY_LOG(@"%@",self.imageView);
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:placeholderImgName] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        if (error) {
            
            MY_LOG(@"加载广告图片失败");
            [[NSNotificationCenter defaultCenter] postNotificationName:ADLoadImageFailure object:nil];
        }
        
        if (image) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:ADLoadImageSuccess object:image];
                    
                });
                
            });
            
        } else {
        
            MY_LOG(@"加载广告图片失败");
        }
    }];
}


@end
