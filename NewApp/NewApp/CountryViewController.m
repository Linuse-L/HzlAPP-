//
//  CountryViewController.m
//  NewApp
//
//  Created by L on 15/9/24.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "CountryViewController.h"

@interface CountryViewController ()
{
    NSArray *countryArray;
    NSDictionary *allCountry;
    NSArray *popularArray;
    NSMutableArray *zimuArray;
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation CountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择国家";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT) style:UITableViewStylePlain];
    self.tableView.backgroundColor = nav_Color;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    zimuArray  = [NSMutableArray arrayWithCapacity:1];
    for (char i = 'A';i <= 'Z';i++) {
        NSString *zimu=[NSString stringWithFormat:@"%c",i];
        [zimuArray addObject:zimu];
    }

    // Do any additional setup after loading the view.
}

- (void)request
{
    [self showLoadingWithMaskType];
    [LORequestManger GET:getAllCountryID_Url success:^(id response) {
        NSLog(@"%@",response);
        
        NSString *status =[response objectForKey:@"status"];
        
        if ([status isEqualToString:@"OK"]) {
            [self dismiss];
            NSDictionary *data = [response objectForKey:@"data"];
            popularArray = [data objectForKey:@"popular"];
            allCountry = [data objectForKey:@"all"];
            [self.tableView reloadData];
        }else{
            [self dismissError:@"Please Log In!"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
        [self request];
    }];
}
#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  27;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return popularArray.count;
    }else{
        NSArray *Array = [allCountry objectForKey:zimuArray[section-1]];
            return Array.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor grayColor];

    if (indexPath.section == 0) {
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[popularArray[indexPath.row] objectForKey:@"countries_name"]];

    }else{
        NSArray *Array = [allCountry objectForKey:zimuArray[indexPath.section-1]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[Array[indexPath.row] objectForKey:@"countries_name"]];


    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    if (indexPath.section == 0) {
        NSDictionary *dic =popularArray[indexPath.row];
        [self.delegate selectCountry:dic];
    }else{
        NSArray *Array = [allCountry objectForKey:zimuArray[indexPath.section-1]];

        [self.delegate selectCountry:Array[indexPath.row]];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *l = [[UILabel alloc]init];
    l.frame = CGRectMake(15, 0, 320, 20);
    l.textColor = [UIColor blackColor];
    l.font = [UIFont systemFontOfSize:15];
    //    l.textAlignment = NSTextAlignmentCenter;
    [view addSubview:l];
    if (section == 0) {
        l.text = @"Popular Countries";
    }else{
        NSMutableArray *Array = [NSMutableArray arrayWithCapacity:1];
        for (char i = 'A'; i <= 'Z'; i++) {
            NSString *zimu=[NSString stringWithFormat:@"%c",i];
            [Array addObject:zimu];
        }
        
        l.text = [Array objectAtIndex:section-1];
        
    }
    return view;
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    
    NSMutableArray *array1 = [NSMutableArray arrayWithCapacity:1];
    NSString *str = @"#";
    [array1 addObject:str];
    for (char i = 'A'; i <= 'Z'; i++) {
        NSString *zimu=[NSString stringWithFormat:@"%c",i];
        [array1 addObject:zimu];
    }
    
    return array1;
}
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
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
