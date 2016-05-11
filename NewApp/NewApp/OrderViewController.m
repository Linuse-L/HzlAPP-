//
//  OrderViewController.m
//  NewApp
//
//  Created by L on 15/9/21.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderCell.h"
#import "PayViewController.h"
#import "NewPayViewController.h"
#import "SneakNewTrackViewController.h"

@interface OrderViewController ()
{
    UIView *LineView;
    UIView *view;
    NSDictionary *datadDic;
    NSArray *allData;
    NSString *orderID;
    NSString *panduanStr;
    NSDictionary *addressDic;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation OrderViewController

- (void)leftBtn
{
    if (self.isTabbar) {
        [[AppDelegate getAppDelegate].tabbarVC headerMenu];
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Orders";
    [MobClick event:@"orderhistory"];
    allData = [NSArray new];
    [self setHeaderView];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT-114) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    cellcanClick = NO;
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
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [tableView.footer endRefreshing];
        });
    }];

    // Do any additional setup after loading the view.
}

- (void)request
{
    NSMutableDictionary *dic = [[Singleton sharedInstance] zenidDic];
    [self showLoadingWithMaskType];
    [LORequestManger POST:nopayOrder_Url params:dic URl:nil success:^(id response) {
        NSString *status =[response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            NSLog(@"%@",response);
            [self dismiss];

            allData = [response objectForKey:@"data"];
            [self.tableView reloadData];
        }else{
            NSLog(@"%@",response);
            [self dismissError:@"no orders"];
            allData = [NSArray new];
            [self.tableView reloadData];

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dismiss];
        [self request];
    }];

}

- (void)paidOK
{
    NSMutableDictionary *dic = [[Singleton sharedInstance] zenidDic];
    [self showLoadingWithMaskType];
    [LORequestManger POST:paySuccessOrder_Url params:dic URl:nil success:^(id response) {
        NSString *status =[response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            [self dismiss];

            NSLog(@"%@",response);
            allData = [response objectForKey:@"data"];
            [self.tableView reloadData];
        }else{
            [self dismissError:@"No Order"];

            NSLog(@"%@",response);
            allData = nil;
            [self.tableView reloadData];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dismiss];
        [self paidOK];
    }];
}
- (void)setHeaderView
{
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CURRENT_CONTENT_HEIGHT, 40)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    NSArray *array = @[@"All Orders",@"Complete",@"Unpaid Order"];
    for (int i = 0; i<3; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake((CURRENT_CONTENT_WIDTH/3)*i, 5, CURRENT_CONTENT_WIDTH/3, 30);
        [btn setTitle:[NSString stringWithFormat:@"%@",array[i]] forState:UIControlStateNormal];
        btn.tag = 10+i;
        if (i == 0) {
            [btn setTitleColor:Btn_Color forState:UIControlStateNormal];

        }else{
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
//        btn.backgroundColor = Btn_Color;
        [view addSubview:btn];
    }
    

    LineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, CURRENT_CONTENT_WIDTH/3, 1)];
    
    LineView.backgroundColor = Btn_Color;
    [view addSubview:LineView];
}
#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return allData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *infos = [allData[section] objectForKey:@"products"];

    return infos.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    [cell setData:[[allData[indexPath.section] objectForKey:@"products"] objectAtIndex:indexPath.row]];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (cellcanClick) {
        NSMutableDictionary *dic = [[Singleton sharedInstance] zenidDic];
        [dic setValue:[allData[indexPath.section] objectForKey:@"orderID"] forKey:@"orderID"];
        [self showLoadingWithMaskType];
        [LORequestManger POST:getTrackInfo params:dic URl:nil success:^(id response) {
            NSString *status =[response objectForKey:@"status"];
            if ([status isEqualToString:@"OK"]) {
                NSLog(@"%@",response);
                [self dismiss];
                NSArray *array = [response objectForKey:@"data"];
                SneakNewTrackViewController *trackVC = [[SneakNewTrackViewController alloc] init];
                trackVC.alldata = allData[indexPath.section];
                trackVC.trackArray = array[0];
                [self.navigationController pushViewController:trackVC animated:YES];

            }else{
                [self dismiss];
                SneakNewTrackViewController *trackVC = [[SneakNewTrackViewController alloc] init];
                trackVC.alldata = allData[indexPath.section];
                [self.navigationController pushViewController:trackVC animated:YES];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self dismiss];
            [self request];
        }];

    }else{
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130*iphone_HIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
//heardView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    payOrderID =[[allData objectAtIndex:section] objectForKey:@"orderID"];
    payUrl = [[allData objectAtIndex:section] objectForKey:@"payUrl"];

    UIView *view1 = [[UIView alloc]init];
    view1.backgroundColor = [UIColor whiteColor];
    UILabel * orderNumLabel = [[UILabel alloc]init];
    orderNumLabel.text = [NSString stringWithFormat:@"Order Number:"];
    orderNumLabel.numberOfLines = 0;
    orderNumLabel.textColor = [UIColor blackColor];
    orderNumLabel.frame = CGRectMake(10, 5, CURRENT_DEVICE_WIDTH - 20, 20);
    orderNumLabel.font = [UIFont systemFontOfSize:13];
    [view1 addSubview:orderNumLabel];
    
    UILabel * orderLabel = [[UILabel alloc]init];
    orderLabel.text = [NSString stringWithFormat:@"%@",[[allData objectAtIndex:section] objectForKey:@"orderID"]];
    orderLabel.numberOfLines = 0;
    orderLabel.textColor = Btn_Color;
    orderLabel.frame = CGRectMake(100, 5, CURRENT_DEVICE_WIDTH - 20, 20);
    orderLabel.font = [UIFont systemFontOfSize:13];
    [view1 addSubview:orderLabel];
    
    return view1;
}


//footView
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    UIView *footView = [[UIView alloc]init];
    UIView *totalView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_HEIGHT, 65)];
    totalView.backgroundColor = [UIColor whiteColor];
    [footView addSubview:totalView];
    
    UIFont *font = [UIFont systemFontOfSize:13];
    CGSize sizeName = [[NSString stringWithFormat:@"%@",[[allData objectAtIndex:section] objectForKey:@"order_total"]] sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, 0.0) lineBreakMode:NSLineBreakByWordWrapping];
    
    UILabel * orderNumLabel = [[UILabel alloc]init];
    orderNumLabel.text = [NSString stringWithFormat:@"Order Total:"];
    orderNumLabel.numberOfLines = 0;
    orderNumLabel.textColor = [UIColor blackColor];
    orderNumLabel.frame = CGRectMake(10, 5, CURRENT_DEVICE_WIDTH - sizeName.width - 15, 20);
    orderNumLabel.textAlignment = NSTextAlignmentRight;
    orderNumLabel.font = [UIFont systemFontOfSize:13];
    [totalView addSubview:orderNumLabel];
    
    UILabel * totalPriceLabel = [[UILabel alloc]init];
    totalPriceLabel.text = [NSString stringWithFormat:@"%@",[[allData objectAtIndex:section] objectForKey:@"order_total"]];
    totalPriceLabel.numberOfLines = 0;
    totalPriceLabel.textColor = Btn_Color;
    totalPriceLabel.frame = CGRectMake(CURRENT_DEVICE_WIDTH - sizeName.width, 5, sizeName.width, 20);
    totalPriceLabel.textAlignment = NSTextAlignmentLeft;
    totalPriceLabel.font = [UIFont systemFontOfSize:13];
    [totalView addSubview:totalPriceLabel];
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancleBtn.frame = CGRectMake(CURRENT_CONTENT_WIDTH/2-50, 30, CURRENT_CONTENT_WIDTH/4+20, 30);
    [cancleBtn setTitle:[NSString stringWithFormat:@"Cancel Order"] forState:UIControlStateNormal];
    cancleBtn.layer.borderWidth = 0.5;
    cancleBtn.layer.borderColor = [[UIColor groupTableViewBackgroundColor]CGColor];
    cancleBtn.layer.cornerRadius = 3;

    cancleBtn.tag = section;
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (cellcanClick) {
        cancleBtn.hidden = YES;
    }
    [cancleBtn addTarget:self action:@selector(payAndCancleOrder:) forControlEvents:UIControlEventTouchUpInside];
    [totalView addSubview:cancleBtn];
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(cancleBtn.frame.origin.x+CURRENT_CONTENT_WIDTH/4+25 , cancleBtn.frame.origin.y, CURRENT_CONTENT_WIDTH/4+20, 30);
    [btn setTitle:[NSString stringWithFormat:@"Pay Now"] forState:UIControlStateNormal];
    btn.layer.borderWidth = 0.5;
    if (cellcanClick) {
        btn.hidden = YES;
    }
    btn.layer.borderColor = [[UIColor groupTableViewBackgroundColor]CGColor];
    btn.layer.cornerRadius = 3;

    btn.tag = section+1;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pay:) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = Btn_Color;
            [totalView addSubview:btn];

    
    return footView;
}

- (void)pay:(UIButton *)btn
{
    NSLog(@"重新支付");
    addressDic = [allData objectAtIndex:btn.tag-1];

    NewPayViewController *payVC = [[NewPayViewController alloc]init];
    payVC.isOrder = @"1";
    payVC.orderIdStr = [NSString stringWithFormat:@"%@",[addressDic objectForKey:@"orderID"]];
    payVC.payUrl = [NSString stringWithFormat:@"%@",[addressDic objectForKey:@"payUrl"]];
    payVC.addressDic = addressDic;
    payVC.totalStr = [NSString stringWithFormat:@"%@",[addressDic objectForKey:@"order_total"]];
    [self.navigationController pushViewController: payVC animated:YES];
}
- (void)btn:(UIButton *)btn
{
    [UIView animateWithDuration:.5 animations:^{
        LineView.frame = CGRectMake(CURRENT_CONTENT_WIDTH/3*(btn.tag-10), 39, CURRENT_CONTENT_WIDTH/3, 1);
    }];
    UIButton *btn1 = (UIButton *)[self.view viewWithTag:10];
    UIButton *btn2 = (UIButton *)[self.view viewWithTag:11];
    UIButton *btn3 = (UIButton *)[self.view viewWithTag:12];
    if (btn.tag == 10) {
        [self request];
        cellcanClick = NO;
        [btn1 setTitleColor:Btn_Color forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if(btn.tag == 11){
        [self paidOK];
        panduanStr = @"payOK";
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn2 setTitleColor:Btn_Color forState:UIControlStateNormal];
        [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        cellcanClick = YES;
    }
    else if(btn.tag == 12){
        [self request];
        panduanStr = @"payNO";
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn3 setTitleColor:Btn_Color forState:UIControlStateNormal];
        cellcanClick = NO;
    }
    
    NSLog(@"%ld",(long)btn.tag);
}

- (void)payAndCancleOrder:(UIButton *)btn
{
    if (btn.tag == 12) {
      
        
        
    }else{
        NSLog(@"删除订单");
        orderID =[[allData objectAtIndex:btn.tag] objectForKey:@"orderID"];

        NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
        [dic setObject:orderID forKey:@"orderID"];
        [LORequestManger POST:delOrder_Url params:dic URl:nil success:^(id response) {
            NSLog(@"%@",response);
            if ([panduanStr isEqualToString:@"payOK"]) {
                
                [self paidOK];
                
            }else if ([panduanStr isEqualToString:@"payNO"]){
                
                [self request];
                
            }else{
                
            [self request];
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [self dismiss];
        }];
        
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
