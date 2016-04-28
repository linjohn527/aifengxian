//
//  WebViewController.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/20/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "BaseViewController.h"

@interface WebViewController : BaseViewController

/**  */
@property(copy,nonatomic)NSString *urlStr;

- (instancetype)initWithTitle:(NSString *)title urlStr:(NSString *)urlStr;

@end
