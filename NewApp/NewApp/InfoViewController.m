//
//  InfoViewController.m
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "InfoViewController.h"
#import "AdderssViewController.h"
#import "PayViewController.h"
#import "InfoCartCell.h"
#import "AddressCell.h"
#import "NewAddressCell.h"
#import "TotalCell.h"
#import "WalletCell.h"
#import "NewPayViewController.h"
#import "OrderViewController.h"
#import "CouponCell.h"
#import "CouponViewController.h"

@interface InfoViewController ()
{
    UILabel * allPriceLabel;
    NSArray *addressArray;
    NSArray *cartInfoArray;
    NSString *paybool;
    NSDictionary *addressDic;
    //运费数组
    NSArray *shippingmethodarr;
    NSDictionary *shippingdic;
    TotalCell *totalcell;
    BOOL shippingbool;
    BOOL hiddenshipping;
    //是否刷新地址
    BOOL isUpdataAddress;
    //优惠券相关
    NSString *coupon;
    //优惠券列表数组
    NSArray *couponarr;
    CouponCell *couponcell;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Order Info";
    [MobClick event:@"cartinfo"];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT-50) style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = nav_Color;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //赋予初值
    addressArray = [NSArray new];
    coupon = @"0";
    couponarr = [NSArray array];
    [self.view addSubview:self.tableView];
    [self setFootView];
    shippingbool = YES;
    hiddenshipping = YES;
    isUpdataAddress = YES;
//    paybool = 0;
    cartInfoArray = [self.infoDic objectForKey:@"cartInfo"];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)setFootView
{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, CURRENT_CONTENT_HEIGHT - 50, CURRENT_CONTENT_WIDTH, 50);
    //    view.backgroundColor = [UIColor blackColor];
    UILabel * titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(20, 10, 150, 30);
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.text = @"Total:";
    titleLabel.font = [UIFont systemFontOfSize:13];
    [view addSubview:titleLabel];
    
    allPriceLabel = [[UILabel alloc]init];
    allPriceLabel.frame = CGRectMake(60, 10, 150, 30);
    allPriceLabel.textColor = Btn_Color;
    allPriceLabel.text = [NSString stringWithFormat:@"%@",[self.infoDic objectForKey:@"cartTotal"]];
    allPriceLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:allPriceLabel];
    
    UIButton *checkoutBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    checkoutBtn.frame = CGRectMake(CURRENT_CONTENT_WIDTH - 110, 10, 100, 30);
    checkoutBtn.backgroundColor = Btn_Color;
    [checkoutBtn setTitle:@"Checkout" forState:UIControlStateNormal];
    [checkoutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    checkoutBtn.layer.cornerRadius = 3.0;
    checkoutBtn.layer.borderColor = [[UIColor whiteColor]CGColor];
    checkoutBtn.layer.borderWidth = 1.0;
    [checkoutBtn addTarget:self action:@selector(goPay) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:checkoutBtn];
    [self.view addSubview:view];
}

- (void)request1
{
    [self showLoadingWithMaskType];
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    [LORequestManger POST:getUserAddress_URL params:dic URl:nil success:^(id response) {
        NSLog(@"%@",response);
        NSString *status =[response objectForKey:@"status"];
        
        if ([status isEqualToString:@"OK"]) {
            addressArray = [response objectForKey:@"data"];
            addressDic = addressArray[0];
            NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
            [dic setObject:[addressArray[0] objectForKey:@"address_book_id"] forKey:@"address_book_id"];
            [LORequestManger POST:shippingPrice_url params:dic URl:nil success:^(id response) {
                NSLog(@"%@",response);
                if ([[response objectForKey:@"status"]isEqualToString:@"OK"]) {
                    for(id tmpView in [totalcell.shippingScr subviews]) {
                        [tmpView removeFromSuperview];
                    }
                    shippingmethodarr = [response objectForKey:@"data"];
                    for (int i = 0; i<shippingmethodarr.count; i++) {
                        NSDictionary *dic = shippingmethodarr[i];
                        UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(20, i*25, 200, 25)];
                        titlelb.textColor = [UIColor grayColor];
                        titlelb.font = [UIFont systemFontOfSize:12];
                        titlelb.text = [dic objectForKey:@"shippingDisplay"];
                        [totalcell.shippingScr addSubview:titlelb];
                        
                        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(100, i*25, [UIScreen mainScreen].bounds.size.width - 120, 25)];
                        price.textColor = [UIColor grayColor];
                        price.textAlignment = NSTextAlignmentRight;
                        price.font = [UIFont systemFontOfSize:12];
                        price.text = [dic objectForKey:@"shippingCost"];
                        [totalcell.shippingScr addSubview:price];
                        
                        //line
                        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*25+25, [UIScreen mainScreen].bounds.size.width, 0.5)];
                        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
                        [totalcell.shippingScr addSubview:line];
                        
                        UIButton *shippingBt = [UIButton buttonWithType:UIButtonTypeCustom];
                        shippingBt.frame = CGRectMake(0, 25*i, [UIScreen mainScreen].bounds.size.width, 25);
                        shippingBt.tag = i;
                        [shippingBt addTarget:self action:@selector(selectShipping:) forControlEvents:UIControlEventTouchUpInside];
                        [totalcell.shippingScr addSubview:shippingBt];
                        totalcell.shippingScr.contentSize = CGSizeMake(0, 20*shippingmethodarr.count);
                        
                        shippingdic = shippingmethodarr[0];
                        //切换为正确名字
                        totalcell.shippingLb.text = [shippingdic objectForKey:@"shippingDisplay"];
                        totalcell.addressLabel.text = [shippingdic objectForKey:@"shippingCost"];
                        allPriceLabel.text = [shippingdic objectForKey:@"total"];
                    }
                    [self dismiss];
                }else {
                    [self dismiss];
                    shippingmethodarr = [NSArray new];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self dismiss];
                shippingmethodarr = [NSArray new];
            }];

            [self.tableView reloadData];
        }else{
            [self dismiss];
            NSLog(@"%@",response);
            [self.tableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dismiss];
        [self request1];
    }];

    //优惠券接口
    NSMutableDictionary *dic2 = [[Singleton sharedInstance] zenidDic];
    [LORequestManger POST:coupon_url params:dic2 URl:nil success:^(id response) {
        NSString *status =[response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            NSDictionary *data = [response objectForKey:@"data"];
            couponarr = [data objectForKey:@"couponList"];
        }else{
            
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}
#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return cartInfoArray.count;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (addressArray.count == 0) {
            static NSString     *str = @"address";
            AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil) {
                cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            }
            
            return cell;

        }else{
        static NSString     *str = @"cell1";
        NewAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"NewAddressCell" owner:self options:nil];
            cell = nib[0];
        }
        
        [cell setDic:addressDic];
            if ([paybool isEqualToString:@"1"]) {
                cell.accessoryType = UITableViewCellAccessoryNone;
            }else{
                cell.selectionStyle = UITableViewCellSelectionStyleNone;

            }
        return cell;
        }
    }else if (indexPath.section == 1){
        static NSString     *str = @"cell";
        InfoCartCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[InfoCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        [cell setData:cartInfoArray[indexPath.row]];
        return cell;
    }else if(indexPath.section == 3){
        static NSString     *str = @"cell2";
        totalcell = [tableView dequeueReusableCellWithIdentifier:str];
        if (totalcell == nil) {
            totalcell = [[TotalCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        [totalcell.changeShippingPriceBt addTarget:self action:@selector(changeShippingPriceBtMethod) forControlEvents:UIControlEventTouchUpInside];
        [totalcell setData:self.infoDic];
        return totalcell;
    }else{
        static NSString *str = @"cell3";
        couponcell = [tableView dequeueReusableCellWithIdentifier:str];
        if (couponcell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CouponCell" owner:self options:nil];
            couponcell = nib[0];
        }
        couponcell.couponlb.text = [NSString stringWithFormat:@"%lu", (unsigned long)couponarr.count];
        return couponcell;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NewAddressCell *cell = (NewAddressCell *)[tableView cellForRowAtIndexPath:indexPath];
        [MobClick event:@"changeaddress"];
        //订单生成后现在是暂时无法修改地址的。先控制
        if ([paybool isEqualToString:@"1"]) {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else {
            NSLog(@"添加新地址");
            isUpdataAddress = YES;
            NewAddressViewController *newVC = [[NewAddressViewController alloc]init];
            if (addressArray.count == 0) {

            }else{
                newVC.addressDic = addressArray[0];
                newVC.isEdit = YES;
            }
            [self.navigationController pushViewController:newVC animated:YES];
        }
    }else if (indexPath.section == 2) {
        if ([paybool isEqualToString:@"1"]) {
            
        }else{
            if (couponarr.count == 0 || addressArray.count == 0) {
                
            }else {
                isUpdataAddress = NO;
                CouponViewController *couponVc = [[CouponViewController alloc] init];
                couponVc.couponArr = couponarr;
                [couponVc returnText:^(NSString *boolstr) {
                    coupon = boolstr;
                    [self getNewAllOrderPrice];
                }];
                [couponVc returnPrice:^(NSString *boolstr) {
                    couponcell.couponPrice.text = boolstr;
                }];
                [self.navigationController pushViewController:couponVc animated:YES];
            }
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        return 130*iphone_HIGHT;
    }else if(indexPath.section == 0){
        
        if (addressArray.count == 0) {
            return 50;
        }
        return 77*iphone_HIGHT;
    }else if(indexPath.section == 3){
        
        return 120*iphone_HIGHT;
    }
    return 40*iphone_HIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 30;
    }
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel * orderNumLabel = [[UILabel alloc]init];
    orderNumLabel.text = @"Product List";
    orderNumLabel.numberOfLines = 0;
    orderNumLabel.frame = CGRectMake(10, 5, CURRENT_DEVICE_WIDTH - 20, 20);
    orderNumLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:orderNumLabel];
    
    if (section ==1) {
        return view;
    }
    return nil;
}

- (void)leftBtn
{
    if ([paybool isEqualToString:@"1"]) {
        OrderViewController *orderVC = [[OrderViewController alloc]init];
        [self.navigationController pushViewController:orderVC animated:NO];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//获取运费方式
- (void)changeShippingPriceBtMethod
{
    [MobClick event:@"changshipping"];
    if (addressArray.count != 0) {
        if (hiddenshipping) {
            hiddenshipping = !hiddenshipping;
            [self showLoadingWithMaskType];
            NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
            [dic setObject:[addressArray[0] objectForKey:@"address_book_id"] forKey:@"address_book_id"];
            
            [LORequestManger POST:shippingPrice_url params:dic URl:nil success:^(id response) {
                NSLog(@"%@",response);
                if ([[response objectForKey:@"status"]isEqualToString:@"OK"]) {
                    for(id tmpView in [totalcell.shippingScr subviews]) {
                        [tmpView removeFromSuperview];
                    }
                    totalcell.shippingScr.hidden = NO;
                    shippingmethodarr = [response objectForKey:@"data"];
                    for (int i = 0; i<shippingmethodarr.count; i++) {
                        NSDictionary *dic = shippingmethodarr[i];
                        UILabel *titlelb = [[UILabel alloc] initWithFrame:CGRectMake(20, i*25, 200, 25)];
                        titlelb.textColor = [UIColor grayColor];
                        titlelb.font = [UIFont systemFontOfSize:12];
                        titlelb.text = [dic objectForKey:@"shippingDisplay"];
                        [totalcell.shippingScr addSubview:titlelb];
                        
                        UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(100, i*25, [UIScreen mainScreen].bounds.size.width - 120, 25)];
                        price.textColor = [UIColor grayColor];
                        price.textAlignment = NSTextAlignmentRight;
                        price.font = [UIFont systemFontOfSize:12];
                        price.text = [dic objectForKey:@"shippingCost"];
                        [totalcell.shippingScr addSubview:price];
                        
                        //line
                        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, i*25+25, [UIScreen mainScreen].bounds.size.width, 0.5)];
                        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
                        [totalcell.shippingScr addSubview:line];
                        
                        UIButton *shippingBt = [UIButton buttonWithType:UIButtonTypeCustom];
                        shippingBt.frame = CGRectMake(0, 25*i, [UIScreen mainScreen].bounds.size.width, 25);
                        shippingBt.tag = i;
                        [shippingBt addTarget:self action:@selector(selectShipping:) forControlEvents:UIControlEventTouchUpInside];
                        [totalcell.shippingScr addSubview:shippingBt];
                        totalcell.shippingScr.contentSize = CGSizeMake(0, 20*shippingmethodarr.count);
                    }
                    [self dismiss];
                }else {
                    shippingmethodarr = [NSArray new];
                    [self dismiss];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                shippingmethodarr = [NSArray new];
                [self dismiss];
                [self changeShippingPriceBtMethod];
            }];
            [totalcell changeRightbtstatu:YES];
        }else {
            for(id tmpView in [totalcell.shippingScr subviews]) {
                [tmpView removeFromSuperview];
            }
            hiddenshipping = !hiddenshipping;
            [totalcell changeRightbtstatu:NO];
            totalcell.shippingScr.hidden = YES;
        }

    }else {
        [SVProgressHUD showErrorWithStatus:@"Please fill in the address"];
    }
}

//选择运费
- (void)selectShipping:(UIButton *)sender
{
    [totalcell changeRightbtstatu:NO];
    totalcell.shippingScr.hidden = YES;
    //拿到选定的
    shippingdic = shippingmethodarr[sender.tag];
    shippingbool = NO;
    //切换为正确名字
    totalcell.shippingLb.text = [shippingdic objectForKey:@"shippingDisplay"];
    totalcell.addressLabel.text = [shippingdic objectForKey:@"shippingCost"];
    allPriceLabel.text = [shippingdic objectForKey:@"total"];
    [self getNewAllOrderPrice];
}

//获取最新价格
- (void)getNewAllOrderPrice
{
    //[dic setObject:[shippingdic objectForKey:@"shippingVal"] forKey:@"shippingID"];
    NSMutableDictionary *dic2 = [[Singleton sharedInstance] zenidDic];
    if ([coupon isEqualToString:@"0"]) {
        
    }else {
        [dic2 setValue:coupon forKey:@"couponID"];
    }
    [dic2 setObject:[shippingdic objectForKey:@"shippingVal"] forKey:@"shipID"];
    [LORequestManger POST:getallOrderTotal params:dic2 URl:nil success:^(id response) {
        NSString *status =[response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            NSDictionary *data = [response objectForKey:@"data"];
            allPriceLabel.text = [data objectForKey:@"total"];
        }else{
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)goPay
{
    if (addressArray.count != 0) {
        if (shippingbool) {
            if ([paybool isEqualToString:@"1"]) {
                //再次付款  不再需要网络请求
                NSLog(@"%@   %@", _payurl, _orderid);
                NewPayViewController *payVC =   [[NewPayViewController alloc]init];
                payVC.delegate =self;
                payVC.totalStr = allPriceLabel.text;
                payVC.orderIdStr = self.orderid;
                payVC.payUrl = self.payurl;
                payVC.addressDic = addressArray[0];
                [self.navigationController pushViewController: payVC animated:YES];
            }else {
                NSLog(@"去付款");
                [self showLoadingWithMaskType];
                NSMutableDictionary * requestDic = [NSMutableDictionary dictionaryWithCapacity:1];
                if ([coupon isEqualToString:@"0"]) {
                    
                }else {
                    [requestDic setValue:coupon forKey:@"cc_id"];
                }
                [requestDic setValue:MyZenID forKey:@"zenid"];
                [requestDic setValue:[addressArray[0] objectForKey:@"address_book_id"] forKey:@"address_book_id"];
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                NSLog(@"%@",[infoDictionary objectForKey:@"CFBundleShortVersionString"]);
                [requestDic setValue:[infoDictionary objectForKey:@"CFBundleShortVersionString"] forKey:@"appver"];
                [requestDic setValue:[self getPhoneModel] forKey:@"phonetype"];
                [requestDic setValue:[[UIDevice currentDevice] systemVersion] forKey:@"iosver"];
                NSString *shippingID = [[shippingmethodarr objectAtIndex:0] objectForKey:@"shippingVal"];
                [requestDic setObject:shippingID forKey:@"shippingID"];
                [LORequestManger POST:createOrder_URL params:requestDic URl:nil success:^(id response) {
                    NSLog(@"%@",response);
                    NSString *status =[response objectForKey:@"status"];
                    
                    if ([status isEqualToString:@"OK"])  {
                        [self dismiss];
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"getcartNumber" object:nil];
                        NSDictionary *dic = [response objectForKey:@"data"];
                        NewPayViewController *payVC = [[NewPayViewController alloc]init];
                        payVC.delegate =self;
                        
                        payVC.totalStr = allPriceLabel.text;
                        payVC.orderIdStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderID"]];
                        payVC.payUrl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"payUrl"]];
                        self.orderid =[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderID"]];
                        self.payurl =[NSString stringWithFormat:@"%@",[dic objectForKey:@"payUrl"]];
                        payVC.addressDic = addressArray[0];
                        [self.navigationController pushViewController: payVC animated:YES];
                    }else{
                        [self dismissError:@"Please Add the address"];
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"%@",error);
                    [self dismiss];
                }];
            }
            
        }else {
            [self showLoadingWithMaskType];
            shippingbool = YES;
            NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
            [dic setObject:[shippingdic objectForKey:@"shippingVal"] forKey:@"shippingID"];
            [dic setObject:[addressArray[0] objectForKey:@"address_book_id"] forKey:@"address_book_id"];
            if ([coupon isEqualToString:@"0"]) {
                
            }else {
                [dic setValue:coupon forKey:@"cc_id"];
            }
            //新接口选择
            [LORequestManger POST:selectshippingMethod_url params:dic URl:nil success:^(id response) {
                
                NSLog(@"%@",response);
                NSDictionary *dic = [response objectForKey:@"data"];
                NSString *status =[response objectForKey:@"status"];
                
                if ([status isEqualToString:@"OK"]) {
                    NewPayViewController *payVC = [[NewPayViewController alloc]init];
                    payVC.delegate =self;
                    payVC.totalStr = allPriceLabel.text;
                    payVC.orderIdStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"orderID"]];
                    payVC.payUrl = [NSString stringWithFormat:@"%@",[dic objectForKey:@"payUrl"]];
                    self.orderid =[NSString stringWithFormat:@"%@",[dic objectForKey:@"orderID"]];
                    self.payurl =[NSString stringWithFormat:@"%@",[dic objectForKey:@"payUrl"]];
                    payVC.addressDic = addressArray[0];
                    [self.navigationController pushViewController: payVC animated:YES];
                }
                [self dismiss];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self dismiss];
            }];
        }

    }else {
        [SVProgressHUD showErrorWithStatus:@"Please fill in the address"];
    }
}

-(void)backVC:(NSString *)panduan
{
    paybool = panduan;
}

- (NSString *)getPhoneModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSArray *modelArray = @[
                            
                            @"i386", @"x86_64",
                            
                            @"iPhone1,1",
                            @"iPhone1,2",
                            @"iPhone2,1",
                            @"iPhone3,1",
                            @"iPhone3,2",
                            @"iPhone3,3",
                            @"iPhone4,1",
                            @"iPhone5,1",
                            @"iPhone5,2",
                            @"iPhone5,3",
                            @"iPhone5,4",
                            @"iPhone6,1",
                            @"iPhone6,2",
                            @"iPhone7,1",
                            @"iPhone7,2",
                            @"iPhone8,1",
                            @"iPhone8,2",
                            
                            @"iPod1,1",
                            @"iPod2,1",
                            @"iPod3,1",
                            @"iPod4,1",
                            @"iPod5,1",
                            
                            @"iPad1,1",
                            @"iPad2,1",
                            @"iPad2,2",
                            @"iPad2,3",
                            @"iPad2,4",
                            @"iPad3,1",
                            @"iPad3,2",
                            @"iPad3,3",
                            @"iPad3,4",
                            @"iPad3,5",
                            @"iPad3,6",
                            
                            @"iPad2,5",
                            @"iPad2,6",
                            @"iPad2,7",
                            ];
    NSArray *modelNameArray = @[
                                
                                @"iPhone Simulator", @"iPhone Simulator",
                                
                                @"iPhone 2G",
                                @"iPhone 3G",
                                @"iPhone 3GS",
                                @"iPhone 4(GSM)",
                                @"iPhone 4(GSM Rev A)",
                                @"iPhone 4(CDMA)",
                                @"iPhone 4S",
                                @"iPhone 5(GSM)",
                                @"iPhone 5(GSM+CDMA)",
                                @"iPhone 5c(GSM)",
                                @"iPhone 5c(Global)",
                                @"iphone 5s(GSM)",
                                @"iphone 5s(Global)",
                                @"iPhone 6 Plus",
                                @"iPhone 6",
                                @"iPhone 6s",
                                @"iPhone 6s Plus",
                                
                                @"iPod Touch 1G",
                                @"iPod Touch 2G",
                                @"iPod Touch 3G",
                                @"iPod Touch 4G",
                                @"iPod Touch 5G",
                                
                                @"iPad",
                                @"iPad 2(WiFi)",
                                @"iPad 2(GSM)",
                                @"iPad 2(CDMA)",
                                @"iPad 2(WiFi + New Chip)",
                                @"iPad 3(WiFi)",
                                @"iPad 3(GSM+CDMA)",
                                @"iPad 3(GSM)",
                                @"iPad 4(WiFi)",
                                @"iPad 4(GSM)",
                                @"iPad 4(GSM+CDMA)",
                                
                                @"iPad mini (WiFi)",
                                @"iPad mini (GSM)",
                                @"ipad mini (GSM+CDMA)"
                                ];
    NSInteger modelIndex = - 1;
    NSString *modelNameString = nil;
    modelIndex = [modelArray indexOfObject:deviceString];
    if (modelIndex >= 0 && modelIndex < [modelNameArray count]) {
        modelNameString = [modelNameArray objectAtIndex:modelIndex];
    }
    
    NSLog(@"----设备类型---%@",modelNameString);
    return modelNameString;
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//
    if (isUpdataAddress) {
        [self request1];
    }
}

-(void)addressDic:(NSDictionary *)dic
{
    addressDic = dic;
    [self.tableView reloadData];
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
