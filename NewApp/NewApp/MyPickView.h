//
//  MyPickView.h
//  NewApp
//
//  Created by L on 15/10/10.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPickView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIToolbar *toolBar;
    //数组月
    NSArray *yuearr;
    //数组年
    NSMutableArray *nianarr;
}
@property(nonatomic,strong)UIPickerView *pickerView;

@end
