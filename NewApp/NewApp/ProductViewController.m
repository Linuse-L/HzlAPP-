//
//  ProductViewController.m
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "ProductViewController.h"
#import "ListCell.h"
#import "DetailsViewController.h"
#import "ScVCell.h"

@interface ProductViewController ()
{
    NSInteger page;
    //筛选视图
    UIView *screenView;
    //筛选小条
    UIImageView *screenImaView;
    //筛选背景
    UIView *screeBG;
    //滑动背景
    UIScrollView *scrollviewBg;
    //三部分的滑动属性图
    UIView *scrollView1;
    UIView *scrollView2;
    UIView *scrollView3;
    //数组源数据
    NSString *apiLink;
    NSArray *sortbyArr;
    NSArray *taglistArr;
    NSArray *classListArr;
    UIImageView *imageviewdd;
    NSMutableArray *allArr;
}
@property  (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ProductViewController
@synthesize dataArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    //    筛选视图
    allArr = [NSMutableArray array];
    if ([_ishome isEqualToString:@"1"]) {
        
        UIView *screenViewBg = [[UIView alloc] initWithFrame:CGRectMake(0, 64, CURRENT_CONTENT_WIDTH, 40)];
        [self.view addSubview:screenViewBg];
        
        imageviewdd = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, 40)];
        imageviewdd.backgroundColor = [UIColor clearColor];
        imageviewdd.alpha = 0.3;
        [screenViewBg addSubview:imageviewdd];
        
        screenView = [[UIView alloc] initWithFrame:CGRectMake(10, 0, CURRENT_CONTENT_WIDTH-20, 40)];
        screenView.backgroundColor = [UIColor whiteColor];
        [screenViewBg addSubview:screenView];
        screenImaView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 39, (CURRENT_CONTENT_WIDTH-20)/3, 1)];
        screenImaView.hidden = YES;
        screenImaView.backgroundColor = Btn_Color;
        [screenView addSubview:screenImaView];
        NSArray *titleArr = @[@"Sort", @"Category", @"Filter"];
        for (int i = 0; i<3; i++) {
            UIButton *screenBt = [UIButton buttonWithType:UIButtonTypeCustom];
            screenBt.frame = CGRectMake((CURRENT_CONTENT_WIDTH-20)/3*i, 0, (CURRENT_CONTENT_WIDTH-20)/3, 39);
            screenBt.tag = i+10;
            [screenBt setTitle:titleArr[i] forState:UIControlStateNormal];
            [screenBt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            screenBt.titleLabel.font = [UIFont systemFontOfSize:11];
            [screenBt addTarget:self action:@selector(clickScreenBt:) forControlEvents:UIControlEventTouchUpInside];
            [screenView addSubview:screenBt];
        }
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 104, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT-104) collectionViewLayout:flowLayout];
        dataArray = [NSMutableArray arrayWithCapacity:1];
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 5, 2, 5);
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.view addSubview:self.collectionView];
        page = 1;
        [self.collectionView registerClass:[ListCell class]
                forCellWithReuseIdentifier:@"cell"];
        [self.collectionView registerClass:[ListCell class]
                forCellWithReuseIdentifier:@"cell1"];
        if (!self.isSearch) {
            [self refresh];
        }
        if (_isSearch) {
            [dataArray addObjectsFromArray: _searchArray];
        }else{
            [self getResfst];
        }
        [self initScreenBG];
    }else {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT) collectionViewLayout:flowLayout];
        dataArray = [NSMutableArray arrayWithCapacity:1];
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 5, 2, 5);
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.view addSubview:self.collectionView];
        page = 1;
        [self.collectionView registerClass:[ListCell class]
                forCellWithReuseIdentifier:@"cell"];
        [self.collectionView registerClass:[ListCell class]
                forCellWithReuseIdentifier:@"cell1"];
        if (!self.isSearch) {
            [self refresh];
        }
        if (_isSearch) {
            [dataArray addObjectsFromArray: _searchArray];
        }else{
            [self getResfst];
        }

    }
    // Do any additional setup after loading the view.
}

//创建筛选的视图
- (void)initScreenBG
{
    screeBG = [[UIView alloc] initWithFrame:CGRectMake(0, 104, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT-104)];
    screeBG.backgroundColor = [UIColor clearColor];
    screeBG.hidden = YES;
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT-104)];
    imageview.backgroundColor = [UIColor blackColor];
    imageview.alpha = 0.3;
    [screeBG addSubview:imageview];
    
    scrollviewBg = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, CURRENT_CONTENT_WIDTH-20, CURRENT_CONTENT_HEIGHT-104)];
    scrollviewBg.backgroundColor = [UIColor whiteColor];
    scrollviewBg.pagingEnabled = YES;
    scrollviewBg.delegate = self;
    
    scrollviewBg.contentSize = CGSizeMake((CURRENT_CONTENT_WIDTH-20)*3, 0);
    [screeBG addSubview:scrollviewBg];
    [self.view addSubview:screeBG];
    
    //三部分的视图
    scrollView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH-20, CURRENT_CONTENT_HEIGHT-104)];
    scrollView1.backgroundColor = [UIColor clearColor];
    [scrollviewBg addSubview:scrollView1];
    
    scrollView2 = [[UIView alloc] initWithFrame:CGRectMake(CURRENT_CONTENT_WIDTH-20, 0, CURRENT_CONTENT_WIDTH-20, CURRENT_CONTENT_HEIGHT-104)];
    scrollView2.backgroundColor = [UIColor clearColor];
    [scrollviewBg addSubview:scrollView2];
    
    scrollView3 = [[UIView alloc] initWithFrame:CGRectMake((CURRENT_CONTENT_WIDTH-20)*2, 0, CURRENT_CONTENT_WIDTH-20, CURRENT_CONTENT_HEIGHT-104)];
    scrollView3.backgroundColor = [UIColor clearColor];
    [scrollviewBg addSubview:scrollView3];
}

- (void)backSreenBg
{
    screeBG.hidden = YES;
}

//筛选按钮点击方法
- (void)clickScreenBt:(UIButton *)sender
{
    imageviewdd.backgroundColor = [UIColor blackColor];
    screeBG.hidden = NO;
    screenImaView.hidden = NO;
    for (int i = 0; i<3; i++) {
        UIButton *button = [self.view viewWithTag:i+10];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    UIButton *button = [self.view viewWithTag:sender.tag];
    [button setTitleColor:Btn_Color forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        screenImaView.frame = CGRectMake((CURRENT_CONTENT_WIDTH-20)/3*(sender.tag-10), 39, (CURRENT_CONTENT_WIDTH-20)/3, 1);
    } completion:^(BOOL finished) {
        
    }];
    //筛选数据请求
    [self showLoadingWithMaskType];
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    [dic setObject:_classid forKey:@"classid"];
    [LORequestManger POST:screenPrd params:dic URl:nil success:^(id response) {
        [self dismiss];
        NSLog(@"%@",response);
        NSString *status = [response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            [allArr removeAllObjects];
            [scrollviewBg setContentOffset:CGPointMake((sender.tag-10)*(CURRENT_CONTENT_WIDTH-20), 0) animated:YES];
            /****************
             4类筛选
             作出所有数据调整
             ***************/
            NSDictionary *data    = [response objectForKey:@"data"];
            apiLink      = [data objectForKey:@"apiLink"];
            sortbyArr    = [data objectForKey:@"sortby"];
            taglistArr   = [data objectForKey:@"tagList"];
            classListArr = [data objectForKey:@"classList"];
            
            //给滑动视图赋值1
            for (int i = 0; i<sortbyArr.count; i++) {
                NSDictionary *dic = sortbyArr[i];
                UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(10, 35*i, CURRENT_CONTENT_WIDTH-30, 34)];
                lb.text = [dic objectForKey:@"showName"];
                lb.textColor = Btn_Color;
                lb.font = [UIFont systemFontOfSize:12];
                [scrollView1 addSubview:lb];
                
                UIImageView *imageline = [[UIImageView alloc] initWithFrame:CGRectMake(10, 35*i+34, CURRENT_CONTENT_WIDTH-20, 0.5)];
                imageline.backgroundColor = [UIColor groupTableViewBackgroundColor];
                [scrollView1 addSubview:imageline];
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(10, 35*i, CURRENT_CONTENT_WIDTH-30, 35);
                [button addTarget:self action:@selector(scrollView1Click:) forControlEvents:UIControlEventTouchUpInside];
                button.tag = i;
                [scrollView1 addSubview:button];
            }
            
            /********************************************************************
             
             滑动视图2用表视图实现
             
             *******************************************************************/
            
            UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH-20, CURRENT_CONTENT_HEIGHT-114)];
            tableView.delegate     = self;
            tableView.dataSource   = self;
            tableView.rowHeight    = 35;
            [scrollView2 addSubview:tableView];
            
            /***************
             给滑动视图赋值3
             1 60 2 80 3 60
             **************/
            NSDictionary *typedic  = taglistArr[0];
            NSDictionary *colordic = taglistArr[1];
            NSDictionary *banddic  = taglistArr[2];
            
            //1
            UIView *taglistview1   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH-20, 70)];
            taglistview1.backgroundColor = [UIColor clearColor];
            [scrollView3 addSubview:taglistview1];
            UILabel *typelb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
            typelb.textColor = [UIColor grayColor];
            typelb.text = [typedic objectForKey:@"name"];
            typelb.font = [UIFont systemFontOfSize:14];
            [taglistview1 addSubview:typelb];
            
            NSArray *typeArr = [typedic objectForKey:@"sonList"];
            [allArr addObjectsFromArray:typeArr];
            for (int i = 0; i<typeArr.count; i++) {
                NSDictionary *dic = typeArr[i];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = i;
                [button addTarget:self action:@selector(scrollView3Click:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:[dic objectForKey:@"tag_name"] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:13];
                [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                button.frame = CGRectMake(120*i, 40, 70, 30);
                [taglistview1 addSubview:button];
            }
            
            //2
            UIView *taglistview2   = [[UIView alloc] initWithFrame:CGRectMake(0, 70, CURRENT_CONTENT_WIDTH-20, 100)];
            taglistview2.backgroundColor = [UIColor clearColor];
            [scrollView3 addSubview:taglistview2];
            
            UILabel *colorlb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
            colorlb.textColor = [UIColor grayColor];
            colorlb.text = [colordic objectForKey:@"name"];
            colorlb.font = [UIFont systemFontOfSize:14];
            [taglistview2 addSubview:colorlb];
            
            NSArray *colorArr = [colordic objectForKey:@"sonList"];
            [allArr addObjectsFromArray:colorArr];
            for (int i = 0; i<colorArr.count; i++) {
                NSDictionary *dic = colorArr[i];
                if (i>2) {
                    
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.tag = i+typeArr.count;
                    [button setTitle:[dic objectForKey:@"tag_name"] forState:UIControlStateNormal];
                    [button addTarget:self action:@selector(scrollView3Click:) forControlEvents:UIControlEventTouchUpInside];
                    button.titleLabel.font = [UIFont systemFontOfSize:13];
                    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    button.frame = CGRectMake(120*(i-3), 70, 70, 30);
                    [taglistview2 addSubview:button];
                }
                
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = i+typeArr.count;
                [button setTitle:[dic objectForKey:@"tag_name"] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:13];
                [button addTarget:self action:@selector(scrollView3Click:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                button.frame = CGRectMake(120*i, 40, 70, 30);
                [taglistview2 addSubview:button];
            }
            
            //3
            UIView *taglistview3   = [[UIView alloc] initWithFrame:CGRectMake(0, 170, CURRENT_CONTENT_WIDTH-20, 70)];
            taglistview3.backgroundColor = [UIColor clearColor];
            [scrollView3 addSubview:taglistview3];
            
            UILabel *bandlb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 40)];
            bandlb.textColor = [UIColor grayColor];
            bandlb.text = [banddic objectForKey:@"name"];
            bandlb.font = [UIFont systemFontOfSize:14];
            [taglistview3 addSubview:bandlb];
            
            NSArray *bandArr = [banddic objectForKey:@"sonList"];
            [allArr addObjectsFromArray:bandArr];
            for (int i = 0; i<bandArr.count; i++) {
                NSDictionary *dic = bandArr[i];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.tag = i+colorArr.count+typeArr.count;
                [button addTarget:self action:@selector(scrollView3Click:) forControlEvents:UIControlEventTouchUpInside];
                [button setTitle:[dic objectForKey:@"tag_name"] forState:UIControlStateNormal];
                button.titleLabel.font = [UIFont systemFontOfSize:13];
                [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                button.frame = CGRectMake(120*i, 40, 70, 30);
                [taglistview3 addSubview:button];
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismissError:@"Error"];
    }];

}

//滑动视图1点击方法
- (void)scrollView1Click:(UIButton *)sender
{
    imageviewdd.backgroundColor = [UIColor clearColor];
    //请求1级分类
    NSDictionary *dicc = sortbyArr[sender.tag];
    NSLog(@"%@", [dicc objectForKey:@"sendVal"]);
    
    //数据请求
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    [dic setObject:[dicc objectForKey:@"sendVal"] forKey:@"sortby"];
    page = 1;
    [LORequestManger Card:apiLink params:dic URl:nil success:^(id response) {
        [self backSreenBg];
        if ([[response objectForKey:@"status"] isEqualToString:@"OK"]) {
            [self dismiss];
            NSDictionary *dic = response;
            NSLog(@"%@",dic);
            NSMutableArray * array = [dic objectForKey:@"data"];
            [dataArray removeAllObjects];
            [dataArray addObjectsFromArray:array];
        }else{
            UIAlertController *alertController = [AlertControllerUtility alertControllerWithTitle:@""
                                                                                          message:@"There is no products"];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
    }];
}

- (void)scrollView3Click:(UIButton *)sender
{
    imageviewdd.backgroundColor = [UIColor clearColor];
    NSLog(@"%ld", (long)sender.tag);
    NSLog(@"%@",allArr);
    NSDictionary *dicc = allArr[sender.tag];
    NSLog(@"%@", [dicc objectForKey:@"tag_id"]);
    //数据请求
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    [dic setObject:[dicc objectForKey:@"tag_id"] forKey:@"tag_id[]"];
    page = 1;
    [LORequestManger Card:apiLink params:dic URl:nil success:^(id response) {
        [self backSreenBg];
        if ([[response objectForKey:@"status"] isEqualToString:@"OK"]) {
            [self dismiss];
            NSDictionary *dic = response;
            NSLog(@"%@",dic);
            NSArray * array = [dic objectForKey:@"data"];
            [dataArray removeAllObjects];
            [dataArray addObjectsFromArray:array];
            [self.collectionView reloadData];
        }else{
            UIAlertController *alertController = [AlertControllerUtility alertControllerWithTitle:@""
                                                                       message:@"There is no products"];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
    }];
}

- (void)getResfst
{
    [self showLoadingWithMaskType];

    if (_classid) {
        NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
        [dic setObject:_classid forKey:@"classid"];
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
        [LORequestManger POST:getProductsList params:dic URl:dic success:^(id response) {
            NSLog(@"%@",response);
            NSString *status = [response objectForKey:@"status"];
            if ([status isEqualToString:@"OK"]){
                [self dismiss];
                NSDictionary *dic = response;
                NSLog(@"%@",dic);
               NSArray * array = [dic objectForKey:@"data"];
                [dataArray addObjectsFromArray:array];
                [self.collectionView reloadData];
            }else{
                [self dismissError:nil];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [self dismissError:@"Error"];
        }];
    }else{
        NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
        [dic setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
        [LORequestManger Card:self.dataUrl params:dic URl:nil success:^(id response) {
            [self dismiss];
            NSDictionary *dic = response;
            NSLog(@"%@",dic);
            NSArray * array = [dic objectForKey:@"data"];
            [dataArray addObjectsFromArray:array];
            [self.collectionView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [self dismiss];
        }];
    }
    
}

- (void)refresh
{
    // 上拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 增加5条假数据
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        page++;
        if (_classid) {
            [self requestClassId];
        }else{
            [self requestLoading];
        }
    }];
    // 默认先隐藏footer
    self.collectionView.footer.hidden = YES;
}

- (void)requestLoading
{
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    NSString *urlStr = [NSString stringWithFormat:@"%@&page=%ld",self.dataUrl,(long)page];
    [LORequestManger Card:urlStr params:dic URl:nil success:^(id response) {
        
        NSLog(@"%@",response);
        NSString *status = [response objectForKey:@"status"];
        
        if ([status isEqualToString:@"OK"]){
            [self dismiss];
            NSDictionary *dic = response;
            NSLog(@"%@",dic);
            NSArray * array = [dic objectForKey:@"data"];
            
            [dataArray addObjectsFromArray:array];
            [self.collectionView.footer endRefreshing];
            [self.collectionView reloadData];
        }else{
            //            [self showWithStatus:@"NO Products"];
            [self dismiss];
            [self.collectionView.footer allendRefreshing];
            [self.collectionView reloadData];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
    }];
}

- (void)requestClassId
{
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    [dic setObject:_classid forKey:@"classid"];
    [dic setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    NSMutableDictionary *urlDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [urlDic setObject:_classid forKey:@"classid"];
    [urlDic setObject:[NSString stringWithFormat:@"%ld",(long)page] forKey:@"page"];
    [LORequestManger POST:getProductsList params:dic URl:urlDic success:^(id response) {
        NSLog(@"%@",response);
        NSString *status = [response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]){
            [self dismiss];
            NSDictionary *dic = response;
            NSLog(@"%@",dic);
            NSArray *array = [dic objectForKey:@"data"];
            [dataArray addObjectsFromArray:array];
            [self.collectionView.footer endRefreshing];
            [self.collectionView reloadData];
        }else{
            self.collectionView.footer.state = MJRefreshStateNoMoreData;
            [self.collectionView.footer allendRefreshing];
            [self.collectionView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
        [self requestClassId];
    }];
    
}

#pragma mark - UITabDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return classListArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"indexcell";
    ScVCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ScVCell" owner:self options:nil];
        cell = nib[0];
    }
    NSDictionary *dic = classListArr[indexPath.row];
    NSLog(@"%@", [dic objectForKey:@"className"]);
    [cell setDic:dic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    imageviewdd.backgroundColor = [UIColor clearColor];
    //这里开始做出数据请求
    NSDictionary *dicc = classListArr[indexPath.row];
    NSLog(@"%@", [dicc objectForKey:@"apiLink"]);
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    page = 1;
    [LORequestManger Card:[dicc objectForKey:@"apiLink"] params:dic URl:nil success:^(id response) {
        
        NSString *status =[response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            [self dismiss];
            self.title = [dicc objectForKey:@"className"];
            [self backSreenBg];
            NSDictionary *dic = response;
            NSLog(@"%@",dic);
            NSMutableArray * array = [dic objectForKey:@"data"];
            [dataArray removeAllObjects];
            [dataArray addObjectsFromArray:array];
        }else{
            UIAlertController *alertController = [AlertControllerUtility alertControllerWithTitle:@""
                                                                                          message:@"There is no products"];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
    }];
}

#pragma  mark - uicollection delegate and dataSource
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        ListCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell1" forIndexPath:indexPath];
        cell.backgroundColor = nav_Color;
        NSDictionary *dic = dataArray[indexPath.row];
        [cell setData:dic];
        return  cell;
}

// 定义上下cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

// 定义左右cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(CURRENT_CONTENT_WIDTH/2-10, 200);
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    return dataArray.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",(long)indexPath.row);
    DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
    NSDictionary *dic = dataArray[indexPath.row];
    detailsVC.positionID =[dic objectForKey:@"positionID"];
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}

//筛选代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == scrollviewBg) {
        for (int i = 0; i<3; i++) {
            UIButton *button = [self.view viewWithTag:i+10];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        UIButton *button = [self.view viewWithTag:scrollView.contentOffset.x/(CURRENT_CONTENT_WIDTH-20)+10];
        [button setTitleColor:Btn_Color forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            screenImaView.frame = CGRectMake((CURRENT_CONTENT_WIDTH-20)/3*(scrollView.contentOffset.x/(CURRENT_CONTENT_WIDTH-20)), 39, (CURRENT_CONTENT_WIDTH-20)/3, 1);
        } completion:^(BOOL finished) {
            
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
