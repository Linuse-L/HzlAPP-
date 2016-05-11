//
//  HomeVC.m
//  NewApp
//
//  Created by L on 15/9/17.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "HomeVC.h"
#define SELECTED_VIEW_CONTROLLER_TAG 10202

@interface HomeVC ()
{
    NSArray *array;
    NSArray *bannerArray;
    NSArray *classListArray;
    
    //
//    UIImageView *cartNumberImage;
//    UILabel *cartNumberLb;
    UISearchBar* m_searchBar;
}
@property (nonatomic, strong) UITableView *tabelView;
@end

@implementation HomeVC

- (void)rightBtn
{
    [MobClick event:@"hometopright"];
    NSLog(@"购物车");
    CartViewController *cartVC = [[CartViewController alloc]init];
    [self.navigationController pushViewController:cartVC animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"HOME";
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setupLeftMenuButton];
    [self setSearchBar];
    self.tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT - 104 - 49) style:UITableViewStyleGrouped];
    self.tabelView.separatorStyle =UITableViewCellSeparatorStyleNone;

    self.tabelView.backgroundColor = RGB_Color(241, 241, 241);
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.view addSubview:self.tabelView];
//    [self setRightBar];
    //    这里来做定位服务
    [[PositioningClass shared] getLocation:self];
    [self moveCart];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(LeftPush:) name:@"leftPush" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushCategory:) name:@"pushCategory" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getcartNumber) name:@"getcartNumber" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deeplinkproduct:) name:@"deeplinkproduct" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(deeplinkcategory:) name:@"deeplinkcategory" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Pushserver:) name:@"Pushserver" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Pushser) name:@"Pushserver2" object:nil];
    // Do any additional setup after loading the view.
    [self getcartNumber];
}
- (void)setLeft
{
    
}

#pragma mark - 设置上部搜索栏
- (void)setSearchBar
{
    m_searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, 320, 40)];
    m_searchBar.delegate = self;
    m_searchBar.barStyle = UIBarStyleDefault;
    m_searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    m_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    m_searchBar.placeholder = @"SEARCH:CLASSIFY BRAND COMMODITY";
    m_searchBar.keyboardType =  UIKeyboardTypeDefault;

    UITextField *searchTextField = nil;
    // 经测试, 需要设置barTintColor后, 才能拿到UISearchBarTextField对象
    m_searchBar.barTintColor = [UIColor whiteColor];
    searchTextField = [[[m_searchBar.subviews firstObject] subviews] lastObject];
    
    searchTextField.backgroundColor = RGB_Color(245, 245, 245);
    searchTextField.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:m_searchBar];

}



- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"leftPush" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushCategory" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getcartNumber" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"deeplinkproduct" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"deeplinkcategory" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"getcartNumber" object:nil];
}

//deal with the app link
- (void)deeplinkproduct:(NSNotification *)sender
{
    //处理产品
    NSString *pid = sender.object;
    DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
    detailsVC.positionID = pid;
    [self.navigationController pushViewController:detailsVC animated:YES];
}

- (void)deeplinkcategory:(NSNotification *)sender
{
    //处理分类
    CategoryViewController *categoryVC = [[CategoryViewController alloc]init];
    [self.navigationController pushViewController:categoryVC animated:YES];
}

#pragma mark - Locationdelegate
//定位代理
#pragma mark - Delegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *loc = [locations firstObject];
    [UMessage setLocation:loc];
    //发送定位消息
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *locationarray, NSError *error)
     {
         static dispatch_once_t once;
         dispatch_once(&once,^{
             if (locationarray.count > 0)
             {
                 CLPlacemark *placemark = [locationarray objectAtIndex:0];
                 //获取城市
                 NSString *city = placemark.locality;
                 if (!city) {
                     city = placemark.administrativeArea;
                 }
                 NSString *isoid = placemark.ISOcountryCode;
                 if ([isoid isEqualToString:@"US"]) {
                     NSMutableDictionary *dic = [[Singleton sharedInstance] zenidDic];
                     [dic setValue:@"USD" forKey:@"currency"];
                     [LORequestManger POST:setCurrency_url params:dic URl:nil success:^(id response) {
                         NSString *status =[response objectForKey:@"status"];
                         if ([status isEqualToString:@"OK"]) {
                             [self.navigationController popToRootViewControllerAnimated:YES];
                         }
                         
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         
                     }];
                 }else if ([isoid isEqualToString:@"UK"]) {
                     NSMutableDictionary *dic = [[Singleton sharedInstance] zenidDic];
                     [dic setValue:@"GBP" forKey:@"currency"];
                     [LORequestManger POST:setCurrency_url params:dic URl:nil success:^(id response) {
                         NSString *status =[response objectForKey:@"status"];
                         if ([status isEqualToString:@"OK"]) {
                             [self.navigationController popToRootViewControllerAnimated:YES];
                         }
                         
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         
                     }];
                 }else if ([isoid isEqualToString:@"AU"]) {
                     NSMutableDictionary *dic = [[Singleton sharedInstance] zenidDic];
                     [dic setValue:@"AUD" forKey:@"currency"];
                     [LORequestManger POST:setCurrency_url params:dic URl:nil success:^(id response) {
                         NSString *status =[response objectForKey:@"status"];
                         if ([status isEqualToString:@"OK"]) {
                             [self.navigationController popToRootViewControllerAnimated:YES];
                         }
                         
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         
                     }];
                 }else if ([isoid isEqualToString:@"CA"]) {
                     NSMutableDictionary *dic = [[Singleton sharedInstance] zenidDic];
                     [dic setValue:@"CAD" forKey:@"currency"];
                     [LORequestManger POST:setCurrency_url params:dic URl:nil success:^(id response) {
                         NSString *status =[response objectForKey:@"status"];
                         if ([status isEqualToString:@"OK"]) {
                             [self.navigationController popToRootViewControllerAnimated:YES];
                         }
                         
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         
                     }];
                 }else if ([isoid isEqualToString:@"DE"] && [isoid isEqualToString:@"FR"] && [isoid isEqualToString:@"ES"] && [isoid isEqualToString:@"IT"]&& [isoid isEqualToString:@"BE"]&& [isoid isEqualToString:@"IE"]&& [isoid isEqualToString:@"GR"]&& [isoid isEqualToString:@"AI"]&& [isoid isEqualToString:@"FI"] && [isoid isEqualToString:@"LU"]) {
                     NSMutableDictionary *dic = [[Singleton sharedInstance] zenidDic];
                     [dic setValue:@"EUR" forKey:@"currency"];
                     [LORequestManger POST:setCurrency_url params:dic URl:nil success:^(id response) {
                         NSString *status =[response objectForKey:@"status"];
                         if ([status isEqualToString:@"OK"]) {
                             [self.navigationController popToRootViewControllerAnimated:YES];
                         }
                         
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                         
                     }];
                 }
                 
                 NSLog(@"name:%@\n country:%@\n postalCode:%@\n ISOcountryCode:%@\n ocean:%@\n inlandWater:%@\n locality:%@\n subLocality:%@ \n administrativeArea:%@\n subAdministrativeArea:%@\n thoroughfare:%@\n subThoroughfare:%@\n",
                       placemark.name,
                       placemark.country,
                       placemark.postalCode,
                       placemark.ISOcountryCode,
                       placemark.ocean,
                       placemark.inlandWater,
                       placemark.administrativeArea,
                       placemark.subAdministrativeArea,
                       placemark.locality,
                       placemark.subLocality,
                       placemark.thoroughfare,
                       placemark.subThoroughfare);
             }
             else if (error == nil && [locationarray count] == 0)
             {
                 NSLog(@"No results were returned.");
             }
             else if (error != nil)
             {
                 NSLog(@"An error occurred = %@", error);
             }
         });
     }];
    //若只需要定位一次服务则需要取消定位
    [manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([error code]==kCLErrorDenied) {
        NSLog(@"访问被拒绝");
        //        [self addrequset];
        //用户没有给予使用定位的权限
        //        UIAlertView *locationAlert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Please open the location services" delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        //        [locationAlert show];
    }
    if ([error code]==kCLErrorLocationUnknown) {
        NSLog(@"无法获取位置信息");
        
        //wife 数据 基站服务 GPS瘫痪
    }
    static dispatch_once_t once;
    dispatch_once(&once,^{
        
    });
}

- (void)getcartNumber
{
    //来请求购物车
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:MyZenID forKey:@"zenid"];
    [LORequestManger POST:queryAppCart_URL params:dic URl:nil success:^(id response) {
        NSLog(@"%@",response);
        NSString *status = [response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            NSDictionary *dic = [response objectForKey:@"data"];
            numberCartLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"cartTotalNum"]];
            cartNumberLb.hidden = NO;
            cartNumberImage.hidden = NO;
        }else{
            cartNumberLb.hidden = YES;
            cartNumberImage.hidden = YES;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        cartNumberLb.hidden = YES;
        cartNumberImage.hidden = YES;
        [self getcartNumber];
    }];
}

- (void)request
{
    [self showLoadingWithMaskType];
    [LORequestManger GET:Home_Url success:^(id response) {
        [self dismiss];
        NSLog(@"%@",response);
        NSDictionary *dic = [response objectForKey:@"data"];
        bannerArray = [[[dic objectForKey:@"appBanner"] objectForKey:@"data"] objectForKey:@"AppBanner"];
        classListArray = [dic objectForKey:@"homeClassList"];
        [AppDelegate getAppDelegate].email = [NSString stringWithFormat:@"%@",[dic objectForKey:@"appEmail"]];
        [self.tabelView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
        //错误重新请求
        [self request];
    }];
}
- (void)setRightBar
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
//    view.backgroundColor = [UIColor redColor];
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 0, 20, 20);
    [backButton setBackgroundImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"cart"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:backButton];
    
    cartNumberImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, -2, 15, 15)];
    cartNumberImage.image = [UIImage imageNamed:@"dian"];
    cartNumberImage.hidden = YES;
    [view addSubview:cartNumberImage];
    
    cartNumberLb = [[UILabel alloc] initWithFrame:CGRectMake(15, -2, 15, 15)];
    cartNumberLb.font = [UIFont systemFontOfSize:8];
    cartNumberLb.textAlignment = NSTextAlignmentCenter;
    cartNumberLb.text = @"1";
    cartNumberLb.textColor = [UIColor whiteColor];
    cartNumberLb.hidden = YES;
    [view addSubview:cartNumberLb];
    
    UIButton *pushcart = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushcart addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    pushcart.frame = view.frame;
    [view addSubview:pushcart];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = barBtn;
}


#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return classListArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

        static NSString *str = @"cell1";
        HomeCategortyCell  *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (cell == nil) {
            cell = [[HomeCategortyCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    NSDictionary *dic =classListArray[indexPath.section];
    [cell allImageWith:dic];
        return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

- (void)btn
{
    DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
    [self.navigationController pushViewController:detailsVC animated:YES];
}
-(void)setupLeftMenuButton{
    [MobClick event:@"hometopleft"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-10, 0, 50, 50)];
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 30, 30);
//    backButton.backgroundColor = [UIColor blueColor];
//    view.backgroundColor = [UIColor blackColor];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"leftBtn"] forState:UIControlStateNormal];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"leftBtn"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(leftDrawerButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:backButton];
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = RECT(-10, 10, 15, 15);
    imageView.image =[UIImage imageNamed:@"leftBtn"];
    [backButton addSubview:imageView];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = barBtn;
}
#pragma mark - Button Handlers
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)LeftPush:(id)sender
{
    OrderViewController *orderVC = [[OrderViewController alloc]init];
    [self.navigationController pushViewController:orderVC animated:YES];
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        
    }];
   
}

- (void)pushCategory:(NSNotification *)sender
{
    NSLog(@"跳转产品列表");
    NSDictionary *allDic = sender.object;
    NSLog(@"%@",allDic);
    [[AppDelegate getAppDelegate].tabbarVC removeTabbar];
    NewProductViewController *newProductVC = [[NewProductViewController alloc]init];
    newProductVC.linkUrlStr = [allDic objectForKey:@"appProductsLink"];
    newProductVC.classid = [allDic objectForKey:@"classid"];
    newProductVC.title = [NSString stringWithFormat:@"%@",[allDic objectForKey:@"name"]];
    [self.navigationController pushViewController:newProductVC animated:YES];
}
//滑动代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [m_searchBar resignFirstResponder];
}
//
- (void)Pushserver:(NSNotification *)sender
{
    NSDictionary *dic = sender.object;
    ReviewVC *reVC = [[ReviewVC alloc] init];
    reVC.positionID = [[dic objectForKey:@"aps"]objectForKey:@"val"];
    [self.navigationController pushViewController:reVC animated:YES];
}

- (void)Pushser
{
    OrderViewController *reVC = [[OrderViewController alloc] init];
    [self.navigationController pushViewController:reVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 悬浮购物车
- (void)moveCart
{
    //悬浮购物车
    moveView = [[UIView alloc] initWithFrame:CGRectMake(270, 350, 50, 25)];
    moveView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:moveView];
    
    UIImageView *imag = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    imag.backgroundColor = [UIColor blackColor];
    imag.alpha = 0.5;
    [moveView addSubview:imag];
    
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xuanfu)];
    [moveView addGestureRecognizer:gest];
    
    cartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cartBtn addTarget:self action:@selector(xuanfu) forControlEvents:UIControlEventTouchUpInside];
    cartBtn.tag = 2;
    cartBtn.frame = CGRectMake(4, 6.5, 13, 12);
    [cartBtn setImage:[UIImage imageNamed:@"cart"] forState:UIControlStateNormal];
    [moveView addSubview:cartBtn];
    
    //红块儿
    UIImageView *redImg = [[UIImageView alloc] initWithFrame:CGRectMake(23, 5.5, 16, 14)];
    redImg.backgroundColor = [UIColor blackColor];
    [moveView addSubview:redImg];
    
    numberCartLabel = [[UILabel alloc] initWithFrame:CGRectMake(19, 0, 24, 25)];
    numberCartLabel.textColor = [UIColor whiteColor];
    numberCartLabel.font = [UIFont boldSystemFontOfSize:9];
    numberCartLabel.textAlignment = NSTextAlignmentCenter;
    numberCartLabel.text = @"0";
    [moveView addSubview:numberCartLabel];
    
}
- (void)xuanfu
{
    [MobClick event:@"hometopright"];
    NSLog(@"购物车");
    [[AppDelegate getAppDelegate].tabbarVC removeTabbar];
    CartViewController *cartVC = [[CartViewController alloc]init];
    cartVC.tobbar = @"1";
    [self.navigationController pushViewController:cartVC animated:YES];
}
//手指按下开始触摸
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获得触摸在按钮的父视图中的坐标
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    xDistance =  self.view.center.x - currentPoint.x;
    yDistance = self.view.center.y - currentPoint.y;
}

//手指按住移动过程
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    //获得触摸在按钮的父视图中的坐标
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    
    //移动按钮到当前触摸位置
    CGPoint newCenter = CGPointMake(currentPoint.x, currentPoint.y);
    moveView.frame = CGRectMake(newCenter.x, newCenter.y, moveView.bounds.size.width, moveView.bounds.size.height);
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (moveView.frame.origin.y<480) {
        if (moveView.frame.origin.x<160) {
            [UIView animateWithDuration:0.3 animations:^{
                moveView.frame = CGRectMake(10, moveView.frame.origin.y, moveView.bounds.size.width, moveView.bounds.size.height);
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                moveView.frame = CGRectMake(CURRENT_DEVICE_WIDTH-10-moveView.bounds.size.width, moveView.frame.origin.y, moveView.bounds.size.width, moveView.bounds.size.height);
            }];
        }
    }else{
        if (moveView.frame.origin.x<160) {
            [UIView animateWithDuration:0.3 animations:^{
                moveView.frame = CGRectMake(10, 300, moveView.bounds.size.width, moveView.bounds.size.height);
            }];
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                moveView.frame = CGRectMake(CURRENT_DEVICE_WIDTH-10-moveView.bounds.size.width, 300, moveView.bounds.size.width, moveView.bounds.size.height);
            }];
        }
    }
}
//搜索代理
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [MobClick event:@"homesearch"];
    [FBSDKAppEvents logEvent:@"homesearch"];
    if (![self isBlankString:searchBar.text]) {
        [searchBar resignFirstResponder];
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        //        NSString *text = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
        [dic setObject:searchBar.text forKey:@"searchkeyword"];
        [dic setObject:@"0" forKey:@"page"];
        [LORequestManger POST:getSearchResult_URL params:dic URl:nil success:^(id response) {
            
            NSString *status = [response objectForKey:@"status"];
            if ([status isEqualToString:@"OK"]) {
                [SVProgressHUD dismiss];
                NSLog(@"%@",response);
                NSArray *array1 = [response objectForKey:@"data"];
                ProductViewController *productVC = [[ProductViewController alloc]init];
                [[AppDelegate getAppDelegate].tabbarVC removeTabbar];

                productVC.searchArray = array1;
                productVC.isSearch = YES;
                
                [self.navigationController pushViewController:productVC animated:YES];
            }else{
                NSString *data = [NSString stringWithFormat:@"%@",[response objectForKey:@"data"]];
                [SVProgressHUD dismissWithError:data];
                NSLog(@"%@",response);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }else {
        [SVProgressHUD showErrorWithStatus:@"Please enter the content"];
    }
}
- (BOOL)isBlankString:(NSString *)string{
    
    
    
    if (string == nil) {
        
        return YES;
        
    }
    
    
    
    if (string == NULL) {
        
        return YES;
        
    }
    
    
    
    if ([string isKindOfClass:[NSNull class]]) {
        
        return YES;
        
    }
    
    
    
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
        
        return YES;
        
    }
    
    return NO;
    
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
