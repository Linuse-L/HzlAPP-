//
//  NewAddressViewController.h
//  NewApp
//
//  Created by L on 15/9/22.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"
#import "CountryViewController.h"

@interface NewAddressViewController : BaseVC<UITextFieldDelegate ,selectCountryDelegate>
{
    UITextField * FirstName;
    UITextField * LastNmae;
    UILabel * gender;
    UITextField * Email;
    UITextField * Mobilephone;
    UITextField * Telephone;
    UITextField * Address;
    UITextField * City;
    UITextField * Province;
    UILabel * CountryRegion;
    UITextField * ZipPostalcode;
    UITextField * countryTextField;
    
}
@property (nonatomic, strong) NSDictionary *addressDic;
@property (nonatomic, assign) BOOL isEdit;
@end
