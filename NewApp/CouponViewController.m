//
//  CouponViewController.m
//  NewApp
//
//  Created by 黄权浩 on 15/12/11.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "CouponViewController.h"
#import "MyCouponCell.h"

@interface CouponViewController ()

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Select Coupon";
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 40)];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
    lb.text = @"Select existing coupon";
    lb.font = [UIFont systemFontOfSize:13];
    [view addSubview:lb];
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 39, self.view.bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [view addSubview:lineView];
    [self.view addSubview:view];
}

- (void)returnText:(ReturnStringBlock)block
{
    self.returnTextBlock = block;
}

- (void)returnPrice:(ReturnPrice)block
{
    self.returnPrice = block;
}

#pragma mark - UiTableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.couponArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"indexCellid";
    MyCouponCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"MyCouponCell" owner:self options:nil];
        cell = nib[0];
    }
    [cell setDic:self.couponArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.couponArr[indexPath.row];
    if ([[dic objectForKey:@"canUse"]isEqualToString:@"false"]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:[dic objectForKey:@"notice"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alert show];
    }else {
        //使用成功
        if (self.returnTextBlock != nil) {
            self.returnTextBlock([NSString stringWithFormat:@"%@", [dic objectForKey:@"id"]]);
        }
        if (self.returnPrice != nil) {
            self.returnPrice([NSString stringWithFormat:@"%@", [dic objectForKey:@"amount"]]);
        }
        [self.navigationController popViewControllerAnimated:YES];
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
