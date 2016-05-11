//
//  NewProductViewController.m
//  NewApp
//
//  Created by L on 16/4/26.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "NewProductViewController.h"
static NSString *FirstCell = @"FirstCell";
@interface NewProductViewController ()
{
    ScreeningView *SXView;
    UIView *view;
}
@end

@implementation NewProductViewController
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"againRequest" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"categoryRequest" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"screenView" object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"filterRequest" object:nil];

}
- (void)leftBtn
{
    [[AppDelegate getAppDelegate].tabbarVC headerMenu];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self initHeardView];
    [self initCollectionView];
//    [self setShaixuan];
    [self setScreen];
    [self screeningRequest];
    page = 1;
    allDicArray = [NSMutableArray arrayWithCapacity:1];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(againRequest:) name:@"againRequest" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(categoryRequest:) name:@"categoryRequest" object:nil];


    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(screenView:) name:@"screenView" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(filterRequest:) name:@"filterRequest" object:nil];
    [self refresh];
    sendVal = nil;
    tag_id = nil;
    // Do any additional setup after loading the view.
}
- (void)refresh
{
    // 上拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 增加5条假数据
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        page++;
            [self request];
    }];
    // 默认先隐藏footer
    self.collectionView.footer.hidden = YES;
}

- (void)initCollectionView
{
    My_FlowLayout *flowayout = [[My_FlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:RECT(0, 0, 320, CURRENT_DEVICE_HEIGHT) collectionViewLayout:flowayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[ListCell class] forCellWithReuseIdentifier:FirstCell];
    [self.collectionView registerClass:[NewBanCell class] forCellWithReuseIdentifier:@"BannerCell"];
    [self.collectionView registerClass:[ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    [self.collectionView registerClass:[H_ReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"1"];

    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
}
#pragma Request Data
- (void)request
{
    [self showLoadingWithMaskType];
    NSString *urlStr = [NSString stringWithFormat:@"%@&page=%ld",self.linkUrlStr,(long)page];

    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    [dic setValue:sendVal forKey:@"sortby"];
    [dic setValue:tag_id forKey:@"tag_id[]"];
    [LORequestManger Card:urlStr params:dic URl:nil success:^(id response) {
        NSLog(@"%@",response);
        NSString *status = [NSString stringWithFormat:@"%@",[response objectForKey:@"status"]];
        if ([status isEqualToString:@"OK"]) {
            NSArray * array = [response objectForKey:@"data"];
            [allDicArray addObjectsFromArray:array];
            [self.collectionView.footer endRefreshing];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];

            });
            [self dismiss];

        }else{
            [self.collectionView.footer allendRefreshing];
            [self.collectionView reloadData];
            [self dismissError:[response objectForKey:@"data"]];

        }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self request];
    }];
}

- (void)screeningRequest
{
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    [dic setObject:_classid forKey:@"classid"];
    [LORequestManger POST:screenPrd params:dic URl:nil success:^(id response) {
        NSLog(@"%@",response);
        
        NSDictionary *data    = [response objectForKey:@"data"];
        apiLink      = [data objectForKey:@"apiLink"];
//        sort
        sortbyArr    = [data objectForKey:@"sortby"];
//        filter
        taglistArr   = [data objectForKey:@"tagList"];
//        category
        classListArr = [data objectForKey:@"classList"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
#pragma mark againRequest
- (void)againRequest:(NSNotification *)sender
{
    sendVal = sender.object;
    [allDicArray removeAllObjects];
    page = 1;
    tag_id = nil;
    [self request];
}
- (void)categoryRequest:(NSNotification *)sender
{
    self.linkUrlStr = sender.object;
    sendVal = nil;
    tag_id = nil;
    [allDicArray removeAllObjects];
    page = 1;

    [self request];
}
- (void)filterRequest:(NSNotification *)sender
{
    tag_id = sender.object;
//    sendVal = @"";
    [allDicArray removeAllObjects];
    page = 1;

    [self request];
}
#pragma mark -筛选视图
- (void)setScreen
{
    SXView = [[ScreeningView alloc]init];
    SXView.frame = RECT(0, -568, 320, 568);
    SXView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:SXView];
}


- (void)screenView:(NSNotification *)sender
{
    
    NSString *b = sender.object;

    if (allDicArray.count != 0) {
        [UIView animateWithDuration:0.5 animations:^{
            SXView.frame = RECT(0, 94, 320, 300);
            [self.collectionView setContentOffset:CGPointMake(0, 100)];
        }];

            }else{
                [UIView animateWithDuration:0.5 animations:^{
                    SXView.frame = RECT(0, 94+150, 320, 300);
                }];

            }
    
    if ([b isEqualToString:@"0"]) {
        SXView.dataArray = sortbyArr;
        SXView.boolClass = @"1";
   
        [SXView.tableView  reloadData];
    }else if ([b isEqualToString:@"1"]){
        SXView.dataArray = classListArr;
        SXView.boolClass = @"2";
        [SXView.tableView  reloadData];
    }else{
        SXView.dataArray = taglistArr;
        SXView.boolClass = @"3";
        [SXView.tableView  reloadData];
    }
    
}

- (void)initHeardView
{
    UIScrollView *scorllView = [[UIScrollView alloc]init];
    scorllView.frame = RECT(0, 0, 320, 214);
    [self.view addSubview:scorllView];
    
    
    UIImageView * ImageView = [[UIImageView alloc]init];
    ImageView.frame = RECT(0, 0, 320, 150);
//    timeImageView.contentMode = UIViewContentModeScaleAspectFit;
    ImageView.image = [UIImage imageNamed:@"pbl"];
    [scorllView addSubview:ImageView];
}
#pragma mark - delegate Or datasource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NewBanCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BannerCell" forIndexPath:indexPath];
        
        return cell;
    }else{
    
    ListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FirstCell forIndexPath:indexPath];
        [cell setData:allDicArray[indexPath.row]];
    return cell;
    }
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
    if (indexPath.section == 0) {
        return CGSizeMake(CURRENT_CONTENT_WIDTH, 150);

    }
        return CGSizeMake(CURRENT_CONTENT_WIDTH/2-10, 230);
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section;
{
    if (section == 0) {
        return 1;
    }else{
        return allDicArray.count;
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"%ld",(long)indexPath.row);
    if (indexPath.section == 0) {
        
    }else{
        NSDictionary *dic = allDicArray[indexPath.row ];
        DetailsViewController *detailsVC = [[DetailsViewController alloc]init];
        detailsVC.positionID =[dic objectForKey:@"positionID"];
        [self.navigationController pushViewController:detailsVC animated:YES];
    }
    SXView.frame = RECT(0, -568, 320, 568);

    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section==0) {
        return  CGSizeMake(0, 0);
    }
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section==0) {
        return  CGSizeMake(0, 0);
    }
    return CGSizeMake(0, 30);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
        if (kind==UICollectionElementKindSectionFooter) {
            
                ReusableView *footer = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"footer" forIndexPath:indexPath];
            return  footer;

        }
        if (indexPath.section >0) {

            H_ReusableView *header = [collectionView  dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"1" forIndexPath:indexPath];
            return header;
            
        }

    
        return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [UIView animateWithDuration:.5 animations:^{
        SXView.frame = RECT(0, -568, 320, 568);
    }];
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
