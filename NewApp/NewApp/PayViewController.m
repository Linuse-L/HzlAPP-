//
//  PayViewController.m
//  NewApp
//
//  Created by L on 15/9/23.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "PayViewController.h"
//#import "CardIO.h"

@interface PayViewController ()
{
    UIScrollView *scrollView;
    //判断字符
    NSString *paystrbool;
}
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *cardTF;
@property (nonatomic, strong) UITextField *dateTF;
@property (nonatomic, strong) UITextField *cvvTF;
@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MobClick event:@"visapay"];
    self.title = @"pay";
    scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.frame;
    [self.view addSubview:scrollView];
    UIImageView *imageView = [[UIImageView alloc]init];
    paystrbool = @"0";
    imageView.frame = CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, 240*iphone_HIGHT);
    
    imageView.image = [UIImage imageNamed:@"cardImage"];
    [scrollView addSubview:imageView];
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    saveBtn.frame = CGRectMake(10, imageView.frame.size.height +40, CURRENT_CONTENT_WIDTH - 20, 40);
    saveBtn.backgroundColor = Btn_Color;
    saveBtn.layer.cornerRadius = 3;
    [saveBtn setTitle:@"Pay Now" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(pay) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:saveBtn];
    
    self.nameTF = [[UITextField alloc]initWithFrame:CGRectMake(80*iphone_WIDTH, 240*iphone_HIGHT - 170*iphone_HIGHT, 200*iphone_WIDTH, 30*iphone_HIGHT)];
    self.nameTF.placeholder = @"Enter the name";
    self.nameTF.borderStyle  = UITextBorderStyleNone;
    self.nameTF.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:self.nameTF];

    self.cardTF = [[UITextField alloc]initWithFrame:CGRectMake(self.nameTF.frame.origin.x, self.nameTF.frame.origin.y+45*iphone_HIGHT,200*iphone_WIDTH, 30*iphone_HIGHT)];
    self.cardTF.placeholder = @"Credit card number";
    self.cardTF.borderStyle  = UITextBorderStyleNone;
    self.cardTF.keyboardType = UIKeyboardTypePhonePad;
    self.cardTF.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:self.cardTF];
    
    
    
    self.dateTF = [[UITextField alloc]initWithFrame:CGRectMake(10, self.nameTF.frame.origin.y+90*iphone_HIGHT,CURRENT_CONTENT_WIDTH-20, 30*iphone_HIGHT)];
    self.dateTF.placeholder = @"To choose time";
    self.dateTF.borderStyle  = UITextBorderStyleNone;
    self.dateTF.backgroundColor = [UIColor clearColor];
    self.dateTF.userInteractionEnabled= NO;
    [scrollView addSubview:self.dateTF];
    
    UIButton *dataBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    dataBtn.frame = CGRectMake(10, self.nameTF.frame.origin.y+90*iphone_HIGHT,CURRENT_CONTENT_WIDTH-20, 30*iphone_HIGHT);
    dataBtn.backgroundColor = [UIColor clearColor];
    [dataBtn addTarget:self action:@selector(pickeView:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:dataBtn];
    
    self.cvvTF = [[UITextField alloc]initWithFrame:CGRectMake(10, self.nameTF.frame.origin.y+140*iphone_HIGHT,CURRENT_CONTENT_WIDTH-20, 30*iphone_HIGHT)];
    self.cvvTF.placeholder = @"CVV";
    self.cvvTF.borderStyle  = UITextBorderStyleNone;
    self.cvvTF.backgroundColor = [UIColor clearColor];
    self.cvvTF.keyboardType = UIKeyboardTypePhonePad;
    [scrollView addSubview:self.cvvTF];
    
    self.nameTF.font = [UIFont systemFontOfSize:12];
    self.cardTF.font = [UIFont systemFontOfSize:12];
    self.cvvTF.font = [UIFont systemFontOfSize:12];
    self.dateTF.font = [UIFont systemFontOfSize:12];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removekeyboard)];
    [self.view addGestureRecognizer:tap];
    self.nameTF.delegate = self;
    self.cardTF.delegate = self;
    self.cvvTF.delegate = self;
    
    UIButton *cameraBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cameraBtn.frame = CGRectMake(CURRENT_CONTENT_WIDTH-60, self.nameTF.frame.origin.y+40*iphone_HIGHT,50*iphone_WIDTH, 30*iphone_HIGHT);
    [cameraBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cameraBtn addTarget:self action:@selector(camerBtn) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:cameraBtn];
    [self setHomeBtn];
    
    [self setPickeView];
    
   
    // Do any additional setup after loading the view.
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
        seleVw.frame = CGRectMake(0, self.view.bounds.size.height, 320, 220);
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.returnTextBlock != nil) {
        self.returnTextBlock(paystrbool);
    }
}

- (void)pickeView:(UIButton *)btn
{

    [self removekeyboard];
    [UIView animateWithDuration:0.3 animations:^{
        seleVw.frame = CGRectMake(0, self.view.bounds.size.height-220, 320, 220);
    }];

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
- (void)setRightBar
{
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 12, 19);
//    [backButton setBackgroundImage:[UIImage imageNamed:@"back_hlight"] forState:UIControlStateNormal];
//    [backButton setBackgroundImage:[UIImage imageNamed:@"back_hlight"] forState:UIControlStateHighlighted];
//    [backButton addTarget:self action:@selector(returnHome) forControlEvents:UIControlEventTouchUpInside];
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
- (void)alertView:(LAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        paystrbool = @"2";

    }else {
        paystrbool = @"1";
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)returnText:(ReturnStringBlock)block
{
    self.returnTextBlock = block;
}

- (void)removekeyboard
{
    [self.nameTF resignFirstResponder];
    [self.cardTF resignFirstResponder];
    [self.dateTF resignFirstResponder];
    [self.cvvTF resignFirstResponder];
}

- (void)pay
{
    NSLog(@"支付");
    [self showLoadingWithMaskType];
    NSMutableDictionary *dic = [[Singleton sharedInstance]zenidDic];
    if ([self.nameTF.text isEqualToString:@""]) {
        [self showWithStatus:@"Fill in the name"];
    }else if(self.dateTF.text.length == 0){
        if (year == nil){
        [self showWithStatus:@"Please select a year"];

    }else if (month == nil){
        [self showWithStatus:@"Please select a month"];

    }}
    else{
    
    [dic setObject:@"pay" forKey:@"act"];
    [dic setObject:self.cardTF.text forKey:@"cardNo"];
    [dic setObject:month forKey:@"expirationYear"];
    [dic setObject:year forKey:@"expirationMonth"];
    [dic setObject:self.cvvTF.text forKey:@"cvv"];

    [LORequestManger Card:self.payUrl params:dic URl:nil success:^(id response) {
        [self dismiss];

        NSLog(@"%@",response);
        NSDictionary *datatDic = [response objectForKey:@"data"];
        NSString *payStatus = [NSString stringWithFormat:@"%@",[datatDic objectForKey:@"payStatus"]];
            if ([payStatus isEqualToString:@"false"]) {
                UIAlertView *alerView = [[UIAlertView alloc]initWithTitle:@"Payment Failed" message:[datatDic objectForKey:@"getMsg"]delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alerView show];
                [MobClick event:@"payerr"];
                return;
            }
            [MobClick event:@"paysu"];
            CompleteViewController *completeVC = [[CompleteViewController alloc]init];
            [self.navigationController pushViewController:completeVC animated:YES];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"Network error" duration:10];
    }];
        
    }
}

- (void)camerBtn
{
    NSLog(@"扫描银行卡");
//    CardIOPaymentViewController *scanViewController = [[CardIOPaymentViewController alloc] initWithPaymentDelegate:self];
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
//    self.cardTF.text = str;
//    self.dateTF.text = [NSString stringWithFormat:@"%lu/%lu",(unsigned long)info.expiryMonth,(unsigned long)info.expiryYear];
//    month = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryMonth];
//    year = [NSString stringWithFormat:@"%lu",(unsigned long)info.expiryYear];
//    self.cvvTF.text = [NSString stringWithFormat:@"%@",info.cvv];
//}
//
//- (void)userDidCancelPaymentViewController:(CardIOPaymentViewController *)paymentViewController {
//    NSLog(@"User cancelled scan");
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    self.dateTF.text = [NSString stringWithFormat:@"%@/%@",month,year];
}



#pragma mark textField delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self cancelBtn];
}

 - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.cardTF == textField) {
        NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if (toBeString.length > 16 && range.length!=1){
            textField.text = [toBeString substringToIndex:16];
            return NO;
            
        }else{
        return YES;
        }
    }else if (self.cvvTF == textField)
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
