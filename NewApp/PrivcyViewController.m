//
//  PrivcyViewController.m
//  NewApp
//
//  Created by 黄权浩 on 15/10/23.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "PrivcyViewController.h"

@interface PrivcyViewController ()

@end

@implementation PrivcyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _scr.contentSize = CGSizeMake(0, 911);
    self.title = @"Privacy Policy";
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
