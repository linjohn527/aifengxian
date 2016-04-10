//
//  UIDevice+Extension.h
//  LoveBeeFresh
//
//  Created by linjohn on 4/9/16.
//  Copyright © 2016 linjohn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {

    DeviceScreenType3Dot5,
    DeviceScreenType4,
    DeviceScreenType4Dot7,
    DeviceScreenType5Dot5,
    
}DeviceScreenType;

@interface UIDevice (Extension)

+ (DeviceScreenType)currentDeviceScreenMeasurement;

@end
