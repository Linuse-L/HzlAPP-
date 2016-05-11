//
//  ScreeningView.m
//  NewApp
//
//  Created by L on 16/4/27.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "ScreeningView.h"

@implementation ScreeningView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTabbleView];
    }
    return self;
}

- (void)setTabbleView
{
    self.tableView = [[UITableView alloc]initWithFrame:RECT(0, 0, 320, 300) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
                      
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([_boolClass isEqualToString:@"3"]) {
        return _dataArray.count;
        
    }else {
        return 1;
        
    }//    UITableViewCell *thisCell = [tableVie
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *array = [_dataArray[section] objectForKey:@"sonList"];
    
    if ([_boolClass isEqualToString:@"3"]) {
        return array.count;

    }else {
        return _dataArray.count;

    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"strcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strCell];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
    }
    if ([_boolClass isEqualToString:@"1"]) {
        NSDictionary *dic = _dataArray[indexPath.row];

        cell.textLabel.text = [dic objectForKey:@"showName"];

    }else if ([_boolClass isEqualToString:@"2"]){
        NSDictionary *dic = _dataArray[indexPath.row];

        cell.textLabel.text = [dic objectForKey:@"className"];

    }else if ([_boolClass isEqualToString:@"3"]){
        NSDictionary *dataDic = _dataArray[indexPath.section];
        NSArray *a = [dataDic objectForKey:@"sonList"];
        NSDictionary *allDic = a[indexPath.row];
        cell.textLabel.text = [allDic objectForKey:@"tag_name"];

    }
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.frame = RECT(0, -568, 320, 568);
    NSString *valueStr;
    if ([_boolClass isEqualToString:@"1"]) {
        NSDictionary *dic = _dataArray[indexPath.row];

        valueStr = [dic objectForKey:@"sendVal"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"againRequest" object:valueStr];

        
    }else if ([_boolClass isEqualToString:@"2"]){
        NSDictionary *dic = _dataArray[indexPath.row];

        valueStr = [dic objectForKey:@"apiLink"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"categoryRequest" object:valueStr];

        
    }else if ([_boolClass isEqualToString:@"3"]){
        NSDictionary *dataDic = _dataArray[indexPath.section];
        NSArray *a = [dataDic objectForKey:@"sonList"];
        NSDictionary *allDic = a[indexPath.row];

        valueStr = [allDic objectForKey:@"tag_id"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"filterRequest" object:valueStr];

        
    }
//    UITableViewCell *thisCell = [tableView cellForRowAtIndexPath: indexPath];
//    thisCell.textLabel.textColor = [UIColor grayColor];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel * orderLabel = [[UILabel alloc]init];
    orderLabel.text = [_dataArray [section] objectForKey:@"name"];
    orderLabel.frame = CGRectMake(10, 0, 200, 20);
    orderLabel.textAlignment = NSTextAlignmentLeft;
    orderLabel.font = [UIFont systemFontOfSize:13];
    orderLabel.textColor = [UIColor blackColor];
    [view addSubview:orderLabel];
 
    
    if ([_boolClass isEqualToString:@"3"]) {
        return view;
        
    }else {
        return nil;
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([_boolClass isEqualToString:@"3"]) {
        return 20;
        
    }else {
        return 0;
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
