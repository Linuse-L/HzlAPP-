//
//  Notificatio.h
//  Dragon
//
//  Created by 黄权浩 on 15-3-19.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Notificatio : NSObject
+ (void)sendNotificatio:(NSInteger)timer detail:(NSString *)detail;//传入秒  传入内容
+ (void)sendSucceseNotificatio:(NSInteger)timer;//传入秒    支付成功
+ (void)sendfaildNotificatio:(NSInteger)timer;//传入秒       支付失败
+ (void)removeTheNotificationNumber;//取消提示数字
@end
