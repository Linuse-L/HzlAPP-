//
//  Singleton.h
//  NewApp
//
//  Created by L on 15/9/28.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"
@interface Singleton : NSObject<UIAlertViewDelegate>
@property (nonatomic, strong) id resquest;
+(Singleton *)sharedInstance;
- (NSMutableDictionary *)zenidDic;
- (void)getZenid;
- (void)getNoPayOrder;
//判断应用是否在前台或者后台
+ (void)ISBGBF:(BOOL)yesorno;
+ (BOOL)BGBFyesorno;
//购物车跳转
- (void)gotoappCart;

@end
