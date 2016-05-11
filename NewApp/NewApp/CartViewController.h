//
//  CartViewController.h
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"

@interface CartViewController : BaseVC<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, assign) BOOL isShare;
@property (nonatomic, strong) NSString *tobbar;
@end
