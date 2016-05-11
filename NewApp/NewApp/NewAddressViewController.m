//
//  NewAddressViewController.m
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "NewAddressViewController.h"
@interface NewAddressViewController ()
{
    UIScrollView *scrollView;
    NSString *countryDic;
}
@property (nonatomic, strong) UITextField *nameTF;
@property (nonatomic, strong) UITextField *phoneTF;
@property (nonatomic, strong) UITextField *addressTF;
@property (nonatomic, strong) UILabel * countryLabel;

@end

@implementation NewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"New Address";
    self.view.backgroundColor = nav_Color;
    
    scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT)];
    [self.view addSubview:scrollView];
    [self initUI];
    // Do any additional setup after loading the view.
}

-(void)initUI
{
    //    fieldArray =[NSMutableDictionary dictionaryWithCapacity:10];
    UIView *keyview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    keyview.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:.5];
    //收回键盘的按钮
    UIButton *keydown = [UIButton buttonWithType:UIButtonTypeCustom];
    keydown.backgroundColor = [UIColor clearColor];
    keydown.frame = CGRectMake(250, 5, 60, 30);
    [keydown setTitle:@"Done" forState:UIControlStateNormal];
    [keydown setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    keydown.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [keydown addTarget:self action:@selector(bgButt:) forControlEvents:UIControlEventTouchUpInside];
    
    [keyview addSubview:keydown];
    
    
    UIImageView * backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 505)];
    backimage.image=[UIImage imageNamed:@"addressline"];
    [scrollView addSubview:backimage];
    scrollView.backgroundColor = [UIColor groupTableViewBackgroundColor];
#pragma mark - firstName
    FirstName =[[UITextField alloc]initWithFrame:CGRectMake(20, 10, 280.0, 35)];
    FirstName.inputAccessoryView = keyview;
    [FirstName setPlaceholder:@"First Name"];
    FirstName.clearButtonMode = UITextFieldViewModeWhileEditing;
    [FirstName setReturnKeyType:UIReturnKeyNext];
    FirstName.borderStyle = UITextBorderStyleNone;
    [FirstName addTarget:self action:@selector(FirstName:) forControlEvents:UIControlEventEditingDidEndOnExit];
    FirstName.font=[UIFont systemFontOfSize:16];
    FirstName.delegate=self;
    FirstName.backgroundColor=[UIColor clearColor];
    [scrollView addSubview:FirstName];
    
    //    [fieldArray setObject:FirstName forKey:@"FirstName"];
#pragma mark - lastName
    LastNmae =[[UITextField alloc]initWithFrame:CGRectMake(20, 10+45, 280.0, 35)];
    [LastNmae setPlaceholder:@"Last Name"];
    LastNmae.inputAccessoryView = keyview;
    LastNmae.clearButtonMode = UITextFieldViewModeWhileEditing;
    [LastNmae setReturnKeyType:UIReturnKeyNext];
    LastNmae.borderStyle = UITextBorderStyleNone;
    [LastNmae addTarget:self action:@selector(FirstName:) forControlEvents:UIControlEventEditingDidEndOnExit];
    LastNmae.font=[UIFont systemFontOfSize:16];
    LastNmae.delegate=self;
    LastNmae.backgroundColor=[UIColor clearColor];
    [scrollView addSubview:LastNmae];
    //    [fieldArray setObject:LastNmae forKey:@"LastNmae"];
#pragma mark - genderLabel
    
    gender = [[UILabel alloc]initWithFrame:CGRectMake(5, 0, 180, 35)];
    gender.text = @"Choose Gender";
    //    gender.inputAccessoryView = keyview;
    gender.font = [UIFont systemFontOfSize:14];
    //    gender.textColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:197/255.0 alpha:1];
    gender.textAlignment = NSTextAlignmentLeft;
    //    [scrollView addSubview:gender];
    //    [fieldArray setObject:gender forKey:@"gender"];
#pragma mark - Email
    
    Email =[[UITextField alloc]initWithFrame:CGRectMake(20, 10+45*2+10, 280.0, 35)];
    Email.inputAccessoryView = keyview;
    [Email setPlaceholder:@"example@example.com"];
    [Email setReturnKeyType:UIReturnKeyNext];
    Email.clearButtonMode = UITextFieldViewModeWhileEditing;
    Email.borderStyle = UITextBorderStyleNone;
    [Email addTarget:self action:@selector(FirstName:) forControlEvents:UIControlEventEditingDidEndOnExit];
    Email.font=[UIFont systemFontOfSize:16];
    Email.delegate=self;
    Email.backgroundColor=[UIColor clearColor];
    //    [scrollView addSubview:Email];
    //    [fieldArray setObject:Email forKey:@"Email"];
    NSDictionary * email= [NSUserDefaultsDic objectForKey:@"loginOK"];
    Email.userInteractionEnabled=NO;
    Email.text=[email objectForKey:@"useremail"];
#pragma mark - mobilePhone
    
    Mobilephone =[[UITextField alloc]initWithFrame:CGRectMake(20, 10+45*2+10, 280.0, 35)];
    Mobilephone.inputAccessoryView = keyview;
    [Mobilephone setReturnKeyType:UIReturnKeyNext];
    [Mobilephone addTarget:self action:@selector(FirstName:) forControlEvents:UIControlEventEditingDidEndOnExit];
    Mobilephone.placeholder = @"Telephone";
    Mobilephone.keyboardType = UIKeyboardTypePhonePad;
    Mobilephone.borderStyle = UITextBorderStyleNone;
    Mobilephone.font=[UIFont systemFontOfSize:16];
    Mobilephone.delegate=self;
    Mobilephone.clearButtonMode = UITextFieldViewModeWhileEditing;
    Mobilephone.backgroundColor=[UIColor clearColor];
    [scrollView addSubview:Mobilephone];
    //    [fieldArray setObject:Mobilephone forKey:@"Mobilephone"];
#pragma mark - addressTextField
    
    Address =[[UITextField alloc]initWithFrame:CGRectMake(20, 10+45*3+5, 280.0, 35)];
    [Address setReturnKeyType:UIReturnKeyNext];
    [Address addTarget:self action:@selector(FirstName:) forControlEvents:UIControlEventEditingDidEndOnExit];
    Address.font=[UIFont systemFontOfSize:16];
    Address.delegate=self;
    Address.clearButtonMode = UITextFieldViewModeWhileEditing;
    Address.borderStyle = UITextBorderStyleNone;
    Address.placeholder = @"Address";
    Address.backgroundColor=[UIColor clearColor];
    Address.inputAccessoryView = keyview;
    [scrollView addSubview:Address];
    //    [fieldArray setObject:Address forKey:@"Address"];
    
#pragma mark - cityTextFiled
    
    City =[[UITextField alloc]initWithFrame:CGRectMake(20, 10+45*4+5, 280.0, 35)];
    City.inputAccessoryView = keyview;
    [City setReturnKeyType:UIReturnKeyNext];
    [City addTarget:self action:@selector(FirstName:) forControlEvents:UIControlEventEditingDidEndOnExit];
    City.font=[UIFont systemFontOfSize:16];
    City.delegate=self;
    City.borderStyle = UITextBorderStyleNone;
    City.placeholder = @"City";
    City.backgroundColor=[UIColor clearColor];
    [scrollView addSubview:City];
    //    [fieldArray setObject:City forKey:@"City"];
    
#pragma mark - provinceTextField
    
    Province =[[UITextField alloc]initWithFrame:CGRectMake(20, 10+45*5+2, 280.0, 35)];
    [Province setReturnKeyType:UIReturnKeyNext];
    Province.inputAccessoryView = keyview;
    [Province addTarget:self action:@selector(FirstName:) forControlEvents:UIControlEventEditingDidEndOnExit];
    Province.font=[UIFont systemFontOfSize:16];
    Province.delegate=self;
    Province.clearButtonMode = UITextFieldViewModeWhileEditing;
    Province.borderStyle = UITextBorderStyleNone;
    Province.placeholder = @"Province";
    Province.backgroundColor=[UIColor clearColor];
    [scrollView addSubview:Province];
    //    [fieldArray setObject:Province forKey:@"Province"];
    
#pragma mark - countryTextField
    
    countryTextField =[[UITextField alloc]initWithFrame:CGRectMake(20, 10+45*6+1, 280.0, 35)];
    countryTextField.inputAccessoryView = keyview;
    [countryTextField setReturnKeyType:UIReturnKeyNext];
    [countryTextField addTarget:self action:@selector(FirstName:) forControlEvents:UIControlEventEditingDidEndOnExit];
    countryTextField.font=[UIFont systemFontOfSize:16];
    countryTextField.delegate=self;
    countryTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    countryTextField.borderStyle = UITextBorderStyleNone;
    //    countryTextField.text = @"United States";
    countryTextField.backgroundColor=[UIColor clearColor];
    countryTextField.userInteractionEnabled=NO;
    [scrollView addSubview:countryTextField];
    
    CountryRegion =[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 180, 35)];
    
    //    [scrollView addSubview:CountryRegion];
    CountryRegion.textAlignment = NSTextAlignmentLeft;

    UIButton * CountryRegionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CountryRegionButton.frame=CGRectMake(20, 10+45*6+1, 280.0, 35);
    [CountryRegionButton addTarget:self action:@selector(selectCountryBtn) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:CountryRegionButton];
    
    CountryRegionButton.layer.borderWidth = 1;
    CountryRegionButton.layer.cornerRadius = 5;
    CountryRegionButton.layer.borderColor = (__bridge CGColorRef)([UIColor whiteColor]);
    [CountryRegionButton addSubview:CountryRegion];
    
#pragma mark - zipPostalCodeTextField
    ZipPostalcode =[[UITextField alloc]initWithFrame:CGRectMake(20, 10+45*7, 280.0, 35)];
    ZipPostalcode.inputAccessoryView = keyview;
    [ZipPostalcode setReturnKeyType:UIReturnKeyNext];
    ZipPostalcode.tag=1010;
    [ZipPostalcode addTarget:self action:@selector(FirstName:) forControlEvents:UIControlEventEditingDidEndOnExit];
    ZipPostalcode.font=[UIFont systemFontOfSize:16];
    ZipPostalcode.delegate=self;
    ZipPostalcode.clearButtonMode = UITextFieldViewModeWhileEditing;
    ZipPostalcode.placeholder = @"ZipPostalcode";
    //    ZipPostalcode.keyboardType = UIKeyboardTypePhonePad;
    ZipPostalcode.borderStyle = UITextBorderStyleNone;
    ZipPostalcode.backgroundColor=[UIColor clearColor];
    [scrollView addSubview:ZipPostalcode];
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];//serect@2x
    [loginBtn setFrame:CGRectMake(15,10+45*9, 290, 40)];
    [loginBtn setTitle:@"Submit" forState:UIControlStateNormal];
    loginBtn.backgroundColor = Btn_Color;
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(downAddress) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:loginBtn];
    
    scrollView.contentSize = CGSizeMake(0, 10+45*9+40);
    
        if(_isEdit)
        {
    
            NSLog(@"%@", self.addressDic);
            countryTextField.text = [self.addressDic objectForKey:@"entry_country_name"];
            FirstName.text=[self.addressDic objectForKey:@"entry_firstname"];
            LastNmae.text=[self.addressDic objectForKey:@"entry_lastname"];
            gender.text=[self.addressDic objectForKey:@"entry_gender"];
            countryDic = [self.addressDic objectForKey:@"entry_country_id"];
            Mobilephone.text=[self.addressDic objectForKey:@"entry_phone"];
            Telephone.text=[self.addressDic objectForKey:@"entry_phone"];
            Address.text=[self.addressDic objectForKey:@"entry_street_address"];
            City.text=[self.addressDic objectForKey:@"entry_city"];
            Province.text=[self.addressDic objectForKey:@"entry_state"];
            //        CountryRegion.text=entry_country;
            ZipPostalcode.text=[self.addressDic objectForKey:@"entry_postcode"];
    
    
        }else{
            CountryRegion.text = @"Country";

        }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)downAddress
{
    
    
    //    NSString *genderstr = gender.text;
    NSString *FirstNamestr = FirstName.text;
    NSString *LastNmaestr = LastNmae.text;
    NSString *Addressstr = Address.text;
    NSString *ZipPostalcodestr = ZipPostalcode.text;
    NSString *Citystr = City.text;
    NSString *Provincestr = Province.text;
    NSString *country = countryTextField.text;
    NSString *phone =[NSString stringWithFormat:@"%@",Mobilephone.text];
    NSLog(@"%@", CountryRegion.text);
    //    NSString *CountryRegionstr = countryTextField.text;
    
    if ( (0 == [FirstNamestr length]) | (0 == [LastNmaestr length])| 0 == [Addressstr length]| 0 == [ZipPostalcodestr length]| 0 == [Citystr length]| 0 == [Provincestr length] | [CountryRegion.text isEqualToString: @"Country"] | phone.length == 0 |country.length == 0)
    {
        [self showWithStatus:@"Incomplete address information"];
        return;
    }
    
    
    [self addtocart];
    [self bgButt:nil];
    
}
#pragma mark - 回收键盘

- (void)bgButt:(UIButton *)btn
{
    [FirstName resignFirstResponder];
    [LastNmae resignFirstResponder];
    [Mobilephone resignFirstResponder];
    [gender resignFirstResponder];
    [Email resignFirstResponder];
    [Telephone resignFirstResponder];
    [Address resignFirstResponder];
    [City resignFirstResponder];
    [Province resignFirstResponder];
    [countryTextField resignFirstResponder];
    [ZipPostalcode resignFirstResponder];
    [UIView animateWithDuration:.5 animations:^{
        [scrollView setContentOffset:CGPointMake(0, -64) animated:YES];
    }];
}

- (void)deleteBtn:(UIButton *)btn
{
    NSLog(@"删除地址");
}
- (void)save
{
    NSLog(@"保存地址");
}

- (void)selectCountryBtn
{
    NSLog(@"选择国家");
    CountryViewController *countryVC  = [[CountryViewController alloc]init];
    countryVC.delegate = self;
    [self.navigationController pushViewController:countryVC animated:YES];
}

-(void)selectCountry:(NSDictionary *)dic
{
    CountryRegion.text = @"";
    countryTextField.text = [dic objectForKey:@"countries_name"];
    countryDic = [dic objectForKey:@"countries_id"];

}
-(void)FirstName:(UITextField *)textField
{
    CGPoint abc = CGPointMake(0, 0);
    if(textField == FirstName)
    {
        
        [LastNmae becomeFirstResponder];
    }else if(textField == LastNmae)
    {
        
        [Email becomeFirstResponder];
    }else if (textField == Email)
    {
        [Mobilephone becomeFirstResponder];
        
    }else if(textField == Mobilephone)
    {
        
        [Telephone becomeFirstResponder];
        //        abc = CGPointMake(0,10+45*2);
        
    }else if(textField == Telephone)
    {
        
        [Address becomeFirstResponder];
        abc = CGPointMake(0,10+45*3);
        
    }else if(textField == Address)
    {
        
        [City becomeFirstResponder];
        abc = CGPointMake(0,10+45*4);
        
    }else if(textField == City)
    {
        [Province becomeFirstResponder];
        abc = CGPointMake(0,10+45*5);
    }else if(textField == Province)
    {
        [ZipPostalcode becomeFirstResponder];
        abc = CGPointMake(0,30+45*6);
    } else if(textField == ZipPostalcode){
        abc = CGPointMake(0,0);
        [ZipPostalcode resignFirstResponder];
    }
    [scrollView setContentOffset:abc animated:YES];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    CGPoint abc;
//    scrollView.contentSize=CGSizeMake(0, 700);
    
    if(textField == Address)
    {
        
        abc = CGPointMake(0,10+45*1);
        [scrollView setContentOffset:abc animated:YES];
        
        
    }else if(textField == City)
    {
        abc = CGPointMake(0,10+45*2);
        [scrollView setContentOffset:abc animated:YES];
    }else if(textField == Province)
    {
        abc = CGPointMake(0,10+45*3);
        [scrollView setContentOffset:abc animated:YES];
    }
    else if(textField == ZipPostalcode)
    {
        if (CURRENT_CONTENT_HEIGHT == 480) {
            abc = CGPointMake(0,30+45*5);
        }else{
            abc = CGPointMake(0,20+45*4);
        }
        [scrollView setContentOffset:abc animated:YES];
    }
}

-(void)addtocart
{
    [self showLoadingWithMaskType];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
    [dic setValue:MyZenID forKey:@"zenid"];
    //    DLog(@"%@",addressDic);
    [dic setValue:gender.text forKey:@"entry_gender"];
    [dic setValue:FirstName.text forKey:@"entry_firstname"];
    [dic setValue:LastNmae.text forKey:@"entry_lastname"];
    [dic setValue:Address.text forKey:@"entry_street_address"];
    [dic setValue:ZipPostalcode.text forKey:@"entry_postcode"];
    [dic setValue:City.text forKey:@"entry_city"];
    [dic setValue:Province.text forKey:@"entry_state"];
    //    NSLog(@"%@",city_id);
    //    NSLog(@"%@",guojiaID);
    [dic setValue:Mobilephone.text forKey:@"entry_phone"];
    [dic setValue:countryDic forKey:@"entry_country_id"];
    NSLog(@"%@",dic);
    
    
    if (_isEdit) {
        NSLog(@"修改地址");
        [dic setObject:[_addressDic objectForKey:@"address_book_id"] forKey:@"address_book_id"];
        [LORequestManger POST:editAddress_Url params:dic URl:nil success:^(id response) {
            NSLog(@"%@",response);
            NSString *status =[response objectForKey:@"status"];
            
            if ([status isEqualToString:@"OK"])  {
                [self dismissSuccess:@"success"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self dismissError:@"error"];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [self dismiss];
        }];
 
        
        
    }else{
    //添加用户地址\
    
    [LORequestManger POST:addUserAddress_Url params:dic URl:nil success:^(id response) {
        NSLog(@"%@",response);
        NSString *status =[response objectForKey:@"status"];
        
        if ([status isEqualToString:@"OK"]) {
            [self dismissSuccess:nil];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self dismissError:@"error"];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [self dismiss];
    }];
    }
    
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
