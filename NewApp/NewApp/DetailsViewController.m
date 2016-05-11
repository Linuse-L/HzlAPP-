//
//  DetailsViewController.m
//  NewApp
//
//  Created by L on 15/9/17.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "DetailsViewController.h"
#import "DetailsImageCell.h"
#import "ReviewVC.h"
#import "CartViewController.h"
#import "SelectView.h"
#import "NewDetailSImageCell.h"
#import "NewReviewCell.h"
@interface DetailsViewController ()<GiftTalkSheetDelegate>
{
    NSArray *imageArray;
    SelectView *selectView ;
    NSDictionary *dataDic;
    NSArray *selectOptionArray;
    NSArray *colorOptionArray;
    NSString *selectName;
    NSString *colorName;
    //
    UIImageView *cartNumberImage;
    UILabel *cartNumberLb;
    BOOL isShare;
    UITableView *tableView1;
    UITableView *tableView2;
    
    //新数据
    NSArray *sizeinfodata;
    UIScrollView *_scrollView ;
}
@property (nonatomic, strong) UITableView  *tableView;

@end

@implementation DetailsViewController
- (void)leftBtn
{
    if ([_ttt isEqualToString:@"1"]) {
        [[AppDelegate getAppDelegate].tabbarVC headerMenu];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 48, 28)];//初始化图片视图控件
    //    imageView.contentMode = UIViewContentModeScaleAspectFit;//设置内容样式,通过保持长宽比缩放内容适应视图的大小,任何剩余的区域的视图的界限是透明的。
    UIImage *image = [UIImage imageNamed:@"homeTop"];//初始化图像视图
    [imageView setImage:image];
    //    self.navigationItem.titleView = imageView;//设置导航栏的titleView为imageView
    self.title = @"Details";
    [MobClick event:@"productdetail"];
    UIView *view12 = [[UIView alloc]init];
    view12.frame = RECT(0, 0, 0, 64);
    [self.view addSubview:view12];
    _scrollView = [[UIScrollView alloc]init];
    _scrollView.frame = RECT(0, 64, 320, 568-64);
    _scrollView.contentSize = CGSizeMake(320, (568-64)*3);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scrollView];
    
    
    
    self.view.backgroundColor= [UIColor whiteColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:RECT(0, 0, 320, 568 - 10) style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    //    self.tableView.pagingEnabled = YES;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tag = 0;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:self.tableView];
    
    
    tableView1 = [[UITableView alloc]initWithFrame:RECT(0,  568-64, 320, 568 - 10) style:UITableViewStyleGrouped];
    tableView1.showsVerticalScrollIndicator = NO;
    //    self.tableView.pagingEnabled = YES;
    tableView1.delegate = self;
    tableView1.dataSource = self;
    tableView1.tag = 1;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:tableView1];
    
    tableView2 = [[UITableView alloc]initWithFrame:RECT(0, (568-64)*2, 320, 568 - 10) style:UITableViewStyleGrouped];
    tableView2.showsVerticalScrollIndicator = NO;
    //    self.tableView.pagingEnabled = YES;
    tableView2.delegate = self;
    tableView2.dataSource = self;
    tableView2.tag = 2;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_scrollView addSubview:tableView2];
    
    
    
    
    selectOptionArray = [NSArray new];
    colorOptionArray  = [NSArray new];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(goCart:) name:@"goCart" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setSizeView:) name:@"setSizeView" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Push:) name:@"Push" object:nil];
    [self setRightBar];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getcartNumber) name:@"getcartNumber" object:nil];
    titleArray =
    @[@"FaceBook",@"Twitter"];
    ImageArray =
    @[@"facebook",@"Twitter"];
    [self addtoCart];
    [self moveCart];
    [self getcartNumber];
    isMoreInfo = YES;
    [self moreInfo];
    page = [[UIPageControl alloc]init];
    page.frame = RECT(265, 300, 100, 5);
    page.currentPage = 0;
    page.numberOfPages = 3;
    page.currentPageIndicatorTintColor = RGB_Color(202, 0, 0);
    page.pageIndicatorTintColor = RGB_Color(105, 104, 104);
    page.transform = CGAffineTransformMakeRotation(M_PI/2);
    [self.view addSubview:page];
    
    
    
}

- (void)moreInfo
{
    moreBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [moreBtn setTitle:[NSString stringWithFormat:@"More Info +"] forState:UIControlStateNormal];
    moreBtn.frame = RECT(230, 94, 80, 25);
    [moreBtn setTitleColor:RGB_Color(0, 0, 0) forState:UIControlStateNormal];
    moreBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    [moreBtn addTarget:self action:@selector(moreinfo:) forControlEvents:UIControlEventTouchUpInside];
    moreBtn.layer.cornerRadius = 2;
    moreBtn.layer.borderColor = [RGB_Color(105, 105, 105)CGColor];
    moreBtn.layer.borderWidth = .5;
    [self.view addSubview:moreBtn];
}
- (void)moreinfo:(UIButton *)b
{
    if (isMoreInfo) {
        otherBtnView = [[UIView alloc]init];
        otherBtnView.frame = RECT(230, 120, 80, 100);
        //        view.backgroundColor = [UIColor brownColor];
        NSArray *titleArray1 = @[@"DETAILS",@"REVIEWS"];
        for (int i = 0; i < 2; i++) {
            UIButton * allbtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [allbtn setTitle:[NSString stringWithFormat:@"%@",titleArray1[i]] forState:UIControlStateNormal];
            allbtn.frame = RECT(10, 5+20*i, 60, 20);
            [allbtn setTitleColor:RGB_Color(105, 105,105) forState:UIControlStateNormal];
            allbtn.titleLabel.font = [UIFont systemFontOfSize:10];
            allbtn.tag = i;
            [allbtn addTarget:self action:@selector(movepoint:) forControlEvents:UIControlEventTouchUpInside];
            [otherBtnView addSubview:allbtn];
            
        }
        [self.view addSubview:otherBtnView];
        isMoreInfo = NO;
    }else
    {
        isMoreInfo = YES;
        [otherBtnView removeFromSuperview];
    }
}


- (void)movepoint:(UIButton *)b
{
    if (b.tag == 0) {
        [_scrollView setContentOffset:CGPointMake(0, 568-64) animated:YES];
        
    }else{
        [_scrollView setContentOffset:CGPointMake(0, (568-64)*2) animated:YES];
        
    }
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
    CartViewController *cartVC = [[CartViewController alloc]init];
    [self.navigationController pushViewController:cartVC animated:YES];
    [FBSDKAppEvents logEvent:FBSDKAppEventNameAddedToCart];
    
}
- (void)addtoCart
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(5, CURRENT_CONTENT_HEIGHT - 45, CURRENT_DEVICE_WIDTH-10, 40);
    [btn setTitle:[NSString stringWithFormat:@"ADD TO CART"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    btn.backgroundColor = AllBtn_Color;
    [self.view addSubview:btn];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"getcartNumber" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"goCart" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"setSizeView" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Push" object:nil];
}

- (void)getcartNumber
{
    //来请求购物车
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:MyZenID forKey:@"zenid"];
    [LORequestManger POST:queryAppCart_URL params:dic URl:nil success:^(id response) {
        //        NSLog(@"%@",response);
        NSString *status = [response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            NSDictionary *dic = [response objectForKey:@"data"];
            numberCartLabel.text = [NSString stringWithFormat:@"%@", [dic objectForKey:@"cartTotalNum"]];
            
        }else{
            //            numberCartLabel.hidden = YES;
            //            cartNumberImage.hidden = YES;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        cartNumberLb.hidden = YES;
        cartNumberImage.hidden = YES;
        [self getcartNumber];//再次请求
    }];
}


- (void)setRightBar
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    //        view.backgroundColor = [UIColor redColor];
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(20, 3, 20, 20);
    [backButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [view addSubview:backButton];
    
    cartNumberImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, -2, 15, 15)];
    cartNumberImage.image = [UIImage imageNamed:@"dian"];
    cartNumberImage.hidden = YES;
    //    [view addSubview:cartNumberImage];
    
    cartNumberLb = [[UILabel alloc] initWithFrame:CGRectMake(15, -2, 15, 15)];
    cartNumberLb.font = [UIFont systemFontOfSize:8];
    cartNumberLb.textAlignment = NSTextAlignmentCenter;
    cartNumberLb.text = @"1";
    cartNumberLb.textColor = [UIColor whiteColor];
    //    cartNumberLb.hidden = YES;
    //    [view addSubview:cartNumberLb];
    
    UIButton *pushcart = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushcart addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    pushcart.frame = view.frame;
    [view addSubview:pushcart];
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:view];
    self.navigationItem.rightBarButtonItem = barBtn;
}

- (void)rightBtn
{
    NSLog(@"分享");
    [MobClick event:@"share"];
    
    GiftTalkSheetView * gift = [[GiftTalkSheetView alloc]initWithTitleArray:titleArray
                                                                 ImageArray:ImageArray
                                                                 PointArray:nil
                                                               ActivityName:nil
                                                                   Delegate:self];
    [gift ShowInView:self.view];
    
    
}

- (void)viewwillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [selectView close];
}

- (void)request
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *zendID = MyZenID;
    [dic setObject:zendID forKey:@"zenid"];
    [dic setObject:_positionID forKey:@"productsID"];
    [self showLoadingWithMaskType];
    [LORequestManger POST:ProductInfo_Url params:dic URl:dic success:^(id response) {
        dataDic = [response objectForKey:@"data"];
        //        NSLog(@"%@",dataDic);
        NSString *remocomedStr = [dataDic objectForKey:@"otherProductsLink"];
        [self requestRecommend:remocomedStr];
        [self requestSize];
        [self.tableView reloadData];
        [tableView2 reloadData];
        [tableView1 reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self request];
    }];
    
}
- (void)requestRecommend:(NSString *)url
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *zendID = MyZenID;
    [dic setObject:zendID forKey:@"zenid"];
    [LORequestManger Card:url params:dic URl:nil success:^(id response) {
        NSLog(@"%@",response);
        dataArray = [response objectForKey:@"data"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)requestSize
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    NSString *zendID = MyZenID;
    [dic setObject:zendID forKey:@"zenid"];
    [dic setObject:_positionID forKey:@"productsID"];
    [LORequestManger POST:getProductSize_URL params:dic URl:dic success:^(id response) {
        NSLog(@"%@",response);
        [self dismiss];
        NSString *status = [response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]){
            //数据处理
            sizeinfodata = [response objectForKey:@"data"];
            
        }else{
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
        [self requestSize];
    }];
    
}

#pragma mark - tableView dataSource delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 0) {
        static NSString *str = @"cell";
        DetailsImageCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[DetailsImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        [cell setData:dataDic];
        [cell PushIndex:^(NSString *a) {
            NSString *str = a;
            
            if ([str isEqualToString:@"10"]) {
                NSLog(@"分享");
                [MobClick event:@"share"];
                
                GiftTalkSheetView * gift = [[GiftTalkSheetView alloc]initWithTitleArray:titleArray
                                                                             ImageArray:ImageArray
                                                                             PointArray:nil
                                                                           ActivityName:nil
                                                                               Delegate:self];
                [gift ShowInView:self.view];
                
                
            }else if([str isEqualToString:@"111"]){
                NSLog(@"");
            }else if([str isEqualToString:@"11"]){
                NSLog(@"评论");
                [MobClick event:@"comment"];
                
                ReviewVC *reviewVC = [[ReviewVC alloc]init];
                reviewVC.positionID = self.positionID;
                [self.navigationController pushViewController:reviewVC animated:YES];
            }else if([str isEqualToString:@"12"]){
                NSDictionary *loginDic = [NSUserDefaultsDic valueForKey:@"loginOK"];
                if (loginDic) {
                    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
                    NSString *zendID = MyZenID;
                    [dic setObject:zendID forKey:@"zenid"];
                    [dic setObject:_positionID forKey:@"pid"];
                    [self showLoadingWithMaskType];
                    [LORequestManger POST:collection_Url params:dic URl:nil success:^(id response) {
                        NSString *status = [response objectForKey:@"status"];
                        if ([status isEqualToString:@"OK"]) {
                            [self dismissSuccess:@"Success"];
                            //                    NSLog(@"%@",response);
                        }else{
                            [self dismissError:@""];
                        }
                        
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"%@",error);
                        
                    }];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"Please login"];
                }
                
            }
            
        }];
        [cell buyBlock:^{
            
            
            hascolor = YES;
            hassize  = YES;
            if (hascolor || hassize) {
                selectView = [[SelectView alloc]init];
                selectView.sizeinfoArray = sizeinfodata;
                [selectView sizeInfo:^(NSDictionary *dic) {
                    NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithCapacity:1];
                    [self showLoadingWithMaskType];
                    
                    //重做添加购物车
                    if ([[dic objectForKey:@"sizebool"]isEqualToString:@"1"]) {
                        NSDictionary *sizeDic = [dic objectForKey:@"size"];
                        NSString *productsID = [dic objectForKey:@"color"];
                        [dic2 setValue:MyZenID forKey:@"zenid"];
                        [dic2 setValue:productsID forKey:@"products_id"];
                        [dic2 setValue:[sizeDic objectForKey:@"selectOptionValue"] forKey:@"id[1]"];
                        [dic2 setValue:@"1" forKey:@"cart_quantity"];
                    }else{
                        NSString *productsID = [dic objectForKey:@"color"];
                        [dic2 setValue:MyZenID forKey:@"zenid"];
                        [dic2 setValue:productsID forKey:@"products_id"];
                        [dic2 setValue:@"1" forKey:@"cart_quantity"];
                    }
                    
                    [selectView close];
                    [LORequestManger POST:addToCart_URL params:dic2 URl:nil success:^(id response) {
                        
                        NSString *status =[response objectForKey:@"status"];
                        
                        if ([status isEqualToString:@"OK"])  {
                            NSLog(@"%d",isShare);
                            
                            //            [self dismissSuccess:@"Add success"];
                            CartViewController *cartVC = [[CartViewController alloc]init];
                            cartVC.isShare = isShare;
                            [self.navigationController pushViewController:cartVC animated:YES];
                            
                            //            NSLog(@"%@",response);
                        }else{
                            [self dismissError:nil];
                        }
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"%@",error);
                    }];
                    
                }];
                [selectView setBtn];
                selectView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.3];
                selectView.frame =CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT);
                [selectView show];
            }else {
                //没有尺码问题修复
                [self showLoadingWithMaskType];
                NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
                [dic setValue:MyZenID forKey:@"zenid"];
                [dic setValue:@"1" forKey:@"cart_quantity"];
                [dic setValue:self.positionID forKey:@"products_id"];
                [LORequestManger POST:addToCart_URL params:dic URl:nil success:^(id response) {
                    
                    NSString *status =[response objectForKey:@"status"];
                    
                    if ([status isEqualToString:@"OK"])  {
                        //                [self dismissSuccess:@"Add success"];
                        CartViewController *cartVC = [[CartViewController alloc]init];
                        cartVC.isShare = isShare;
                        [self.navigationController pushViewController:cartVC animated:YES];
                    }else{
                        [self dismissError:nil];
                    }
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    NSLog(@"%@",error);
                }];
            }
            
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (tableView.tag == 1) {
        static NSString *str = @"cell1";
        NewDetailSImageCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[NewDetailSImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        
        [cell reviewWith:dataDic];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *str = @"cell2";
        NewReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[NewReviewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:dataDic];
        return cell;
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    if (indexPath.row == 0) {
    //        return CURRENT_CONTENT_HEIGHT-64-40-79 ;
    //    }if (indexPath.row == 1) {
    //        if ([[dataDic objectForKey:@"reviews_count"]isEqualToString:@"0"]) {
    //            return 45;
    //        }else{
    //        return 100;
    //        }
    //    }else if (indexPath.row == 2){
    //        return 100;
    //    }else if (indexPath.row == 3)
    //    {
    //        return 130;
    //    }
    return 500;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag== 2) {
        ReviewVC *reviewVC = [[ReviewVC alloc]init];
        reviewVC.positionID = self.positionID;
        reviewVC.aaa = @"1";
        [self.navigationController pushViewController:reviewVC animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (void)Push:(NSNotification *)sender
{
    
}
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

- (void)setSizeView:(id)sender
{
    
}

//跳转购物车
-(void)goCart:(NSNotification *)sender
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark FBSDKShareDialog
- (FBSDKShareDialog *)getShareDialogWithContentURL:(NSURL *)objectURL
{
    FBSDKShareDialog *shareDialog = [[FBSDKShareDialog alloc] init];
    shareDialog.shareContent = [self getShareLinkContentWithContentURL:objectURL];
    return shareDialog;
}
- (FBSDKShareLinkContent *)getShareLinkContentWithContentURL:(NSURL *)objectURL
{
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    content.contentURL = objectURL;
    content.contentTitle = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"products_name"]];
    content.imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"Image"]]];
    return content;
}
#pragma mark - FBSDKSharingDelegate

- (void)sharer:(id<FBSDKSharing>)sharer didCompleteWithResults:(NSDictionary *)results
{
    
    isShare = YES;
    NSLog(@"+++++++++++++++++++++++++++++++++++++++++++%d",isShare);
    //    NSLog(@"completed share:%@", results);
}

- (void)sharer:(id<FBSDKSharing>)sharer didFailWithError:(NSError *)error
{
    NSLog(@"sharing error:%@", error);
    NSString *message = error.userInfo[FBSDKErrorLocalizedDescriptionKey] ?:
    @"There was a problem sharing, please try again later.";
    NSString *title = error.userInfo[FBSDKErrorLocalizedTitleKey] ?: @"Oops!";
    
    [[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

- (void)sharerDidCancel:(id<FBSDKSharing>)sharer
{
    NSLog(@"share cancelled");
    shareOK = @"NO";
    NSLog(@"__________________________________________%d",isShare);
    
}

#pragma mark delegate
-(void)GiftTalkShareButtonAction:(NSInteger *)buttonIndex
{
    //    NSLog(@"%ld",(long)buttonIndex);
    int index = (int)buttonIndex;
    if (index == 0) {
        NSLog(@"faceBook");
        //        NSURL * myURL_APP_A = [NSURL URLWithString:@"fbauth2://"];
        //        if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
        //          NSLog(@"canOpenURL");
        //            [[UIApplication sharedApplication] openURL:myURL_APP_A];
        FBSDKShareDialog *shareDialog = [self getShareDialogWithContentURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"shareLink"]]]];
        shareDialog.mode = FBSDKShareDialogModeNative;
        shareDialog.delegate = self;
        [shareDialog show];
        //        }
        
    }else if (index == 1){
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
            SLComposeViewController *svc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
            SLComposeViewControllerCompletionHandler myblock = ^(SLComposeViewControllerResult result){
                if(result == SLComposeViewControllerResultCancelled){
                    NSLog(@"cancel");
                    isShare = NO;
                    
                }else{
                    NSLog(@"done");
                    isShare = YES;
                    
                }
                [svc dismissViewControllerAnimated:YES completion:nil];
            };
            svc.completionHandler = myblock;
            [svc setInitialText:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"products_name"]]];
            //        NSString *imageStr = [NSString stringWithFormat:@"%@",[dataDic objectForKey:@"Image"]];
            //        NSURL *url = [[NSURL alloc]initWithString:imageStr];
            //        NSData *dataImage = [NSData dataWithContentsOfURL:url];
            //        [svc addImage:[UIImage imageNamed:imageStr]];
            [svc addURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"shareLink"]]]];
            [self presentViewController:svc animated:YES completion:nil];
            
        }else{
            UIAlertView *alveiw = [[UIAlertView alloc]initWithTitle:@"" message:@"Set up account" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alveiw show];
        }
    }
}

- (void)tuijianBtn:(UIButton *)b
{
    NSLog(@"%ld",(long)b.tag);
    NSInteger num = b.tag - 100;
    NSDictionary *dic = dataArray[num];
    DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
    detailsVC.positionID =[dic objectForKey:@"positionID"];
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    isShare = NO;
    shareOK  = @"YES";
    
}
- (void)buy
{
    
    [FBSDKAppEvents logEvent:FBSDKAppEventNameAddedToCart valueToSum:[[dataDic objectForKey:@"Price"] doubleValue] parameters:@{FBSDKAppEventNameAddedToCart: @"add to cart"}];
    
    hascolor = YES;
    hassize  = YES;
    if (hascolor || hassize) {
        selectView = [[SelectView alloc]init];
        selectView.sizeinfoArray = sizeinfodata;
        [selectView sizeInfo:^(NSDictionary *dic) {
            NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithCapacity:1];
            [self showLoadingWithMaskType];
            
            //重做添加购物车
            if ([[dic objectForKey:@"sizebool"]isEqualToString:@"1"]) {
                NSDictionary *sizeDic = [dic objectForKey:@"size"];
                NSString *productsID = [dic objectForKey:@"color"];
                [dic2 setValue:MyZenID forKey:@"zenid"];
                [dic2 setValue:productsID forKey:@"products_id"];
                [dic2 setValue:[sizeDic objectForKey:@"selectOptionValue"] forKey:@"id[1]"];
                [dic2 setValue:@"1" forKey:@"cart_quantity"];
            }else{
                NSString *productsID = [dic objectForKey:@"color"];
                [dic2 setValue:MyZenID forKey:@"zenid"];
                [dic2 setValue:productsID forKey:@"products_id"];
                [dic2 setValue:@"1" forKey:@"cart_quantity"];
            }
            
            [selectView close];
            [LORequestManger POST:addToCart_URL params:dic2 URl:nil success:^(id response) {
                
                NSString *status =[response objectForKey:@"status"];
                
                if ([status isEqualToString:@"OK"])  {
                    NSLog(@"%d",isShare);
                    
                    //            [self dismissSuccess:@"Add success"];
                    CartViewController *cartVC = [[CartViewController alloc]init];
                    cartVC.isShare = isShare;
                    [self.navigationController pushViewController:cartVC animated:YES];
                    
                    //            NSLog(@"%@",response);
                }else{
                    [self dismissError:nil];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error);
            }];
            
        }];
        [selectView setBtn];
        selectView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.3];
        selectView.frame =CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT);
        [selectView show];
    }else {
        //没有尺码问题修复
        [self showLoadingWithMaskType];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
        [dic setValue:MyZenID forKey:@"zenid"];
        [dic setValue:@"1" forKey:@"cart_quantity"];
        [dic setValue:self.positionID forKey:@"products_id"];
        [LORequestManger POST:addToCart_URL params:dic URl:nil success:^(id response) {
            
            NSString *status =[response objectForKey:@"status"];
            
            if ([status isEqualToString:@"OK"])  {
                //                [self dismissSuccess:@"Add success"];
                CartViewController *cartVC = [[CartViewController alloc]init];
                cartVC.isShare = isShare;
                [self.navigationController pushViewController:cartVC animated:YES];
            }else{
                [self dismissError:nil];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = scrollView.contentOffset.y;
    if (y > 500 - 64 - 20){
        [moreBtn removeFromSuperview];
        
        [otherBtnView removeFromSuperview];
        if (isMoreInfo == NO) {
            isMoreInfo = YES;
        }
    }else
    {
        [self.view addSubview:moreBtn];
        
    }
    page.currentPage = scrollView.contentOffset.y/400;
    
    
    
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    [self.tableView setContentOffset:CGPointMake(0, 500-64) animated:NO];
    
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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
