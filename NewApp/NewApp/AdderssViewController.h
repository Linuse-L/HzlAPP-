//
//  AdderssViewController.h
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"
@protocol AddressDelegate <NSObject>

@optional
-(void)addressDic:(NSDictionary *)dic;

@end

@interface AdderssViewController : BaseVC<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSArray *addressArray;
@property (nonatomic, assign) id<AddressDelegate>delegate;

@end
