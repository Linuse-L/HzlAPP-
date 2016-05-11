//
//  MyPickView.m
//  NewApp
//
//  Created by L on 15/10/10.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "MyPickView.h"

@implementation MyPickView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpToolBar];
        [self setPickeView];
        //月数组
        yuearr = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12"];
        
        //年数组
        nianarr = [NSMutableArray array];
        for (int i = 0; i<30; i++) {
            [nianarr addObject:[NSString stringWithFormat:@"%d", 2015+i]];
        }

    }
    return self;
}


- (void)setUpToolBar
{
    toolBar = [self setToolbarStyle];
    [self setToolbarWithPickViewFrame];
    [self addSubview:toolBar];

}
-(void)setToolbarWithPickViewFrame{
    toolBar.frame=CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, 40);
}
-(UIToolbar *)setToolbarStyle{
    UIToolbar *toolbar=[[UIToolbar alloc] init];
    toolbar.backgroundColor = Btn_Color;
    UIBarButtonItem *lefttem=[[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(remove)];
    UIBarButtonItem *centerSpace=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(doneClick)];
    toolbar.items=@[lefttem,centerSpace,right];
    return toolbar;
}
-(void)remove{
    
    [self removeFromSuperview];
}

- (void)setPickeView
{
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 190)];
    self.pickerView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.delegate = self;
    [self addSubview:self.pickerView];

}

- (void)doneClick
{
    
}

#pragma mark - PikerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)componen
{
    if (componen == 0) {
        return yuearr.count;
    }else{
        return nianarr.count;
    }
    return 10;
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return [yuearr objectAtIndex:row];
    }else {
        return [nianarr objectAtIndex:row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
//    if (component == 0) {
//        _Mothe.text = yuearr[row];
//    }else {
//        _Year.text  = nianarr[row];
//    }
}

//高度返回
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 40;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
