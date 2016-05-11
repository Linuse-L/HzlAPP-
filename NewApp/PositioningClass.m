//
//  PositioningClass.m
//  testpbl
//
//  Created by 黄权浩 on 15/8/24.
//  Copyright (c) 2015年 黄权浩. All rights reserved.
//

#import "PositioningClass.h"

@implementation PositioningClass

+ (instancetype)shared
{
    static PositioningClass *class = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        class = [[PositioningClass alloc] init];
    });
    return class;
}

- (void)getLocation:(id)nowclass
{
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = nowclass;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    _locationManager.distanceFilter = 10;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
        [_locationManager requestAlwaysAuthorization];
    }
    [_locationManager startUpdatingLocation];
}

@end
