//
//  WebViewController.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/20/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "WebViewController.h"
#import <WebKit/WebKit.h>
#import "LoadProgressAnimationView.h"

@interface WebViewController ()<WKNavigationDelegate>

/**  */
@property(nonatomic,strong)WKWebView *webView;
/**  */
@property(nonatomic,strong)LoadProgressAnimationView *progressView;


@end

@implementation WebViewController

- (WKWebView *)webView {

    if (!_webView) {
        
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    }
    
    return _webView;
}

- (LoadProgressAnimationView *)progressView {

    if (!_progressView) {
        
        
        _progressView = [[LoadProgressAnimationView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 3)];
    }
    
    return _progressView;
}

- (instancetype)init {

    self = [super init];
    
    if (self) {
        
    }
    
    return self;
}



- (instancetype)initWithTitle:(NSString *)title urlStr:(NSString *)urlStr {

    self = [self init];
    self.urlStr = urlStr;
    self.navigationItem.title = title;
    
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = RGB(230, 230, 230);
    
    [self buildWebView];
    
    [self buildRightBarButtonItem];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = NAVIGATION_WHITE_COLOR;
}

- (void)buildWebView {
    
    [self.view addSubview:self.webView];
    
    self.webView.backgroundColor = RGB(230, 230, 230);
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 64, 0);
    self.webView.navigationDelegate = self;
 
    [self.webView addSubview:self.progressView];
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


- (void)buildRightBarButtonItem {

    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 44);
    [rightBtn setImage:[UIImage imageNamed:@"v2_refresh"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(refreshClick) forControlEvents:UIControlEventTouchUpInside];
    
    rightBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -53);
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

- (void)refreshClick {

    if (self.urlStr != nil) {
        
        [self.webView reload];
    }
}


#pragma mark - WKNavitionDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {

    MY_LOG(@"Start Loading");
    
    [self.progressView startLoadProgressAnimation];
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {

    MY_LOG(@"End Loading");
    
    [self.progressView stopLoadProgressAnimation];
}

@end
