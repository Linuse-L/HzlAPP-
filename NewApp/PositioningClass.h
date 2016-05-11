//
//  PositioningClass.h
//  testpbl
//
//  Created by 黄权浩 on 15/8/24.
//  Copyright (c) 2015年 黄权浩. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface PositioningClass : NSObject<CLLocationManagerDelegate>

+ (instancetype)shared;
- (void)getLocation:(id)nowclass;
@property(nonatomic,strong)CLLocationManager *locationManager;

@end
