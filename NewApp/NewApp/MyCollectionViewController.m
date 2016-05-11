//
//  MyCollectionViewController.m
//  NewApp
//
//  Created by L on 15/10/13.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "CollectionCell.h"
@interface MyCollectionViewController ()
{
    NSArray *dataArray;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MY Collection";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = nav_Color;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

    // Do any additional setup after loading the view.
}

- (void)request
{
    [self showLoadingWithMaskType];
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    [LORequestManger POST:queryCollection_url params:dic URl:nil success:^(id response) {
        NSString *status = [response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            [self dismiss];
            NSLog(@"%@",response);
            dataArray = [response objectForKey:@"data"];
            [self.tableView reloadData];
        }else{
            [self dismissError:@"There is no Products"];
            NSLog(@"%@",response);

        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
        [self request];
    }];
}
#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    CollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[CollectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    [cell data:dataArray[indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
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
