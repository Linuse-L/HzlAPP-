//
//  InfoViewController.h
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"
#import <sys/utsname.h>
#import "AdderssViewController.h"
#import "NewAddressViewController.h"
#import "NewPayViewController.h"
@interface InfoViewController : BaseVC<UITableViewDataSource,UITableViewDelegate,AddressDelegate,backInfoDelegate>

@property (nonatomic, strong) NSDictionary *infoDic;
@property (nonatomic, copy) NSString *orderid;
@property (nonatomic, copy) NSString *payurl;

@end
