//
//  CartViewController.m
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "CartViewController.h"
#import "ShoppingCartCell.h"
#import "InfoViewController.h"
#import "LoginViewController.h"
#import "Notificatio.h"

@interface CartViewController ()
{
    UILabel * allPriceLabel;
    NSArray *cartInfoArray;
    NSDictionary *dataDic;
    UIView *viewbottom;
    UIImageView *imageView;
    UIButton *button;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Cart";
    [MobClick event:@"cart"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT-50) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = nav_Color;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self setFootView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deleteProduct:) name:@"deleteProduct" object:nil];

       // Do any additional setup after loading the view.
}
- (void)leftBtn
{
    if ([_tobbar isEqualToString:@"1"]) {
        [[AppDelegate getAppDelegate].tabbarVC headerMenu];
    }
    [self.navigationController popViewControllerAnimated:YES];

}

- (void)getShareStatus
{
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    [LORequestManger POST:getShareStatus_Url params:dic URl:nil success:^(id response) {
        NSLog(@"%@",response);
        [self request1];
        _isShare = NO;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)hiddeBottomView
{
    viewbottom.hidden = NO;
    [imageView removeFromSuperview];
    [button removeFromSuperview];
}

- (void)showBottomView
{
    viewbottom.hidden = YES;
    [self cartEmpty];
}
- (void)cartEmpty
{
    imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(0, 64, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT - 64);
    imageView.image = [UIImage imageNamed:@"cartImage"];
    [self.view addSubview:imageView];
    button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame =CGRectMake(100, 225, 120, 40);
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
- (void)back
{
    [self setTabbar];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self performSelector:@selector(sendNotification) withObject:self afterDelay:900];
}

- (void)sendNotification
{
    if ([Singleton BGBFyesorno]) {
        //前台
        [[Singleton sharedInstance]gotoappCart];
    }else{
        //后台
        //本地推送
        [Notificatio sendfaildNotificatio:1];
    }
}

- (void)request1
{
    [self showLoadingWithMaskType];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:MyZenID forKey:@"zenid"];
    [LORequestManger POST:queryAppCart_URL params:dic URl:nil success:^(id response) {
        NSLog(@"%@",response);
        NSString *status = [response objectForKey:@"status"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"getcartNumber" object:nil];
        if ([status isEqualToString:@"OK"]) {
            [self dismiss];
            [self hiddeBottomView];
            dataDic = [response objectForKey:@"data"];
            cartInfoArray = [dataDic objectForKey:@"cartInfo"];
            allPriceLabel.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"cartTotal"]];
            [self.tableView reloadData];
        }else{
            [self dismiss];
            cartInfoArray = nil;
            [self showBottomView];
            self.tableView.frame = [UIScreen mainScreen].bounds;
            allPriceLabel.text = @"0";
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
        [self request1];
    }];
}
- (void)setFootView
{
    viewbottom = [[UIView alloc]init];
    viewbottom.frame = CGRectMake(0, CURRENT_CONTENT_HEIGHT - 50, CURRENT_CONTENT_WIDTH, 50);
     UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(20, 10, 150, 30);
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = @"Total:";
    titleLabel.font = [UIFont systemFontOfSize:13];
    [viewbottom addSubview:titleLabel];
    
    
    allPriceLabel = [[UILabel alloc]init];
    allPriceLabel.frame = CGRectMake(60, 10, 150, 30);
    allPriceLabel.textColor = Btn_Color;
    allPriceLabel.font = [UIFont systemFontOfSize:15];
    [viewbottom addSubview:allPriceLabel];
    
    
    
    UIButton *checkoutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    checkoutBtn.frame = CGRectMake(CURRENT_CONTENT_WIDTH - 110, 10, 100, 30);
    checkoutBtn.backgroundColor = Btn_Color;
    [checkoutBtn setTitle:@"Checkout" forState:UIControlStateNormal];
    [checkoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [checkoutBtn addTarget:self action:@selector(checkout:) forControlEvents:UIControlEventTouchUpInside];
    [viewbottom addSubview:checkoutBtn];
    [self.view addSubview:viewbottom];

    
}
#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cartInfoArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[ShoppingCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    
    if (indexPath.row == cartInfoArray.count-1) {
        UIView *newview = [[UIView alloc] initWithFrame:CGRectMake(0, 120, [UIScreen mainScreen].bounds.size.width, 50)];
        newview.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0, 10, [UIScreen mainScreen].bounds.size.width, 40)];
        topview.backgroundColor = [UIColor whiteColor];
        [newview addSubview:topview];
        
        UIImageView *plane = [[UIImageView alloc] initWithFrame:CGRectMake(10, 11, 18, 18)];
        plane.image = [UIImage imageNamed:@"plane"];
        [topview addSubview:plane];
        
        UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(30, 12, 200, 40)];
        titlelb.text = @"Free Shipping Order Over";
        titlelb.font = [UIFont systemFontOfSize:12];
        [titlelb sizeToFit];
        [topview addSubview:titlelb];
        
        UILabel *pricelb = [[UILabel alloc] initWithFrame:CGRectMake(titlelb.frame.origin.x+titlelb.frame.size.width, 0, 100, 40)];
        pricelb.text = @" US$50";
        pricelb.textColor = Btn_Color;
        pricelb.font = [UIFont systemFontOfSize:12];
        [topview addSubview:pricelb];

        [cell.contentView addSubview:newview];
    }
    
    [cell changeNumber:^(NSDictionary *number) {
//        NSLog(@"%@", number);
        [self showLoadingWithMaskType];
        //进行求值增加减少
        if ([[number objectForKey:@"hascolor"] isEqualToString:@"OK"]) {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
            [dic setValue:MyZenID forKey:@"zenid"];
            [dic setObject:[number objectForKey:@"productnumber"] forKey:@"cart_quantity[]"];
            [dic setObject:[number objectForKey:@"productid"] forKey:@"products_id[]"];
            [dic setObject:[number objectForKey:@"sizeZhi"] forKey:[number objectForKey:@"sizecanshu"]];
            [dic setObject:[number objectForKey:@"colorZhi"] forKey:[number objectForKey:@"colorcanshu"]];
            [LORequestManger POST:updateAppCart_URL params:dic URl:nil success:^(id response) {
                //            NSLog(@"%@",response);
                NSString *status =[response objectForKey:@"status"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getcartNumber" object:nil];
                if ([status isEqualToString:@"OK"]) {
                    [self dismiss];
                    dataDic = [response objectForKey:@"data"];
                    cartInfoArray = [dataDic objectForKey:@"cartInfo"];
                    allPriceLabel.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"cartTotal"]];
                    [self.tableView reloadData];
                }else{
                    [self dismiss];
                    cartInfoArray = nil;
                    allPriceLabel.text = @"0";
                    [self.tableView reloadData];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
            }];
        }else {
            NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
            [dic setValue:MyZenID forKey:@"zenid"];
            [dic setObject:[number objectForKey:@"productnumber"] forKey:@"cart_quantity[]"];
            [dic setObject:[number objectForKey:@"productid"] forKey:@"products_id[]"];
            [dic setObject:[number objectForKey:@"sizeZhi"] forKey:[number objectForKey:@"sizecanshu"]];
            [LORequestManger POST:updateAppCart_URL params:dic URl:nil success:^(id response) {
                //            NSLog(@"%@",response);
                NSString *status =[response objectForKey:@"status"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"getcartNumber" object:nil];
                if ([status isEqualToString:@"OK"]) {
                    [self dismiss];
                    dataDic = [response objectForKey:@"data"];
                    cartInfoArray = [dataDic objectForKey:@"cartInfo"];
                    allPriceLabel.text = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"cartTotal"]];
                    [self.tableView reloadData];
                }else{
                    [self dismiss];
                    cartInfoArray = nil;
                    allPriceLabel.text = @"0";
                    [self.tableView reloadData];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
            }];
        }
    }];
    NSDictionary *dic = cartInfoArray[indexPath.row];
    [cell setValue:dic];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == cartInfoArray.count-1) {
        return 120*iphone_HIGHT+50;
    }else {
        return 120*iphone_HIGHT;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *status = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"isShare"]];

    if ([status isEqualToString:@"OK"]) {
        return 44;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *status = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"isShare"]];
    
    if ([status isEqualToString:@"OK"]) {
        UIView *view = [[UIView alloc]init];
//        view.backgroundColor = [UIColor blackColor];
        UILabel *discountLabel = [[UILabel alloc]init];
        discountLabel.text = @"Share Save:";
        discountLabel.frame = RECT(10, 12, 100, 20);
        discountLabel.font = [UIFont systemFontOfSize:15];
        [view addSubview:discountLabel];
        
        UILabel *shareLabel = [[UILabel alloc]init];
        shareLabel.text = [NSString stringWithFormat:@"-%@",[dataDic objectForKey:@"shareDiscount"]];
        shareLabel.frame = RECT(95, 12, 100, 20);
        shareLabel.font = [UIFont systemFontOfSize:15];
        shareLabel.textColor = Btn_Color;
        [view addSubview:shareLabel];
        
        return view;
    }else{
        return nil;
    }
    
}
- (void)checkout:(UIButton *)btn
{
    NSLog(@"清算购物车");
    NSDictionary *loginDic = [NSUserDefaultsDic valueForKey:@"loginOK"];
    if (loginDic) {
        InfoViewController *infoVC = [[InfoViewController alloc]init];
        infoVC.infoDic = dataDic;
        [self.navigationController pushViewController:infoVC animated:YES];
    }else{
        NSLog(@"登陆");
        LoginViewController *loginVC=[[LoginViewController alloc]init];
        loginVC.isLogin = YES;
        loginVC.zhuce = @"1";
        loginVC.tttt = @"1";
        loginVC.tags = 11;
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)deleteProduct:(NSNotification *)sender
{
    NSDictionary *cartInfo = sender.object;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setObject:MyZenID forKey:@"zenid"];
    [dic setObject:[cartInfo objectForKey:@"productID"] forKey:@"product_id"];
    [LORequestManger POST:removeAppCart_URL params:dic URl:dic success:^(id response) {
//        NSLog(@"%@",response);

        [self request1];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~%d",_isShare);
    
    if (_isShare) {
        [self getShareStatus];
    }else{
        [self request1];

    }

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
