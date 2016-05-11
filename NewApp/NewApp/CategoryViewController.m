//
//  CategoryViewController.m
//  NewApp
//
//  Created by L on 15/9/21.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "CategoryViewController.h"
#import "ProductViewController.h"
#import "FenleiErjiCell.h"
static NSString *cellIndentifier = @"photocell";

@interface CategoryViewController ()
{
    NSArray *Array;
    UIView * headView;
    UIView * leftView;
    NSArray *firstArray;
    NSArray *twoArray;
    UIView *line;
    BOOL isBooL;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Category";
    headView = [[UIView alloc]init];
    headView.frame = CGRectMake(80, 64, CURRENT_CONTENT_WIDTH -80, 40);
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    isBooL = YES;
    
    leftView = [[UIView alloc]init];
    leftView.frame = CGRectMake(0, 64, 80, CURRENT_CONTENT_HEIGHT);
    leftView.backgroundColor = [UIColor colorWithRed:242/255.0 green:243/255.0 blue:232/255.0 alpha:1];
    [self.view addSubview:leftView];

    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(80, 104, CURRENT_CONTENT_WIDTH -80, CURRENT_CONTENT_HEIGHT-104) collectionViewLayout:flowlayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FenleiErjiCell" bundle:nil]  forCellWithReuseIdentifier:cellIndentifier];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
}

- (void)request
{
    [self showLoadingWithMaskType];
    [LORequestManger GET:ClassList_Url success:^(id response) {
        NSLog(@"%@",response);
        [self dismiss];
       firstArray = [response objectForKey:@"data"];
        [self leftView:firstArray];
        [self requestClass:[firstArray[0] objectForKey:@"classid"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
        [self request];
    }];
}

- (void)requestClass:(NSString *)classid
{
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    [dic setObject:classid forKey:@"classid"];
    [LORequestManger POST:ClassList2_Url params:dic URl:dic success:^(id response) {
        NSLog(@"%@",response);
        NSString *status = [NSString stringWithFormat:@"%@",[response objectForKey:@"status"]];
        if ([status isEqualToString:@"OK"]) {
            twoArray = [response objectForKey:@"data"];
            NSArray *views = [headView subviews];
            for(UIView * view1 in views)
            {
                [view1 removeFromSuperview];
                
            }
            [self headView:twoArray];
            [self requestClass3:[twoArray[0] objectForKey:@"classid"]];

        }else{
            NSArray *views = [headView subviews];
            for(UIView * view1 in views)
            {
                [view1 removeFromSuperview];
                
            }

            [self dismissError:@""];
        }
       
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
    }];
}

- (void)requestClass3:(NSString *)classid
{
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    [dic setObject:classid forKey:@"classid"];
    [LORequestManger POST:ClassList3_Url params:dic URl:dic success:^(id response) {
        NSString *status = [response objectForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            [self dismiss];
            NSLog(@"%@",response);
            Array = [response objectForKey:@"data"];
            [self.collectionView reloadData];

        }else{
            Array = nil;
            [self showWithStatus:[response objectForKey:@"data"]];
            [self.collectionView reloadData];
        }
           } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
               [self dismiss];
        NSLog(@"%@",error);
    }];
}


- (void)leftView:(NSArray *)firstCategor
{
    for (int i = 0; i<firstCategor.count; i++) {
        NSDictionary *dataDic = firstCategor[i];
        UIButton *categorBt = [UIButton buttonWithType:UIButtonTypeCustom];
        categorBt.frame = CGRectMake(0, i*40, 80, 40);
        [categorBt addTarget:self action:@selector(leftVIewClick:) forControlEvents:UIControlEventTouchUpInside];
        [categorBt setTitle:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"name"]] forState:UIControlStateNormal];
        if (i == 0) {
            categorBt.backgroundColor = [UIColor whiteColor];
        }
        categorBt.tag = i+1;
        categorBt.titleLabel.font = [UIFont systemFontOfSize:10];
        [categorBt setTitleColor:[UIColor colorWithRed:89/255.0 green:88/255.0 blue:88/255.0 alpha:1] forState:UIControlStateNormal];
        [leftView addSubview:categorBt];
    }
}


- (void)headView:(NSArray *)headArray
{
    line = [[UIView alloc]init];
    line.frame = CGRectMake(5, 36, 70, 1);
    line.backgroundColor = Btn_Color;
    [headView addSubview:line];
    for (int i = 0; i<headArray.count; i++) {
        NSDictionary *dataDic = headArray[i];
        UIButton *categorBt = [UIButton buttonWithType:UIButtonTypeCustom];
        categorBt.frame = CGRectMake(5+i*80, 5, 70, 30);
        [categorBt addTarget:self action:@selector(headClick:) forControlEvents:UIControlEventTouchUpInside];
        [categorBt setTitle:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"name"]] forState:UIControlStateNormal];
        if (i == 0) {
            [categorBt setTitleColor:Btn_Color forState:UIControlStateNormal];
        }else{
            [categorBt setTitleColor:[UIColor colorWithRed:89/255.0 green:88/255.0 blue:88/255.0 alpha:1] forState:UIControlStateNormal];

        }
        categorBt.tag = i+10;
        categorBt.titleLabel.font = [UIFont systemFontOfSize:13];
        [headView addSubview:categorBt];
    }

}


- (void)next:(NSArray *)headArray
{
    for (int i = 0; i<headArray.count; i++) {
        NSDictionary *dataDic = headArray[i];
        UIButton *categorBt = (UIButton *)[self.view viewWithTag:i+10];
        [categorBt setTitle:[NSString stringWithFormat:@"%@",[dataDic objectForKey:@"name"]] forState:UIControlStateNormal];
        if (i == 0) {
            [categorBt setTitleColor:Btn_Color forState:UIControlStateNormal];
        }else{
            [categorBt setTitleColor:[UIColor colorWithRed:89/255.0 green:88/255.0 blue:88/255.0 alpha:1] forState:UIControlStateNormal];
            
        }
    }
    [UIView animateWithDuration:0.5 animations:^{
        line.frame = CGRectMake(5, 36, 70, 1);
    }];

    
}


- (void)leftVIewClick:(UIButton *)btn
{
    [self showLoadingWithMaskType];
    for (int i = 0; i < firstArray.count; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i+1];
        if (i+1==btn.tag) {
            button.backgroundColor = [UIColor whiteColor];

        }else{
            button.backgroundColor = [UIColor clearColor];

        }
    }
    
    NSDictionary *dic = firstArray[btn.tag - 1];
    [self requestClass:[dic objectForKey:@"classid"]];
    isBooL = NO;
}


- (void)headClick:(UIButton *)btn
{
    [self showLoadingWithMaskType];
    for (int i = 0; i < twoArray.count; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i+10];
        if (i+10==btn.tag) {
            [button setTitleColor:Btn_Color forState:UIControlStateNormal];
            
        }else{
            [button setTitleColor:[UIColor colorWithRed:89/255.0 green:88/255.0 blue:88/255.0 alpha:1] forState:UIControlStateNormal];
            
        }
    }
    NSDictionary *dic = twoArray[btn.tag -10];
    [self requestClass3:[dic objectForKey:@"classid"]];
    [UIView animateWithDuration:0.5 animations:^{
        line.frame = CGRectMake(5+(btn.tag - 10)*80, 36, 70, 1);
    }];
}
#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return Array.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FenleiErjiCell *cell = (FenleiErjiCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    [cell name:Array[indexPath.row]];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 100);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 2);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",(long)indexPath.row);
    NSDictionary *dic = Array[indexPath.row];
    ProductViewController *productVC = [[ProductViewController alloc]init];
    productVC.classid = [NSString stringWithFormat:@"%@",[dic objectForKey:@"classid"]];
    productVC.title = [NSString stringWithFormat:@"%@",[dic objectForKey:@"name"]];
    productVC.ishome = @"1";
    [self.navigationController pushViewController:productVC animated:YES];
}
// 定义上下cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4;
}

// 定义左右cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
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
