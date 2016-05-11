//
//  LoginViewController.m
//  NewApp
//
//  Created by L on 15/9/21.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "LoginViewController.h"
#import "IQKeyboardManager.h"

@interface LoginViewController ()
{
    UIScrollView *scrollView;
    UIScrollView *scrollView1;
    NSString *fbemail;
}
@property (nonatomic, strong) UITextField *emailTF;
@property (nonatomic, strong) UITextField *passWordTF;


@property (nonatomic, strong) UITextField *registEmailTF;
@property (nonatomic, strong) UITextField *re_PassWordTF;
@property (nonatomic, strong) UITextField *re_agPassWordTF;


@end

@implementation LoginViewController

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Login";
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    scrollView = [[UIScrollView alloc]initWithFrame:RECT(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT)];
    [self.view addSubview:scrollView];
    scrollView1 = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 130, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT - 130)];
    scrollView1.contentSize = CGSizeMake(CURRENT_CONTENT_WIDTH*2, CURRENT_CONTENT_HEIGHT - 130);
    [scrollView addSubview:scrollView1];
    
    //FBlogin 1
//    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    loginButton.frame = CGRectMake(10, CURRENT_CONTENT_HEIGHT-60, CURRENT_CONTENT_WIDTH-20, 40);
//    loginButton.backgroundColor = [UIColor redColor];
//    [loginButton addTarget:self action:@selector(lodddd) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:loginButton];
    //FBlogin 2
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.frame = CGRectMake(10, CURRENT_CONTENT_HEIGHT-60, CURRENT_CONTENT_WIDTH-20, 40);
    loginButton.delegate = self;
    loginButton.tooltipBehavior = FBSDKLoginButtonTooltipBehaviorForceDisplay;
    loginButton.loginBehavior = FBSDKLoginBehaviorWeb;
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    [self.view addSubview:loginButton];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    NSArray *array = @[@"Register",@"Sign In"];
    for (int i = 0; i < 2; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(CURRENT_CONTENT_WIDTH/2*i+10, 60, CURRENT_CONTENT_WIDTH/2-20, 40);
        btn.layer.cornerRadius = 3;
        btn.layer.borderWidth = 0.5;
        btn.tag = 10+i;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:btn];
    }
    UIButton *btn = (UIButton *)[self.view viewWithTag:_tags];
    [btn setTitleColor:Btn_Color forState:UIControlStateNormal];
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"Welcome";
    titleLabel.textColor = Btn_Color;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.frame = CGRectMake(10, 10, CURRENT_DEVICE_WIDTH - 20, 40);
    titleLabel.font = [UIFont systemFontOfSize:30];
    [scrollView addSubview:titleLabel];
    scrollView1.scrollEnabled = NO;
    [self setLogin];
    [self setRegistView];
    if (_isLogin ) {
        scrollView1.contentOffset = CGPointMake(0, 0);
    }else{
        scrollView1.contentOffset = CGPointMake(CURRENT_CONTENT_WIDTH, 0);
    }
    
    
    if ([_zhuce isEqualToString:@"1"]) {
        NSLog(@"注册");
        [self.registEmailTF becomeFirstResponder];
        UIButton *btn = (UIButton *)[self.view viewWithTag:10];
        [btn setTitleColor:Btn_Color forState:UIControlStateNormal];
        scrollView1.contentOffset = CGPointMake(CURRENT_CONTENT_WIDTH, 0);
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:11];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
     // Do any addfl[flpflpitional setup after loading the view.
}

#pragma mark - FBSDKLoginButtonDelegate

- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    UIAlertController *alertController;
    if (error) {
        alertController = [AlertControllerUtility alertControllerWithTitle:@"Login Fail"
                                                                   message:[NSString stringWithFormat:@"Login fail with error: %@", error]];
    } else if (!result || result.isCancelled) {
        alertController = [AlertControllerUtility alertControllerWithTitle:@"Login Cancelled"
                                                                   message:@"User cancelled login"];
    } else {
        alertController = [AlertControllerUtility alertControllerWithTitle:@"Login Success"
                                                                   message:[NSString stringWithFormat:@"Login success with granted permission: %@", [[result.grantedPermissions allObjects] componentsJoinedByString:@" "]] ];
        
        
        //这里来做fb登录成功后的判断
        //facebook测试
        [[[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:nil]startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
            //id = 1525628844432683;
//            name = "\U9ec4\U6743\U6d69"
            NSLog(@"fetched user:%@", result);
            fbemail = [NSString stringWithFormat:@"%@@facebook.com", [result objectForKey:@"id"]];
            if ([result objectForKey:@"id"] != nil) {
                //先注册后登录
                NSMutableDictionary *zhucedic = [NSMutableDictionary dictionaryWithCapacity:1];
                NSString *zendID = MyZenID;
                [zhucedic setObject:zendID forKey:@"zenid"];
                [zhucedic setValue:@"l" forKey:@"firstname"];
                [zhucedic setValue:@"jl" forKey:@"lastname"];
                [zhucedic setValue:@"用户" forKey:@"nickname"];
                [zhucedic setValue:fbemail forKey:@"email"];
                [zhucedic setValue:@"111111" forKey:@"password"];
                
                [LORequestManger POST:Regist_Url params:zhucedic URl:nil success:^(id response) {
                    NSDictionary *dic = response;
                    NSString *status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
                    if ([status isEqualToString:@"OK"]) {
                        [self showLoadingWithMaskType];
                        NSMutableDictionary *loginOK = [NSMutableDictionary dictionaryWithCapacity:1];
                        NSString *email = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"email"]];
                        NSString *password =[NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"password"]];
                        NSString *zendID = MyZenID;
                        [loginOK setObject:zendID forKey:@"zenid"];
                        [loginOK setValue:email forKey:@"useremail"];
                        [loginOK setValue:password forKey:@"password"];
                        NSLog(@"%@",response);
                        [self login2:loginOK];
                        
                    }else{
                        //直接登录
                        [self showLoadingWithMaskType];
                        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
                        NSString *zendID = MyZenID;
                        [dic setObject:zendID forKey:@"zenid"];
                        [dic setValue:fbemail forKey:@"useremail"];
                        [dic setValue:@"111111" forKey:@"password"];
                        [LORequestManger POST:Login_Url params:dic URl:nil success:^(id response) {
                            NSDictionary *dataDic = response;
                            NSString *status = [dataDic objectForKey:@"status"];
                            if ([status isEqualToString:@"OK"]) {
                                [self dismiss];
                                [dic setValue:@"1" forKey:@"fb"];
                                [NSUserDefaultsDic setObject:dic forKey:@"loginOK"];
                                [NSUserDefaultsDic synchronize];
                                NSLog(@"%@",response);
                                
                                [self.navigationController popViewControllerAnimated:YES];
                                
                            }else{
                                [self dismissError:@"Faild"];
                                NSLog(@"%@",response);
                            }
                            
                        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                            
                        }];
                    }
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                }];

            }
        }];
        
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    UIAlertController *alertController = [AlertControllerUtility alertControllerWithTitle:@"Log out" message:@"Log out success"];
    [self presentViewController:alertController animated:YES completion:nil];
}


//- (void)lodddd
//{
//    void(^loginHandler)(FBSDKLoginManagerLoginResult *result, NSError *error) = ^(FBSDKLoginManagerLoginResult *result, NSError *error){
//        UIAlertController *alertController;
//        if (error) {
//            alertController = [AlertControllerUtility alertControllerWithTitle:@"Login Fail"
//                                                                       message:[NSString stringWithFormat:@"Login fail with error: %@", error]];
//        } else if (!result || result.isCancelled) {
//            alertController = [AlertControllerUtility alertControllerWithTitle:@"Login Cancelled"
//                                                                       message:@"User cancelled login"];
//        } else {
//            alertController = [AlertControllerUtility alertControllerWithTitle:@"Login Success"
//                                                                       message:[NSString stringWithFormat:@"Login success with granted permission: %@", [[result.grantedPermissions allObjects] componentsJoinedByString:@" "]] ];
//        }
//        [self presentViewController:alertController animated:YES completion:nil];
//    };
//    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
//    if (![FBSDKAccessToken currentAccessToken]) {
//        [loginManager logInWithReadPermissions: @[@"public_profile", @"user_friends"]
//                            fromViewController:self
//                                       handler:loginHandler];
//    } else {
//        [loginManager logOut];
//        UIAlertController *alertController = [AlertControllerUtility alertControllerWithTitle:@"Logout"
//                                                                                      message:@"Logout"];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
//
//}

- (void)setLogin{
    
    self.emailTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, CURRENT_CONTENT_WIDTH - 20, 40)];
    self.emailTF.placeholder = @"E-Mail";
    self.emailTF.borderStyle  = UITextBorderStyleBezel;
    [scrollView1 addSubview:self.emailTF];
    self.passWordTF = [[UITextField alloc]initWithFrame:CGRectMake(10, self.emailTF.frame.origin.y+50, CURRENT_CONTENT_WIDTH - 20, 40)];
    self.passWordTF.placeholder = @"Password";
    self.passWordTF.borderStyle  = UITextBorderStyleBezel;
    self.passWordTF.secureTextEntry = YES;
    [scrollView1 addSubview:self.passWordTF];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(10, self.emailTF.frame.origin.y+100, CURRENT_CONTENT_WIDTH - 20, 45);
    [btn setTitle:@"Sign in" forState:UIControlStateNormal];
    btn.backgroundColor = Btn_Color;
    btn.layer.cornerRadius = 3;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    [scrollView1 addSubview:btn];
    
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    forgetBtn.frame = CGRectMake(CURRENT_CONTENT_WIDTH - 180, self.emailTF.frame.origin.y+150, 170, 45);
    [forgetBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    forgetBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [forgetBtn addTarget:self action:@selector(forgotBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [scrollView1 addSubview:forgetBtn];
    
    
    UILabel *  titleLabel = [[UILabel alloc]init];
    titleLabel.text = @"Forgot password?";
    titleLabel.frame = CGRectMake(10,0, 160, 20);
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.textColor  = backGroud_Color;
    titleLabel.font = [UIFont systemFontOfSize:13];
//    [forgetBtn addSubview:titleLabel];
    //    fieldArray =[NSMutableDictionary dictionaryWithCapacity:10];
    UIView *keyview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    keyview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.2];
    //收回键盘的按钮
    UIButton *keydown = [UIButton buttonWithType:UIButtonTypeCustom];
    keydown.backgroundColor = [UIColor grayColor];
    keydown.frame = CGRectMake(250, 5, 60, 30);
    [keydown setTitle:@"Done" forState:UIControlStateNormal];
    [keydown setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    keydown.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [keydown addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    
    [keyview addSubview:keydown];
    self.emailTF.inputAccessoryView = keyview;
    self.passWordTF.inputAccessoryView = keyview;

}

- (void)setRegistView
{
    self.registEmailTF = [[UITextField alloc]initWithFrame:CGRectMake(CURRENT_CONTENT_WIDTH+10, 0, CURRENT_CONTENT_WIDTH - 20, 40)];
    self.registEmailTF.placeholder = @"E-Mail";
    self.registEmailTF.borderStyle  = UITextBorderStyleBezel;
    [scrollView1 addSubview:self.registEmailTF];
    
    self.re_PassWordTF = [[UITextField alloc]initWithFrame:CGRectMake(self.registEmailTF.frame.origin.x, self.registEmailTF.frame.origin.y+50, CURRENT_CONTENT_WIDTH - 20, 40)];
    self.re_PassWordTF.placeholder = @"Password";
    self.re_PassWordTF.borderStyle  = UITextBorderStyleBezel;
    self.re_PassWordTF.secureTextEntry = YES;
    [scrollView1 addSubview:self.re_PassWordTF];

    
    self.re_agPassWordTF = [[UITextField alloc]initWithFrame:CGRectMake(self.registEmailTF.frame.origin.x, self.registEmailTF.frame.origin.y+100, CURRENT_CONTENT_WIDTH - 20, 40)];
    self.re_agPassWordTF.placeholder = @"Password";
    self.re_agPassWordTF.borderStyle  = UITextBorderStyleBezel;
    self.re_agPassWordTF.secureTextEntry = YES;
    [scrollView1 addSubview:self.re_agPassWordTF];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(CURRENT_CONTENT_WIDTH+10, self.registEmailTF.frame.origin.y+150, CURRENT_CONTENT_WIDTH - 20, 45);
    [btn setTitle:@"Create Account" forState:UIControlStateNormal];
    btn.backgroundColor = Btn_Color;
    btn.layer.cornerRadius = 3;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn addTarget:self action:@selector(regist) forControlEvents:UIControlEventTouchUpInside];
    [scrollView1 addSubview:btn];
    self.emailTF.delegate = self;
    self.passWordTF.delegate = self;
    self.registEmailTF.delegate = self;
    self.re_agPassWordTF.delegate = self;
    self.re_PassWordTF.delegate = self;
    //    fieldArray =[NSMutableDictionary dictionaryWithCapacity:10];
    UIView *keyview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    keyview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.2];
    //收回键盘的按钮
    UIButton *keydown = [UIButton buttonWithType:UIButtonTypeCustom];
    keydown.backgroundColor = [UIColor grayColor];
    keydown.frame = CGRectMake(250, 5, 60, 30);
    [keydown setTitle:@"Done" forState:UIControlStateNormal];
    [keydown setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    keydown.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [keydown addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    
    [keyview addSubview:keydown];
    self.re_agPassWordTF.inputAccessoryView = keyview;
    self.re_PassWordTF.inputAccessoryView = keyview;
    self.registEmailTF.inputAccessoryView = keyview;
}

- (void)jianpan
{
 
}

- (void)login
{
    [MobClick event:@"login"];
    NSLog(@"login");
    [self showLoadingWithMaskType];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *zendID = MyZenID;
    [dic setObject:zendID forKey:@"zenid"];
    [dic setValue:self.emailTF.text forKey:@"useremail"];
    [dic setValue:self.passWordTF.text forKey:@"password"];
    [LORequestManger POST:Login_Url params:dic URl:nil success:^(id response) {
        NSDictionary *dataDic = response;
        NSString *status = [dataDic objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            [self dismissSuccess:@"Login OK"];
            [dic setValue:@"0" forKey:@"fb"];
            [NSUserDefaultsDic setObject:dic forKey:@"loginOK"];
            [NSUserDefaultsDic synchronize];
            NSLog(@"%@",response);
            [self isTbaar];
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            [self dismissError:@"Faild"];
            NSLog(@"%@",response);
        }

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        [self login];
    }];
}

- (void)regist
{

    [MobClick event:@"regist"];
    NSLog(@"注册");
    [self showLoadingWithMaskType];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *zendID = MyZenID;
    [dic setObject:zendID forKey:@"zenid"];
    [dic setValue:@"l" forKey:@"firstname"];
    [dic setValue:@"jl" forKey:@"lastname"];
    [dic setValue:@"用户" forKey:@"nickname"];
    [dic setValue:self.registEmailTF.text forKey:@"email"];
    [dic setValue:self.re_PassWordTF.text forKey:@"password"];
    
    if ([self.re_PassWordTF.text isEqualToString: self.re_agPassWordTF.text]) {
        [LORequestManger POST:Regist_Url params:dic URl:nil success:^(id response) {
            NSDictionary *dic = response;
            NSString *status = [NSString stringWithFormat:@"%@",[dic objectForKey:@"status"]];
            if ([status isEqualToString:@"OK"]) {
                NSMutableDictionary *loginOK = [NSMutableDictionary dictionaryWithCapacity:1];
                NSString *email = [NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"email"]];
                NSString *password =[NSString stringWithFormat:@"%@",[[dic objectForKey:@"data"] objectForKey:@"password"]];
                NSString *zendID = MyZenID;
                [loginOK setObject:zendID forKey:@"zenid"];
                [loginOK setValue:email forKey:@"useremail"];
                [loginOK setValue:password forKey:@"password"];
                NSLog(@"%@",response);
                [self login:loginOK];
                
            }else{
                [self dismissError:@"Please fill in your email or password"];
                NSLog(@"%@",response);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self regist];
        }];
    }else{
        [self dismissError:@"Do not match the password input"];
    }
    
}
- (void)leftBtn
{
    if ([_tttt isEqualToString:@"1"]) {
        
    }else{
        [self setTabbar];
    }
    [self.navigationController popViewControllerAnimated:YES];

}
- (void)isTbaar
{
    if ([_tttt isEqualToString:@"1"]) {
        
    }else{
        [self setTabbar];
    }
    
}
- (void)login:(NSDictionary *)dic
{
    [LORequestManger POST:Login_Url params:dic URl:nil success:^(id response) {
        NSDictionary *dataDic = response;
        NSString *status = [dataDic objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            [self dismissSuccess:@"Login OK"];
            [dic setValue:@"0" forKey:@"fb"];
            [NSUserDefaultsDic setObject:dic forKey:@"loginOK"];
            [NSUserDefaultsDic synchronize];
            NSLog(@"%@",response);
            [self isTbaar];

            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self dismissError:@"Faild"];
            NSLog(@"%@",response);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
    }];

}

- (void)login2:(NSDictionary *)dic
{
    [LORequestManger POST:Login_Url params:dic URl:nil success:^(id response) {
        NSDictionary *dataDic = response;
        NSString *status = [dataDic objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            [self dismissSuccess:@"Login OK"];
            [dic setValue:@"1" forKey:@"fb"];
            [NSUserDefaultsDic setObject:dic forKey:@"loginOK"];
            [NSUserDefaultsDic synchronize];
            NSLog(@"%@",response);
            [self dismiss];
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [self dismissError:@"Faild"];
            NSLog(@"%@",response);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        
    }];
    
}

- (void)forgotBtn
{
    NSLog(@"忘记密码");
}

- (void)btn:(UIButton*)btn
{
    if (btn.tag == 10) {
        NSLog(@"注册");
        [self.registEmailTF becomeFirstResponder];
        scrollView1.contentOffset = CGPointMake(CURRENT_CONTENT_WIDTH, 0);
        [btn setTitleColor:Btn_Color forState:UIControlStateNormal];
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:11];

        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        NSLog(@"登陆");
        [self.emailTF becomeFirstResponder];
        scrollView1.contentOffset = CGPointMake(0, 0);
        [btn setTitleColor:Btn_Color forState:UIControlStateNormal];
        UIButton *btn1 = (UIButton *)[self.view viewWithTag:10];
        
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    }
}
#pragma mark - 手势回收键盘
- (void)tap
{
    [self.emailTF resignFirstResponder];
    [self.passWordTF resignFirstResponder];
    [self.registEmailTF resignFirstResponder];
    [self.re_agPassWordTF resignFirstResponder];
    [self.re_PassWordTF resignFirstResponder];
    [UIView animateWithDuration:.5 animations:^{
//        scrollView1.contentOffset = CGPointMake(0, 0);
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return [textField resignFirstResponder];
  
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.re_agPassWordTF) {
        [UIView animateWithDuration:.5 animations:^{
//            scrollView1.contentOffset = CGPointMake(0, 20);
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
