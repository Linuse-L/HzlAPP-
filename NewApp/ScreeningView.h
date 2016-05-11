//
//  ScreeningView.h
//  NewApp
//
//  Created by L on 16/4/27.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^valueWithBlock) (NSString *value);

@interface ScreeningView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSString *boolClass;

@end
