//
//  UIDevice+Extension.m
//  LoveBeeFresh
//
//  Created by linjohn on 4/9/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import "UIDevice+Extension.h"

@implementation UIDevice (Extension)

+ (DeviceScreenType)currentDeviceScreenMeasurement {

    DeviceScreenType deviceScree = DeviceScreenType3Dot5;
    
    if ((568 == SCREEN_HEIGHT && 320 == SCREEN_WIDTH) || (1136 == SCREEN_HEIGHT && 640 == SCREEN_WIDTH)) {
        deviceScree = DeviceScreenType4;
    } else if ((667 == SCREEN_HEIGHT && 375 == SCREEN_WIDTH) || (1334 == SCREEN_HEIGHT && 750 == SCREEN_WIDTH)) {
        deviceScree = DeviceScreenType4Dot7;
    } else if ((736 == SCREEN_HEIGHT && 414 == SCREEN_WIDTH) || (2208 == SCREEN_HEIGHT && 1242 == SCREEN_WIDTH)) {
        deviceScree = DeviceScreenType5Dot5;
    }
    
    return deviceScree;
}

@end
