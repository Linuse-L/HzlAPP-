//
//  BaseVC.m
//  NewApp
//
//  Created by L on 15/9/17.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC
- (void)showLoading
{
    [SVProgressHUD show];
}

- (void)showLoadingWithMaskType
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
}

- (void)showWithStatus:(NSString *)str
{
    [SVProgressHUD showErrorWithStatus:str];
}
- (void)dismiss
{
    [SVProgressHUD dismiss];
}

- (void)showWithStatus:(NSString *)str duration:(NSTimeInterval)time
{
    [SVProgressHUD showSuccessWithStatus:str duration:time];
}
- (void)dismissSuccess:(NSString *)str
{
    [SVProgressHUD dismissWithSuccess:str];
}

- (void)dismissError:(NSString *)str
{
    [SVProgressHUD dismissWithError:str];
}
- (void)leftBtn
{
    if (_isTabbar) {
        [self setTabbar];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setTabbar
{
    [[AppDelegate getAppDelegate].tabbarVC headerMenu];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _isTabbar = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setLeft];
    [self request];
    
    // Do any additional setup after loading the view.
}

- (void)request
{
    
}
- (void)setLeft
{
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 12, 19);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_hlight"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_hlight"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = barBtn;
}

-(BOOL) isConnectionAvailable
{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            //            NSLog(@"WIFI");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            //NSLog(@"3G");
            break;
    }
    
    if (!isExistenceNetwork) {
        [SVProgressHUD showErrorWithStatus:@"Network error"];
        return NO;
    }
    
    return isExistenceNetwork;
}

-(void)requeststate
{
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            NSLog(@"notReachable");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            [self dismiss];
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            [self dismiss];
            break;
    }
    if (!isExistenceNetwork) {
        [SVProgressHUD showErrorWithStatus:@"Network error" duration:10];
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
