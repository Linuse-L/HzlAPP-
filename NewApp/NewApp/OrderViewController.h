//
//  OrderViewController.h
//  NewApp
//
//  Created by L on 15/9/21.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"

@interface OrderViewController : BaseVC<UITableViewDelegate,UITableViewDataSource>
{
    NSString *payOrderID;
    NSString *payUrl;
    BOOL cellcanClick;
}

@end
