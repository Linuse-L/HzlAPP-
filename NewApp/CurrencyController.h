//
//  CurrencyController.h
//  NewApp
//
//  Created by 黄权浩 on 15/10/19.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"

@interface CurrencyController : BaseVC<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tab;
}

@end
