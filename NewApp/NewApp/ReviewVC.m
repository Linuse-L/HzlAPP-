//
//  ReviewVC.m
//  NewApp
//
//  Created by L on 15/9/21.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "ReviewVC.h"
#import "WirteReViewViewController.h"
#import "ReviewCell.h"
@interface ReviewVC ()
{
    NSMutableArray *dataArray;
    NSInteger page;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ReviewVC
- (void)pushWrite
{
    NSLog(@"写评论");
    WirteReViewViewController *wirteVC = [[WirteReViewViewController alloc]init];
    wirteVC.product_id = self.positionID;
    [self.navigationController pushViewController:wirteVC animated:YES];
}
- (void)leftBtn
{
    if ([_aaa isEqualToString:@"1"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    page = 1;
    dataArray = [NSMutableArray arrayWithCapacity:1];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Rating&Feedback";
    [self setRightBtn];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    __weak UITableView *tableView = self.tableView;
    
    // 下拉刷新
    tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.header endRefreshing];
        });
    }];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    tableView.header.automaticallyChangeAlpha = YES;
    
    // 上拉刷新
    tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            page++;
            [self request];
            [tableView.footer endRefreshing];
        });
    }];
    

    // Do any additional setup after loading the view.
}

- (void)request
{
    [self showLoadingWithMaskType];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *zendID = MyZenID;
    [dic setObject:zendID forKey:@"zenid"];
    [dic setValue:_positionID forKey:@"products_id"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [LORequestManger POST:reviewList_Url params:dic URl:nil success:^(id response) {
        NSLog(@"%@",response);
        NSString *status =[NSString stringWithFormat:@"%@",[response objectForKey:@"status"]];
        if ([status isEqualToString:@"OK"]) {
            [self dismiss];
            NSArray * array = [response objectForKey:@"data"];
            
            [dataArray addObjectsFromArray:array];
//            NSLog(@"%@",dataArray);
            [self.tableView reloadData];
        }else{
            [self dismissError:@"No comments"];
            
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
        [self request];
    }];
}
- (void)setRightBtn
{
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 15, 15);
    [backButton setBackgroundImage:[UIImage imageNamed:@"writeImage"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"writeImage"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(pushWrite) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.rightBarButtonItem = barBtn;
}

#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    ReviewCell *cell = (ReviewCell*)[tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ReviewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    [cell setdata:dataArray[indexPath.section]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ReviewCell heightForStudent:dataArray[indexPath.section]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
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
