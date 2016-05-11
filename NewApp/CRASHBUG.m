//
//  CRASHBUG.m
//  try处理异常
//
//  Created by 黄权浩 on 15-1-24.
//  Copyright (c) 2015年 黄权浩. All rights reserved.
//

#import "CRASHBUG.h"
#import "AppDelegate.h"

@implementation CRASHBUG

//发送形势@->错误接口类型 @->系统异常抛出内容 @->错误抛出时间 @->来自什么类型的设备
//（一定概率客户是会修改内容的，稳定性待测试）
+ (void)sendBug:(NSString *)bug interface:(NSString *)interfaceinfo
{
    NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
    long long int date = (long long int)time;
    NSDate *dd = [NSDate dateWithTimeIntervalSince1970:date];
    NSString *crashLogInfo = [NSString stringWithFormat:@"exception type : %@ \n crash reason : %@ \n call stack time : %@", interfaceinfo, bug, dd];
    NSString *urlStr = [NSString stringWithFormat:@"mailto://yongyuanstyle@outlook.com?subject=bug report&body=Thank you for your cooperation!""Error Details:%@",crashLogInfo];
    NSURL *url = [NSURL URLWithString:[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

@end
