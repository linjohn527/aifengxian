//
//  MainAD.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/9/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AD;

@interface MainAD : NSObject

/** code */
@property(assign,nonatomic)int code;
/** message */
@property(copy,nonatomic)NSString *msg;

/** ad */
@property(strong,nonatomic)AD *data;


@end
