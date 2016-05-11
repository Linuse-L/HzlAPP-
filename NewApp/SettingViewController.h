//
//  SettingViewController.h
//  NewApp
//
//  Created by 黄权浩 on 15/10/21.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"

typedef void (^ReturnStringBlock)();

@interface SettingViewController : BaseVC<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy)ReturnStringBlock returnTextBlock;
- (void)backsomething:(ReturnStringBlock)block;

@end
