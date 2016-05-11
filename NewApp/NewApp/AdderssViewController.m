//
//  AdderssViewController.m
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "AdderssViewController.h"
#import "NewAddressViewController.h"
#import "LInfoCell.h"
@interface AdderssViewController ()
{
    NSDictionary * addressDic;
}
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation AdderssViewController

- (void)addAddress
{
    NSLog(@"添加新地址");
    NewAddressViewController *newVC = [[NewAddressViewController alloc]init];
    [self.navigationController pushViewController:newVC animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Address";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAddress)];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT-50) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = nav_Color;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self setFootView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(editAddress:) name:@"editAddress" object:nil];
    // Do any additional setup after loading the view.
}

- (void)setFootView
{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, CURRENT_CONTENT_HEIGHT - 50, CURRENT_CONTENT_WIDTH, 50);
    //    view.backgroundColor = [UIColor blackColor];
    
    UIButton *checkoutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    checkoutBtn.frame = CGRectMake(CURRENT_CONTENT_WIDTH - 110, 10, 100, 30);
    checkoutBtn.backgroundColor = Btn_Color;
    [checkoutBtn setTitle:@"OK" forState:UIControlStateNormal];
    [checkoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [checkoutBtn addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:checkoutBtn];
    [self.view addSubview:view];
    
    
}
- (void)selectAddress
{
    if (addressDic == nil) {
        [self showWithStatus:@"Please select the address"];
    }else{
        [self.delegate addressDic:addressDic];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)request1
{
    [self showLoadingWithMaskType];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [LORequestManger POST:getUserAddress_URL params:dic URl:nil success:^(id response) {
        [self dismiss];
        NSLog(@"%@",response);
        NSString *status =[response objectForKey:@"status"];

        if ([status isEqualToString:@"OK"]) {
            _addressArray = [response objectForKey:@"data"];
            [self.tableView reloadData];
        }else{
            NSLog(@"%@",response);
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dismiss];
        [self request1];
    }];
}

#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.addressArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    LInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[LInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
//    if (indexPath.row == 0) {
//        [cell setSelected:YES];
//    }
    [cell setData:self.addressArray[indexPath.row]];
        return cell;
}


-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LInfoCell *cell = (LInfoCell*)[tableView cellForRowAtIndexPath:indexPath];
   
//    if (indexPath.row == 0) {
//        [cell setSelected:YES];
//    }else{
    [cell setSelected:NO];
//    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LInfoCell *cell = (LInfoCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setSelected:YES];
    cell.isSelect = NO;
    addressDic = self.addressArray[indexPath.row];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90*iphone_HIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)editAddress:(NSNotification *)sender
{
    NSDictionary *dic = sender.object;
    NSLog(@"%@",dic);
    NewAddressViewController *newVC = [[NewAddressViewController alloc]init];
    newVC.addressDic = dic;
    newVC.isEdit = YES;
    [self.navigationController pushViewController:newVC animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self request1];
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
