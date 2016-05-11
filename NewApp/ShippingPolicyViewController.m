//
//  ShippingPolicyViewController.m
//  NewApp
//
//  Created by 黄权浩 on 15/11/24.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "ShippingPolicyViewController.h"

@interface ShippingPolicyViewController ()

@end

@implementation ShippingPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _webView.scalesPageToFit = NO;
    NSString *fullPath = [NSBundle pathForResource:@"shipping"
                                            ofType:@"html" inDirectory:[[NSBundle mainBundle] bundlePath]];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:fullPath]]];
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
