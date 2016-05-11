//
//  CurrencyController.m
//  NewApp
//
//  Created by 黄权浩 on 15/10/19.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "CurrencyController.h"
#import "CurrencyCell.h"
#import "LORequestManger.h"
#import "UIViewController+MMDrawerController.h"

@interface CurrencyController ()
{
@private
    NSArray *allData;
}
@end

@implementation CurrencyController

- (void)viewDidLoad {
    [super viewDidLoad];
    allData = [NSArray new];
    _tab = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT) style:UITableViewStylePlain];
    _tab.delegate = self;
    _tab.dataSource = self;
    [self.view addSubview:_tab];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Currency";
    
    NSMutableDictionary *dic = [[Singleton sharedInstance] zenidDic];
    [self showLoadingWithMaskType];
    [LORequestManger POST:getCurrencies_url params:dic URl:nil success:^(id response) {
        NSString *status =[response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            allData = [response objectForKey:@"data"];
            [_tab reloadData];
            [self dismiss];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dismiss];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return allData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"indexpathcell";
    CurrencyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CurrencyCell" owner:self options:nil];
        cell = nib[0];
    }
    [cell setDic:allData[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *dic = [[Singleton sharedInstance] zenidDic];
    [self showLoadingWithMaskType];
    [dic setValue:[allData[indexPath.row] objectForKey:@"code"]forKey:@"currency"];
    [LORequestManger POST:setCurrency_url params:dic URl:nil success:^(id response) {
        [self dismiss];
        NSString *status =[response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dismiss];
    }];
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
