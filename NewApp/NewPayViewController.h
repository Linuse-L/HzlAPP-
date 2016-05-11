//
//  NewPayViewController.h
//  NewApp
//
//  Created by 黄权浩 on 15/10/13.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"
//#import "CardIO.h"

@protocol backInfoDelegate

@optional
-(void)backVC:(NSString *)panduan;

@end
//typedef void (^ReturnStringBlock)(NSString *boolstr);

@interface NewPayViewController : BaseVC<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,backInfoDelegate>
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
//@property (nonatomic, copy) ReturnStringBlock returnTextBlock;
@property (weak, nonatomic) IBOutlet UIButton *MYBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scr;
@property (weak, nonatomic) IBOutlet UILabel *orderId;
@property (weak, nonatomic) IBOutlet UILabel *totalprice;
@property (weak, nonatomic) IBOutlet UITextField *fnmae;
@property (weak, nonatomic) IBOutlet UITextField *lname;
@property (weak, nonatomic) IBOutlet UITextField *cartNumber;
@property (weak, nonatomic) IBOutlet UITextField *cvv;
@property (nonatomic, strong) NSString *isOrder;
@property(copy,nonatomic)NSString * orderIdStr;
@property(copy,nonatomic)NSString *orderPanduan;
@property(copy,nonatomic)NSString * payUrl;
@property (nonatomic, strong) NSString *totalStr;
@property (nonatomic, strong) NSDictionary *addressDic;
@property (nonatomic, assign) id<backInfoDelegate>delegate;
- (IBAction)monthoryearBt:(id)sender;
- (IBAction)submit:(id)sender;
//- (void)returnText:(ReturnStringBlock)block;

@end
