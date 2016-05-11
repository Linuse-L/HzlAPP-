//
//  CouponViewController.h
//  NewApp
//
//  Created by 黄权浩 on 15/12/11.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"
typedef void (^ReturnStringBlock)(NSString *boolstr);
typedef void (^ReturnPrice)(NSString *boolstr);

@interface CouponViewController : BaseVC<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) NSArray *couponArr;
@property (nonatomic, copy) ReturnStringBlock returnTextBlock;
@property (nonatomic, copy) ReturnPrice returnPrice;
- (void)returnText:(ReturnStringBlock)block;
- (void)returnPrice:(ReturnPrice)block;

@end
