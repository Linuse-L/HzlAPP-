//
//  PayViewController.h
//  NewApp
//
//  Created by L on 15/9/23.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"
//#import "CardIO.h"
#import "LAlertView.h"
#import "CompleteViewController.h"
typedef void (^ReturnStringBlock)(NSString *boolstr);

@interface PayViewController : BaseVC<LAlertViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    UIView *seleVw;
    //    NSMutableDictionary *_cardInfo;
    //数组月
    NSArray *yuearr;
    //数组年
    NSMutableArray *nianarr;
    //我的选择视图
    UIPickerView *selecPickerV;
    NSString *month;
    NSString *year;
}
//判断传值
@property (nonatomic, copy) ReturnStringBlock returnTextBlock;
@property(copy,nonatomic)NSString * OrderId;
@property(copy,nonatomic)NSString *orderPanduan;
@property(copy,nonatomic)NSString * payUrl;

- (void)returnText:(ReturnStringBlock)block;

@end
