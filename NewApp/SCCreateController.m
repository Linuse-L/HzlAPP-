//
//  SCCreateController.m
//  Dragon
//
//  Created by 黄权浩 on 15/8/17.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//

#import "SCCreateController.h"

@interface SCCreateController ()
{
@private
    NSArray *categor;
    NSArray *twodataarr;
    NSArray *threedataarr;
    UIImageView *topselectView;
    //遮罩视图。禁止点击
    UIView *zheView;
    UIImageView *line3;
    UIImageView *line;
    UIImageView *line2;
}
@end

@implementation SCCreateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"All Categories";
    [self.collectionView registerNib:[UINib nibWithNibName:@"FenleiErjiCell" bundle:nil]  forCellWithReuseIdentifier:@"photocell"];
    line3 = [[UIImageView alloc] initWithFrame:CGRectMake(119, 10, 1, 22)];
    line3.backgroundColor = [UIColor groupTableViewBackgroundColor];
    line3.hidden = YES;
    [_tapView addSubview:line3];
    
    line = [[UIImageView alloc] initWithFrame:CGRectMake(79, 10, 1, 22)];
    line.backgroundColor = [UIColor groupTableViewBackgroundColor];
    line.hidden = YES;
    [_tapView addSubview:line];
    
    line2 = [[UIImageView alloc] initWithFrame:CGRectMake(159, 10, 1.2, 22)];
    line2.backgroundColor = [UIColor groupTableViewBackgroundColor];
    line2.hidden = YES;
    [_tapView addSubview:line2];
    
    //遮罩视图
    zheView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    zheView.hidden = YES;
    zheView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:zheView];
    //初始化为数组下标为0
    threedataarr = [NSArray new];
    topselectView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 34, 80, 2)];
    topselectView.backgroundColor = PINKMENU_FONT_COLOR;
    [_tapView addSubview:topselectView];
  
}
- (void)request
{
    [self showLoading];
    [LORequestManger GET:ClassList_Url success:^(id response) {
        [self dismiss];
        //        NSLog(@"%@",response);
        _yijifenlei = [response objectForKey:@"data"];
//        [self.tableView reloadData];
        [self leftViewInit];
        //获取一级分类
        [self queryTwoProduct:_index];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
        [self request];
    }];
}

- (void)leftViewInit
{
    for (int i = 0; i<_yijifenlei.count; i++) {
        NSDictionary *dic = _yijifenlei[i];
        UIButton *categorBt = [UIButton buttonWithType:UIButtonTypeCustom];
        categorBt.frame = CGRectMake(0, i*40, 80, 40);
        [categorBt addTarget:self action:@selector(leftVIewClick:) forControlEvents:UIControlEventTouchUpInside];
        [categorBt setTitle:[dic objectForKey:@"name"] forState:UIControlStateNormal];
        if (i == _index) {
            categorBt.backgroundColor = [UIColor whiteColor];
        }
        categorBt.tag = i+1;
        categorBt.titleLabel.font = [UIFont systemFontOfSize:10];
        [categorBt setTitleColor:[UIColor colorWithRed:89/255.0 green:88/255.0 blue:88/255.0 alpha:1] forState:UIControlStateNormal];
        [_selectView addSubview:categorBt];
    }
}

//classid查询二级数据
- (void)queryTwoProduct:(NSInteger)index
{
    NSDictionary *dic = _yijifenlei[index];
    NSMutableDictionary * requestDic= [NSMutableDictionary dictionaryWithCapacity:1];
    NSDictionary * zenidDic= [[Singleton sharedInstance] zenidDic];
    [requestDic setObject:zenidDic forKey:@"zenid"];
    NSMutableDictionary* urlDic= [NSMutableDictionary dictionaryWithCapacity:1];
    [urlDic setObject:[dic objectForKey:@"classid"] forKey:@"classid"];
    [requestDic setValue:urlDic forKey:@"urlDic"];
    BOOL hasSub = [[dic objectForKey:@"hasSub"] boolValue];
    if (hasSub) {
        [LORequestManger POST:ClassList2_Url params:requestDic URl:urlDic success:^(id response) {
            NSLog(@"%@",response);
            twodataarr = [response objectForKey:@"data"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dismiss];
        
    }];
    }
}


#pragma mark - ASIDelegate

#pragma mark - CollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return threedataarr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"photocell";
    NSDictionary *dic = threedataarr[indexPath.row];
    FenleiErjiCell *cell = (FenleiErjiCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    if ([[dic objectForKey:@"image"]isKindOfClass:[NSString class]]) {
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"LoadingIma"]];
    }else {
        cell.headImg.image = [UIImage imageNamed:@"LoadingIma"];
    }
    cell.name.text = [dic objectForKey:@"name"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - ButtonMothed

- (void)leftVIewClick:(UIButton *)sender
{
    //开启视图控制
    zheView.hidden = NO;
    [UIView animateWithDuration:0.3 animations:^{
        topselectView.frame = CGRectMake(0, 34, topselectView.bounds.size.width, 2);
    }];
    NSLog(@"%ld", (long)sender.tag);
    //先黑后红
    for (int i = 0; i<_yijifenlei.count; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i+1];
        button.backgroundColor = [UIColor clearColor];
    }
    UIButton *button = (UIButton *)[self.view viewWithTag:sender.tag];
    button.backgroundColor = [UIColor whiteColor];
    [self queryTwoProduct:sender.tag-1];
}

- (void)topviewClick:(UIButton *)sender
{
    NSLog(@"%ld", (long)sender.tag);
    for (int i = 0; i<twodataarr.count; i++) {
        UIButton *button = (UIButton *)[self.view viewWithTag:i+100];
        [button setTitleColor:[UIColor colorWithRed:89/255.0 green:88/255.0 blue:88/255.0 alpha:1] forState:UIControlStateNormal];
    }
    UIButton *button = (UIButton *)[self.view viewWithTag:sender.tag];
    [button setTitleColor:PINKMENU_FONT_COLOR forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        topselectView.frame = CGRectMake(topselectView.bounds.size.width*(sender.tag-100), 34,topselectView.bounds.size.width, 2);
    }];
    [self queryThreeProduct:sender.tag-100];
}


//查询三级数据
- (void)queryThreeProduct:(NSInteger)index
{
    NSDictionary *dic = twodataarr[index];
//    [staticArea classID:[NSString stringWithFormat:@"%@",[dic objectForKey:@"classid"]]];
    NSMutableDictionary * requestDic= [NSMutableDictionary dictionaryWithCapacity:1];
    NSDictionary * zenidDic= [[Singleton sharedInstance]zenidDic];
    [requestDic setObject:zenidDic forKey:@"zenid"];
    NSDictionary* urlDic= @{@"classid":[dic objectForKey:@"classid"]};
    [requestDic setValue:urlDic forKey:@"urlDic"];
    BOOL hasSub = [[dic objectForKey:@"hasSub"] boolValue];
    if (hasSub) {
       
    }else {
        threedataarr  = [NSArray new];
        [_collectionView reloadData];
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
