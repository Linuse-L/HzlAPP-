//
//  SneakNewTrackViewController.m
//  Dragon
//
//  Created by 黄权浩 on 15-1-15.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//

#import "SneakNewTrackViewController.h"
#import "StrakViewCell.h"
#import "newtableCell.h"
#import "NewtableheaderView.h"

@interface SneakNewTrackViewController ()

@end

@implementation SneakNewTrackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Order Track";
    //解析数据
    //首先取出所有的内容
    NSDictionary *namedata = _alldata;
    _stcktname.text    = [namedata objectForKey:@"delivery_name"];
    _stcktphone.text   = [namedata objectForKey:@"customers_telephone"];
    _stcktaddress.text = [namedata objectForKey:@"currency"];
    _stckttime.text    = [namedata objectForKey:@"orderTime"];
    _stckttotal.text   = [NSString stringWithFormat:@"%@",[namedata objectForKey:@"order_total"]];
    _stcktorder.text   = [_alldata objectForKey:@"orderID"];
    
    //然后是物流信息
    NSDictionary *trackingarr = self.trackArray;
    NSArray *trackingarr2 = [trackingarr objectForKey:@"data"];
    if (trackingarr2.count != 0) {
        _stcktstckting.text = [self.trackArray objectForKey:@"trackNumber"];
        //开始加载运流
        yunliu = trackingarr2;
        //取出最前边的2个
        //必须做判断
        if (yunliu.count==0) {
//            _stcktscrollView.hidden = YES;
        }else if (yunliu.count ==1 ) {
            NSDictionary *firsttrack = yunliu[0];
            _stcktfirstaddress.text  = [firsttrack objectForKey:@"context"];
            _stcktfirsttime.text     = [firsttrack objectForKey:@""];
        }else {
            NSDictionary *firsttrack = yunliu[0];
            NSDictionary *firsttime  = [firsttrack objectForKey:@"time"];
            _stcktfirstaddress.text  = [firsttrack objectForKey:@"context"];
            _stcktfirsttime.text     = [NSString stringWithFormat:@"%@ ", firsttime];
            NSDictionary *secondtrack= yunliu[1];
            NSDictionary *secondtime = [secondtrack objectForKey:@"time"];
            _stcktsecondaddress.text = [secondtrack objectForKey:@"context"];
            _stcktsecondtime.text    = [NSString stringWithFormat:@"%@", secondtime];
        }

    }else {
        
    }
    //做尾部信息(表视图)
    NSDictionary *item = [namedata objectForKey:@"item"];
    products = [item objectForKey:@"products"];
    _stcktbottomTableView.delegate = self;
    _stcktbottomTableView.dataSource = self;
    _stcktbottomTableView.rowHeight = 81;
    _stcktbottomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _stcktbottomTableView.frame = CGRectMake(0, 423, 320, 81*products.count);
    //滑动视图的滑动范围
    _stcktscrollView.contentSize = CGSizeMake(0, 568-81+81*(products.count-1));
    
}

#pragma mark - TABLEVIEWDELEGATE
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _stcktbottomTableView) {
        return products.count;
    }else if (tableView == newtable) {
        return yunliu.count;
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _stcktbottomTableView) {
        static NSString *cellIdentifier = @"cell";
        StrakViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"StrakViewCell" owner:self options:nil];
            cell = nib[0];
        }
        [cell setdic:_alldata];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else {
        static NSString *cellIdentifier = @"celll";
        newtableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"newtableCell" owner:self options:nil];
            cell = nib[0];
        }
        [cell setdic:yunliu[indexPath.row] setvalue:(int)indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

//表视图头部视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == newtable) {
        return 70;
    }else{
        return 0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return  [self headerView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == newtable) {
        //收回所有视图的位置
        _stcktscrollView.contentSize = CGSizeMake(0, 568-81+81*(products.count-1));
        _stcktbottomTableView.frame = CGRectMake(0, 423, 320, 81*products.count);
        _zhongbuView.frame = CGRectMake(0, 260, 320, 160);
        _sperline.frame = CGRectMake(0, 420, 320, 3);
        //并移除掉表视图
        [newtable removeFromSuperview];
        //移除掉按钮
        [newImgXZ removeFromSuperview];
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
//头部视图创建
- (UIView *)headerView
{
    NewtableheaderView *headerView = [[NewtableheaderView alloc] init];
    [headerView setdic:_stcktstckting.text];
    return headerView;
}

//点击创建视图
- (IBAction)clickTrack:(id)sender {
    if (yunliu.count>2) {
        //重定view视图跟下表视图位置(约束貌似做不到)
        _zhongbuView.frame = CGRectMake(0, 260, 320, 80*yunliu.count);
        _sperline.frame = CGRectMake(0, 260+80*yunliu.count, 320, 3);
        _stcktbottomTableView.frame = CGRectMake(0, 260+80*yunliu.count+3, 320, 81*products.count);
        _stcktscrollView.contentSize = CGSizeMake(0, 260+80*yunliu.count+81*products.count);
        //做出新的表视图
        newtable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 80*yunliu.count)];//物流表视图
        newtable.separatorStyle = UITableViewCellSeparatorStyleNone;
        newtable.rowHeight = 80;
        newtable.delegate = self;
        newtable.dataSource = self;
        [_zhongbuView addSubview:newtable];
        //新的旋转按钮
        newImgXZ = [[UIImageView alloc] initWithFrame:CGRectMake(287, 10, 22, 12)];
        newImgXZ.image = [UIImage imageNamed:@"sneak_query_bottom"];
        [_zhongbuView addSubview:newImgXZ];
    }
}
@end
