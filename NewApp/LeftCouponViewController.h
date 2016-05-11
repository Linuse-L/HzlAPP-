//
//  LeftCouponViewController.h
//  NewApp
//
//  Created by 黄权浩 on 15/12/14.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"

@interface LeftCouponViewController : BaseVC<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
