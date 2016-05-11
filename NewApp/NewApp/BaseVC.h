//
//  BaseVC.h
//  NewApp
//
//  Created by L on 15/9/17.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD.h"
#import "ConstantUI.h"
#import "MJRefresh.h"
#import "Reachability.h"
#import "AlertControllerUtility.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface BaseVC : UIViewController

@property (nonatomic, assign) BOOL isTabbar;

- (void)showLoading;
- (void)showLoadingWithMaskType;
- (void)request;

- (void)showWithStatus:(NSString *)str;
- (void)dismiss ;
- (void)dismissSuccess:(NSString *)str;
- (void)dismissError:(NSString *)str;
- (void)showWithStatus:(NSString *)str duration:(NSTimeInterval)time;
- (void)leftBtn;

-(BOOL) isConnectionAvailable;
//网络请求错误走如下菊花修改
- (void)requeststate;

- (void)setTabbar;
@end
