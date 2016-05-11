//
//  CRASHBUG.h
//  try处理异常
//
//  Created by 黄权浩 on 15-1-24.
//  Copyright (c) 2015年 黄权浩. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CRASHBUG : NSObject

//发送异常消息
+ (void)sendBug:(NSString *)bug interface:(NSString *)interfaceinfo;

@end
