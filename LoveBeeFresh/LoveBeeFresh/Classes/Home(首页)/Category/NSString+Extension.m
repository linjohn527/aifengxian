//
//  NSString+Extension.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/14/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)cleanDecimalPointZero {

    NSString *newStr = self;
    
    NSString *s = nil;
    
    NSInteger offset = self.length - 1;
    
    while (offset > 0) {
        
        s = [self substringWithRange:NSMakeRange(offset, 1)];
        
        if ([s isEqualToString:@"0"] || [s isEqualToString:@"."] ) {
            
            offset--;
        
        } else {
        
            break;
        }
    }
    
    return [newStr substringToIndex:offset+1];
}

@end
