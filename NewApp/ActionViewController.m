//
//  ActionViewController.m
//  NewApp
//
//  Created by L on 16/4/25.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "ActionViewController.h"
#import "NewTimeCell.h"

@interface ActionViewController ()
@property (nonatomic, strong) UITableView *tabelView;
@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Action";
    self.tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT-50) style:UITableViewStyleGrouped];
    self.tabelView.separatorStyle =UITableViewCellSeparatorStyleNone;
    self.tabelView.backgroundColor = RGB_Color(231, 231, 231);
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.view addSubview:self.tabelView];

    // Do any additional setup after loading the view.
}
- (void)setLeft
{
    
}

- (void)request
{
    [self showLoadingWithMaskType];
    
    [LORequestManger GET:Activity_URL success:^(id response) {
        [self dismiss];
        NSLog(@"%@",response);
        NSDictionary *dic = [response objectForKey:@"data"];
        limitActivityDic = [dic objectForKey:@"limitActivity"];
        otherActivity = [dic objectForKey:@"otherActivity"];
        [self.tabelView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
        //错误重新请求
        [self request];
    }];
}
#pragma mark - TableView delegate datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return otherActivity.count + 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        static NSString *str_Cell = @"str_Cell1";
        NewTimeCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[NewTimeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_Cell];
        }
        NSArray *array =[[limitActivityDic objectForKey:@"list"] objectForKey:@"data"];
        if (array) {
            [cell dataWith:array];

        }
        
        [cell Block:^(NSString *a) {
            DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
            [[AppDelegate getAppDelegate].tabbarVC removeTabbar];
            detailsVC.positionID = a;
            detailsVC.ttt = @"1";
            [self.navigationController pushViewController:detailsVC animated:YES];
        }];
        return cell;

    }else if (indexPath.row == 0){
    static NSString *str_Cell = @"str_Cell";
    HomeBanderCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell==nil) {
        cell = [[HomeBanderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_Cell];
    }
//    cell bannerData
        NSDictionary *ddd = [limitActivityDic objectForKey:@"2"];
        [cell  bannerData:ddd];
    return cell;
    }else{
        static NSString *str_Cell = @"str_Cell2";
        NewRecCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[NewRecCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str_Cell];
        }
        NSDictionary *d = otherActivity[indexPath.row -2];
        [cell setDataWith:d];
        [cell Block:^(NSString *a) {
            DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
            [[AppDelegate getAppDelegate].tabbarVC removeTabbar];
            detailsVC.positionID = a;
            detailsVC.ttt = @"1";
            [self.navigationController pushViewController:detailsVC animated:YES];
        }];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        return 180;
    }else if (indexPath.row == 0){
    return 180;
    }else{
        return 340;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00000000000000001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
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
