//
//  SettingViewController.m
//  NewApp
//
//  Created by 黄权浩 on 15/10/21.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "SettingViewController.h"
#import "ReturnViewController.h"
#import "ProvacyController.h"
#import "PrivcyViewController.h"
#import "Return2ViewController.h"
#import "ShippingPolicyViewController.h"

@interface SettingViewController ()
{
@private
    NSArray *titleArray;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [MobClick event:@"setting"];
    self.title = @"Setting";
    if (!titleArray) {
        titleArray = @[@"Western Union", @"MoneyGram", @"Return Policy", @"Privacy Policy", @"Shipping Policy", @"Logout"];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.text = titleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 5) {
        [MobClick event:@"logon"];
        if (self.returnTextBlock != nil) {
            [self.navigationController popViewControllerAnimated:YES];
            self.returnTextBlock();
        }
    }else if (indexPath.row == 0) {
        Return2ViewController *r = [[Return2ViewController alloc] init];
        [self.navigationController pushViewController:r animated:YES];
    }else if (indexPath.row == 1) {
        ReturnViewController *r = [[ReturnViewController alloc] init];
        r.viewtitle = @"MoneyGram";
        r.imageReturn.image = [UIImage imageNamed:@"Money.png"];
        [self.navigationController pushViewController:r animated:YES];
    }else if (indexPath.row == 2) {
        ProvacyController *p = [[ProvacyController alloc] init];
        [self.navigationController pushViewController:p animated:YES];
    }else if (indexPath.row == 3) {
        PrivcyViewController *p = [[PrivcyViewController alloc] init];
        [self.navigationController pushViewController:p animated:YES];
    }else if (indexPath.row == 4) {
        ShippingPolicyViewController *p = [[ShippingPolicyViewController alloc] init];
        [self.navigationController pushViewController:p animated:YES];
    }
}

- (void)backsomething:(ReturnStringBlock)block
{
    self.returnTextBlock = block;
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
