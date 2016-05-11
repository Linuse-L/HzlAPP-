//
//  Singleton.m
//  NewApp
//
//  Created by L on 15/9/28.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "Singleton.h"
#import "CartViewController.h"

@implementation Singleton
static BOOL BGBFyesorno;
static  Singleton *sharedCLDelegate = nil;
+(Singleton *)sharedInstance{
    @synchronized(self) {
        if(sharedCLDelegate == nil) {
            sharedCLDelegate = [[Singleton alloc]init];; //   assignment   not   done   here
        }
    }
    return sharedCLDelegate;
}

- (NSMutableDictionary *)zenidDic
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:1];
    [dic setValue:MyZenID forKey:@"zenid"];
    printf("ddd");
    return dic;
}

- (void)getZenid
{
    NSString *str = MyZenID;
    if ([str isKindOfClass:[NSString class]]) {
        [self UserLogin];
    }else {
        [LORequestManger GET:getZenID_Url success:^(id response) {
            NSLog(@"%@",response);
            NSArray *dataArray = [response objectForKey:@"data"];
            NSString *zendID = [dataArray objectAtIndex:0];
            [[NSUserDefaults standardUserDefaults] setObject:zendID forKey:@"ZenIDdata"];
            [self UserLogin];
            [[NSUserDefaults standardUserDefaults]synchronize];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *deviceTokenString = [defaults objectForKey:@"deviceTokenString"];
            [defaults synchronize];
            NSMutableDictionary *dic = [[Singleton sharedInstance] zenidDic];
            [dic setValue:deviceTokenString forKey:@"token"];
            [LORequestManger POST:sendToken_url params:dic URl:nil success:^(id response) {
                NSString *status =[response objectForKey:@"status"];
                if ([status isEqualToString:@"OK"]) {
                    NSLog(@"%@",response);
                }else{
                    
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            
            [UIView animateWithDuration:2 animations:^{
                //SHOUHUI
            } completion:^(BOOL finished) {
                //REMOVE
            }];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [self getZenid];//重新请求
        }];
    }
    
    

}

- (void)UserLogin
{
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];

    NSDictionary *dic = [NSUserDefaultsDic valueForKey:@"loginOK"];
    NSMutableDictionary *resquestDic = [NSMutableDictionary dictionaryWithCapacity:1];
    [resquestDic setValue:MyZenID forKey:@"zenid"];
    [resquestDic setValue:[dic objectForKey:@"useremail"]forKey:@"useremail"];
    [resquestDic setValue:[dic objectForKey:@"password"]forKey:@"password"];
    
    if (dic) {
        [LORequestManger POST:Login_Url params:resquestDic URl:nil success:^(id response) {
            NSLog(@"%@",response);
//            [SVProgressHUD dismiss];
            NSString *status = [response objectForKey:@"status"];
            if ([status isEqualToString:@"OK"]) {
                
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self UserLogin];
        }];
    }

}

- (void)getNoPayOrder
{
    
}

//判断应用是否在前台或者后台
+ (void)ISBGBF:(BOOL)yesorno
{
    BGBFyesorno = yesorno;
}

+ (BOOL)BGBFyesorno
{
    return BGBFyesorno;
}

//购物车跳转
- (void)gotoappCart
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"You have goods in the shopping cart did not pay yet." delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [alert show];
}

- (void)
alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        CartViewController *cart = [[CartViewController alloc] init];
        [[AppDelegate getAppDelegate].naVC pushViewController:cart animated:NO];

    }
}
@end
