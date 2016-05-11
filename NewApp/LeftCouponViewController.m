//
//  LeftCouponViewController.m
//  NewApp
//
//  Created by 黄权浩 on 15/12/14.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "LeftCouponViewController.h"
#import "MyCouponCell.h"

@interface LeftCouponViewController ()
{
@private
    NSArray *couponarr;
}
@end

@implementation LeftCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    couponarr = [NSArray array];
    self.title = @"Coupon";
    //优惠券接口
    NSMutableDictionary *dic2 = [[Singleton sharedInstance] zenidDic];
    [LORequestManger POST:coupon_url params:dic2 URl:nil success:^(id response) {
        NSString *status =[response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            NSDictionary *data = [response objectForKey:@"data"];
            couponarr = [data objectForKey:@"couponList"];
            [self.tableView reloadData];
        }else{
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - UiTableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return couponarr.count;
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
    cell.panduan = @"1";
    [cell setDic:couponarr[indexPath.row]];
    return cell;
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
