//
//  SneakNewTrackViewController.h
//  Dragon
//
//  Created by 黄权浩 on 15-1-15.
//  Copyright (c) 2015年 ZHAO. All rights reserved.
//

#import "BaseVC.h"

@interface SneakNewTrackViewController : BaseVC<UITableViewDataSource, UITableViewDelegate>
{
@private
    NSArray *yunliu;
    NSArray *products;
    //创建中部表视图
    UITableView *newtable;
    //新的旋转按钮
    UIImageView *newImgXZ;
}
//整个背景滑动视图
@property (weak, nonatomic) IBOutlet UIScrollView *stcktscrollView;

//上部视图
//订单号
@property (weak, nonatomic) IBOutlet UILabel *stcktorder;
//总价
@property (weak, nonatomic) IBOutlet UILabel *stckttotal;
//时间
@property (weak, nonatomic) IBOutlet UILabel *stckttime;
//姓名
@property (weak, nonatomic) IBOutlet UILabel *stcktname;
//电话
@property (weak, nonatomic) IBOutlet UILabel *stcktphone;
//地址
@property (weak, nonatomic) IBOutlet UILabel *stcktaddress;

//中部视图
//中部视图
@property (weak, nonatomic) IBOutlet UIView *zhongbuView;
//灰色线条
@property (weak, nonatomic) IBOutlet UIImageView *sperline;

//运单号码
@property (weak, nonatomic) IBOutlet UILabel *stcktstckting;
//第一地址跟第一时间
@property (weak, nonatomic) IBOutlet UILabel *stcktfirstaddress;
@property (weak, nonatomic) IBOutlet UILabel *stcktfirsttime;
//地二地址跟第二时间
@property (weak, nonatomic) IBOutlet UILabel *stcktsecondaddress;
@property (weak, nonatomic) IBOutlet UILabel *stcktsecondtime;

//尾部视图
//尾部表视图直接显示产品
@property (weak, nonatomic) IBOutlet UITableView *stcktbottomTableView;

//点击改变布局
- (IBAction)clickTrack:(id)sender;


//其他
//接收数据
@property (nonatomic, strong)NSDictionary *alldata;
@property (nonatomic, strong)NSDictionary *trackArray;
//订单号
@property (nonatomic, strong)NSString *order;
@end
