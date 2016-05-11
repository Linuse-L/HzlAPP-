//
//  NewPayViewController.m
//  NewApp
//
//  Created by 黄权浩 on 15/10/13.
//  Copyright © 2015年 NewApp. All rights reserved.
//

#import "NewPayViewController.h"
#import "CompleteViewController.h"
#import "UMessage.h"

@interface NewPayViewController ()
{
    //判断字符
    NSString *paystrbool;
}
@end

@implementation NewPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Payment Info";
    _scr.frame = [UIScreen mainScreen].bounds;
    _scr.contentSize = CGSizeMake(0, 503);
    self.orderId.text = self.orderIdStr;
    self.totalprice.text = self.totalStr;
    UIView *keyview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    keyview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.2];
    //收回键盘的按钮
    UIButton *keydown = [UIButton buttonWithType:UIButtonTypeCustom];
    keydown.backgroundColor = [UIColor grayColor];
    keydown.frame = CGRectMake(250, 5, 60, 30);
    [keydown setTitle:@"Done" forState:UIControlStateNormal];
    [keydown setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    keydown.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [keydown addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [keyview addSubview:keydown];
    
    _fnmae.inputAccessoryView = keyview;
    _lname.inputAccessoryView = keyview;
    _cvv.inputAccessoryView   = keyview;
    _cartNumber.inputAccessoryView = keyview;
    
    if ([_isOrder isEqualToString:@"1"]) {
        NSString *delivery_name = [NSString stringWithFormat:@"%@",[_addressDic objectForKey:@"delivery_name"]];
        NSArray *array = [delivery_name componentsSeparatedByString:@" "];
        self.fnmae.text = [NSString stringWithFormat:@"%@",array[0]];
        self.lname.text =[NSString stringWithFormat:@"%@",array[1]];
    }else{
    self.fnmae.text = [NSString stringWithFormat:@"%@",[_addressDic objectForKey:@"entry_firstname"]];
    self.lname.text =[NSString stringWithFormat:@"%@",[_addressDic objectForKey:@"entry_lastname"]];
    }
    self.cartNumber.delegate = self;
    self.cvv.delegate = self;
    [self setPickeView];
    [self setHomeBtn];
    paystrbool = @"0";

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [CardIOUtilities preload];
}

- (void)setHomeBtn
{
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 12, 19);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_hlight"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back_hlight"] forState:UIControlStateHighlighted];
    [backButton addTarget:self action:@selector(returnHome) forControlEvents:UIControlEventTouchUpInside];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    self.navigationItem.leftBarButtonItem = barBtn;
}
- (void)returnHome
{
    //    [self.navigationController popToRootViewControllerAnimated:YES];
    //修正为警告框
    UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"" message:@"Payment not finished,are you sure you want to go back?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    
    [alerView show];
}
#pragma mark - AlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        paystrbool = @"2";
        
    }else {
        paystrbool = @"1";
        [self.delegate backVC:paystrbool];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setPickeView
{
    //月数组
    yuearr = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12"];
    
    //年数组
    nianarr = [NSMutableArray array];
    for (int i = 0; i<30; i++) {
        [nianarr addObject:[NSString stringWithFormat:@"%d", 2015+i]];
    }
    
    //弹出选择视图
    seleVw = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, 320, 220)];
    seleVw.backgroundColor = Btn_Color;
    [self.view addSubview:seleVw];
    
    //创建pikerview
    selecPickerV = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 320, 190)];
    selecPickerV.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    selecPickerV.showsSelectionIndicator = YES;
    selecPickerV.backgroundColor = [UIColor whiteColor];
    selecPickerV.delegate = self;
    [seleVw addSubview:selecPickerV];
    
    //弹出视图得1个按钮
    UIButton *doneBt = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneBt addTarget:self action:@selector(cancelBtn) forControlEvents:UIControlEventTouchUpInside];
    doneBt.frame = CGRectMake(260, 0, 60, 40);
    [doneBt setTitle:@"Done" forState:UIControlStateNormal];
    [seleVw addSubview:doneBt];
}
//收起弹出
- (void)cancelBtn
{
    
    [UIView animateWithDuration:0.3 animations:^{
        _scr.contentOffset = CGPointMake(0, 0);

        seleVw.frame = CGRectMake(0, self.view.bounds.size.height, 320, 220);
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self cancelBtn];
    return YES;
}

#pragma mark - textField delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return [textField resignFirstResponder];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.cartNumber == textField) {
        
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        //检测是否为纯数字
        if ([self isPureInt:string]) {
            //添加空格，每4位之后，4组之后不加空格，格式为xxxx xxxx xxxx xxxx xxxxxxxxxxxxxx
            if (textField.text.length % 5 == 4 && textField.text.length < 22) {
                textField.text = [NSString stringWithFormat:@"%@ ", textField.text];
            }
            //只要30位数字
            if ([toBeString length] >= 19)
            {
                toBeString = [toBeString substringToIndex:19];
                self.cartNumber.text = toBeString;
                [self.cartNumber resignFirstResponder];
                
                return NO;
            }
        }
        else if ([string isEqualToString:@""]) { // 删除字符
            if ((textField.text.length - 2) % 5 == 4 && textField.text.length < 22) {
                if (textField.text.length == 0) {
                    textField.text = [textField.text substringToIndex:textField.text.length];
                    return  YES;
                }
                textField.text = [textField.text substringToIndex:textField.text.length - 1];
            }
            return YES;
        }
        else{
            return NO;
        }
        return YES;
    }else if (self.cvv == textField)
    {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length > 3 && range.length!=1){
            textField.text = [toBeString substringToIndex:3];
            return NO;
            
        }else{
            return YES;
        }
        
    }
    return YES;
}
- (BOOL)isPureInt:(NSString *)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}
- (void)tap
{
    [self.cartNumber resignFirstResponder];
    [self.cvv resignFirstResponder];
    [self.fnmae resignFirstResponder];
    [self.lname resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)monthoryearBt:(id)sender {
    [self tap];
    [UIView animateWithDuration:0.3 animations:^{
        _scr.contentOffset = CGPointMake(0, 70);
        seleVw.frame = CGRectMake(0, self.view.bounds.size.height-220, 320, 220);
        
    }];
    if (month==nil|year == nil) {
        month = yuearr[0];
        year = nianarr[0];

    }
    NSString *str = [NSString stringWithFormat:@"%@/%@",month,year];
    
    [_MYBtn setTitle:str forState:UIControlStateNormal];
    [_MYBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

- (IBAction)submit:(id)sender {
    
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];

    NSString *strUrl = [self.cartNumber.text  stringByReplacingOccurrencesOfString:@" " withString:@""];

    if(self.cartNumber.text.length == 0){
        [self showWithStatus:@"Please Fill in the card number"];

    }else if(month == nil){
        [self showWithStatus:@"Please select a month"];
        
    }else if (year == nil){
        [self showWithStatus:@"Please select a year"];
        
    }else if(self.cvv.text.length == 0){
        
        [self showWithStatus:@"Please Fill in the CVV"];
    }else if (strUrl.length !=16){
        [self showWithStatus:@"Credit card error"];
    }
    else{
        [self showLoadingWithMaskType];
        
        [dic setObject:@"pay" forKey:@"act"];
        [dic setObject:strUrl forKey:@"cardNo"];
        [dic setObject:month forKey:@"expirationMonth"];
        [dic setObject:year forKey:@"expirationYear"];
        [dic setObject:self.cvv.text forKey:@"cvv"];
        
        [LORequestManger Card:self.payUrl params:dic URl:nil success:^(id response) {
            [self dismiss];
            
            NSLog(@"%@",response);
            NSDictionary *datatDic = [response objectForKey:@"data"];                NSString *payStatus = [NSString stringWithFormat:@"%@",[datatDic objectForKey:@"payStatus"]];
            if ([payStatus isEqualToString:@"false"]) {
                UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"Payment Failed" message:[datatDic objectForKey:@"getMsg"]delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alerView show];
                [UMessage addTag:@"未付款"
                        response:^(id responseObject, NSInteger remain, NSError *error) {
                            //add your codes
                        }];
                [UMessage removeTag:@"已付款"
                           response:^(id responseObject, NSInteger remain, NSError *error) {
                               //add your codes
                           }];
                return;
                
            }
            [UMessage addTag:@"已付款"
                    response:^(id responseObject, NSInteger remain, NSError *error) {
                        //add your codes
                    }];
            [UMessage removeTag:@"未付款"
                       response:^(id responseObject, NSInteger remain, NSError *error) {
                           //add your codes
                       }];
            CompleteViewController *completeVC = [[CompleteViewController alloc]init];
            [self.navigationController pushViewController:completeVC animated:YES];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
//            [self dismiss];
            
        }];
        
    }

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
    if (component == 0) {
        month = yuearr[row];
        [self setDate];
        
    }else {
        year  = nianarr[row];
        [self setDate];
        
    }
}
- (void)setDate
{
    NSString *str = [NSString stringWithFormat:@"%@/%@",month,year];
    [_MYBtn setTitle:str forState:UIControlStateNormal];
    [_MYBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}
- (IBAction)carIo:(id)sender {
    NSLog(@"扫描银行卡");
//    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
//    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self scanningEnabled:YES];
//    scanViewController.modalPresentationStyle = UIModalPresentationFormSheet;
//    [self presentViewController:scanViewController animated:YES completion:nil];
}
//#pragma mark - CardIODelegate
//- (void)userDidProvideCreditCardInfo:(CardIOCreditCardInfo *)info inPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
//    NSLog(@"Scan succeeded with info: %@", info);
//    // Do whatever needs to be done to deliver the purchased items.
//    [self dismissViewControllerAnimated:YES completion:nil];
//    
//    //    self.infoLabel.text = [NSString stringWithFormat:@"Received card info. Number: %@, expiry: %02lu/%lu, cvv: %@.", info.redactedCardNumber, (unsigned long)info.expiryMonth, (unsigned long)info.expiryYear, info.cvv];
//    NSString *str = [NSString stringWithFormat:@"%@", info.cardNumber];
//    
//    NSLog(@"%@",str);
//    self.cartNumber.text = str;
//    month = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryMonth];
//    year = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryYear];
//    [self setDate];
//    self.cvv.text = [NSString stringWithFormat:@"%@",info.cvv];
//}
//
//- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
//    NSLog(@"User cancelled scan");
//    [self dismissViewControllerAnimated:YES completion:nil];
//}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

@end
