//
//  LoginViewController.h
//  NewApp
//
//  Created by L on 15/9/21.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"
#import "LoginManagerViewController.h"
#import "LoginButtonViewController.h"

@interface LoginViewController : BaseVC<UITextFieldDelegate, FBSDKLoginButtonDelegate>

{
    @private
    
}
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) NSInteger tags;
@property (nonatomic, strong) NSString *zhuce;
@property (nonatomic, strong) NSString *tttt;


@end
