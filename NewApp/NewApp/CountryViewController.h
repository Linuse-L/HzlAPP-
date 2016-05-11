//
//  CountryViewController.h
//  NewApp
//
//  Created by L on 15/9/24.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"
@protocol selectCountryDelegate

@optional
-(void)selectCountry:(NSDictionary *)dic;

@end
@interface CountryViewController : BaseVC<UITableViewDataSource,UITableViewDelegate,selectCountryDelegate>

@property (nonatomic, assign) id<selectCountryDelegate>delegate;
@end
