//
//  CompleteViewController.m
//  NewApp
//
//  Created by L on 15/10/12.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "CompleteViewController.h"
#import "OrderViewController.h"
@interface CompleteViewController ()

@end

@implementation CompleteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Complete Order";
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(0, 64, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT-64);
    imageView.image = [UIImage imageNamed:@"comfirmed"];
    [self.view addSubview:imageView];
    NSDictionary *dic = [NSUserDefaultsDic valueForKey:@"loginOK"];
    UILabel *label = [[UILabel alloc]init];
    label.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"useremail"]];
    label.font = [UIFont systemFontOfSize:13];
    label.frame = CGRectMake(0, 145, CURRENT_CONTENT_WIDTH, 30);
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    
    UIButton *orderBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    orderBtn.frame = CGRectMake(30, 240, 120, 40);
    [orderBtn addTarget:self action:@selector(PushOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderBtn];
    
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    homeBtn.frame = CGRectMake(170, 240, 120, 40);
    [homeBtn addTarget:self action:@selector(PushHome:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
    
    // Do any additional setup after loading the view.
}


- (void)setLeft
{
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 12, 19);
//    [backButton setBackgroundImage:[UIImage imageNamed:@"back_hlight"] forState:UIControlStateNormal];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"back_hlight"] forState:UIControlStateHighlighted];
//    [backButton addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = barBtn;

}
- (void)PushOrder:(UIButton *)btn
{
    OrderViewController *orderVC = [[OrderViewController alloc]init];
    [self.navigationController pushViewController:orderVC animated:YES];
}


- (void)PushHome:(UIButton *)btn
{
    [self setTabbar];
    [self.navigationController popToRootViewControllerAnimated:YES];
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
