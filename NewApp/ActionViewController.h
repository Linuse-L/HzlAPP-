//
//  ActionViewController.h
//  NewApp
//
//  Created by L on 16/4/25.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "BaseVC.h"
#import "HomeBanderCell.h"
#import "ClassCell.h"
#import "NewRecCell.h"
@interface ActionViewController : BaseVC<UITableViewDelegate,UITableViewDataSource>
{
    NSDictionary *limitActivityDic;
    NSArray *otherActivity;
}
@end
