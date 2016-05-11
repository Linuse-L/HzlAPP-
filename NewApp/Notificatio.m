//
//  Notificatio.m
//  Dragon
//
//  Created by 黄权浩 on 15-3-19.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//
/***************************************************
 
 **用于hzl的本地推送
 
 //暂定时间可以修改  具体换算方法精确到秒
 
                          by:hqh   2015.03.19
 
***************************************************/
#import "Notificatio.h"

@implementation Notificatio
+ (void)sendNotificatio:(NSInteger)timer detail:(NSString *)detail
{
    //做出本地推送，延迟时间暂定
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now=[NSDate new];
        notification.fireDate=[now dateByAddingTimeInterval:timer];
        notification.timeZone=[NSTimeZone defaultTimeZone];
        notification.alertBody= detail;
        notification.soundName = @"default";
        [notification setApplicationIconBadgeNumber:1];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

+ (void)sendSucceseNotificatio:(NSInteger)timer
{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now=[NSDate new];
        notification.fireDate  = [now dateByAddingTimeInterval:timer];
        notification.timeZone  = [NSTimeZone defaultTimeZone];
        notification.alertBody = @"You have goods in the shopping cart did not pay yet.";
        notification.soundName = @"default";
        [notification setApplicationIconBadgeNumber:1];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

+ (void)sendfaildNotificatio:(NSInteger)timer
{
    UILocalNotification *notification=[[UILocalNotification alloc] init];
    if (notification!=nil) {
        NSDate *now=[NSDate new];
        notification.fireDate  = [now dateByAddingTimeInterval:timer];
        notification.timeZone  = [NSTimeZone defaultTimeZone];
        notification.alertBody = @"You have goods in the shopping cart did not pay yet.";
        notification.soundName = @"default";
        [notification setApplicationIconBadgeNumber:1];
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }
}

+ (void)removeTheNotificationNumber
{
    
}
@end
