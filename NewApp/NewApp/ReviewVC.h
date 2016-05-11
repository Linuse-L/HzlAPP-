//
//  ReviewVC.h
//  NewApp
//
//  Created by L on 15/9/21.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"

@interface ReviewVC : BaseVC<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSString *positionID;
@property (nonatomic, strong) NSString *aaa;
@end
