//
//  LeftViewController.m
//  NewApp
//
//  Created by L on 15/9/17.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "LeftViewController.h"
#import "LoginCell.h"
#import "OrderViewController.h"
#import "LoginViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "WebViewController.h"
#import "LandingCell.h"
#import "MyCollectionViewController.h"
#import "Harpy.h"
#import "CurrencyController.h"
#import "AboutUsController.h"
#import "SettingViewController.h"
#import "ReturnViewController.h"
#import "ProvacyController.h"
#import "PrivcyViewController.h"
#import "Return2ViewController.h"
#import "ShippingPolicyViewController.h"
#import "LeftCouponViewController.h"

@interface LeftViewController ()
{
    NSArray *textArray;
    NSArray *textArray2;
    NSArray *textArray3;
    NSString *fbemail;
}
@property (nonatomic, strong) UITableView  *tableView;
@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ME";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, CURRENT_CONTENT_WIDTH, CURRENT_CONTENT_HEIGHT-50) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
//    textArray = @[@"Order History",@"Wish List",@"Wallet",@"Currency"];
//    textArray2 = @[@"Invite Friends",@"Contact Us",@"About Us",@"Version Update",@"Settings"];
    textArray  = @[@"Order",@"Wish List",@"Coupon",@"Change Currency"];
    textArray2 = @[@"Contact us",@"About us"];
    textArray3 = @[@"Return Policy", @"Pricvacy Policy", @"Shipping Policy", @"Western Union", @"Money Gram", @"Sign Out"];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(signOut) name:@"signOut" object:nil];

    // Do any additional setup aftng the view.
}
#pragma mark - tableView dataSource delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 4;
    }else if (section == 2) {
        return 2;
    }else{
        return 6;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.section == 0) {
        NSDictionary *dic = [NSUserDefaultsDic dictionaryForKey:@"loginOK"];
        if (dic) {
            static NSString *str = @"cell1";
            LandingCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil) {
                cell = [[LandingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            }
            [cell returnText:^{
                //弹出相册或者拍照;
                NSLog(@"相机");
                UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera",@"Photo album", nil];
                [sheet showInView:self.view];
            }];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell setData:dic];
            return cell;
        }else{
            static NSString *str = @"cell2";
            LoginCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
            if (cell == nil) {
                cell = [[LoginCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            btn.frame = RECT(CURRENT_CONTENT_WIDTH - 170, 15, 100, 30);
            [btn setTitle:@"Sign In" forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.layer.borderWidth = .5;
            btn.layer.cornerRadius = 2;
            [btn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btn];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (indexPath.section == 1) {
        static NSString *str = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.textLabel.text = textArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.imageView.image = [UIImage imageNamed:textArray[indexPath.row]];
        return cell;
    }else if (indexPath.section == 2) {
        static NSString *str = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.textLabel.text = textArray2[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.imageView.image = [UIImage imageNamed:textArray2[indexPath.row]];
        return cell;
    }else {
        static NSString *str = @"cell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        cell.textLabel.text = textArray3[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.imageView.image = [UIImage imageNamed:textArray3[indexPath.row]];
        return cell;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
    
    NSLog(@"%ld",(long)buttonIndex);
    if (buttonIndex == 0) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            //            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
        //        sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //图片库
        //        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:^{

        }];
    }else if (buttonIndex == 1){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:picker animated:YES completion:^{

            }];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Access to photos error"
                                  message:@""
                                  delegate:nil
                                  cancelButtonTitle:@"OK!"
                                  otherButtonTitles:nil];
            [alert show];
        }
        
    }
    
    
}


- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    NSString *path_sandox = NSHomeDirectory();
    //创建一个存储plist文件的路径
    NSString *newPath = [path_sandox stringByAppendingPathComponent:@"/Documents/pic.plist"];
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSData *_data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *image64 = [_data base64Encoding];
    [arr addObject:image64];
    //写入plist文件
    if ([arr writeToFile:newPath atomically:YES]) {
        NSLog(@"写入成功");
        NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
        [d removeObjectForKey:@"image"];
        [d setValue:image64 forKey:@"image"];
        [d synchronize];
    };
    NSLog(@"%@",editingInfo);
    [self.tableView reloadData];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSDictionary *dic = [NSUserDefaultsDic dictionaryForKey:@"loginOK"];

        if (dic) {
            return 60*iphone_HIGHT;
        }
        return 60*iphone_HIGHT;
    }else{
        return 44*iphone_HIGHT;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }else if (section == 2) {
        return 10;
    }else if (section == 3) {
        return 10;
    }else {
        return 0;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = [NSUserDefaultsDic dictionaryForKey:@"loginOK"];
    
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            if (dic) {
                [[AppDelegate getAppDelegate].tabbarVC removeTabbar];
                OrderViewController *orderVC = [[OrderViewController alloc]init];
                orderVC.isTabbar = YES;
                [self.navigationController pushViewController:orderVC animated:YES];
            }else{
                NSLog(@"登陆");
                [SVProgressHUD showErrorWithStatus:@"Please login"];
                
            }
        }else if (indexPath.row == 1){
            if (dic) {
                [[AppDelegate getAppDelegate].tabbarVC removeTabbar];
                [MobClick event:@"wishlist"];
                MyCollectionViewController *myCollectionVC = [[MyCollectionViewController alloc]init];
                [self.navigationController pushViewController:myCollectionVC animated:YES];
            }else{
                NSLog(@"登陆");
                [SVProgressHUD showErrorWithStatus:@"Please login"];
            }
        }else if (indexPath.row == 2){
//            [SVProgressHUD showErrorWithStatus:@"Function is not open"];
            //优惠券展示页面稍后做
            [[AppDelegate getAppDelegate].tabbarVC removeTabbar];
            LeftCouponViewController *left = [[LeftCouponViewController alloc] init];
            [self.navigationController pushViewController:left animated:YES];
        }else if (indexPath.row == 3){
            //            //货币转换
            [[AppDelegate getAppDelegate].tabbarVC removeTabbar];
            [MobClick event:@"currency"];
            CurrencyController *myCollectionVC = [[CurrencyController alloc]init];
            [self.navigationController pushViewController:myCollectionVC animated:YES];
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            [MobClick event:@"contactus"];
            [self sendEmail];
        }else if (indexPath.row == 1) {
            [[AppDelegate getAppDelegate].tabbarVC removeTabbar];
            [MobClick event:@"aboutus"];
            AboutUsController *about = [[AboutUsController alloc] init];
            [self.navigationController pushViewController:about animated:YES];
        }else if (indexPath.row == 2) {
            
        }else if (indexPath.row == 3) {
            [MobClick event:@"versionup"];
            [Harpy checkVersion];
        }else if (indexPath.row == 4) {
            [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
            }];
            SettingViewController *about = [[SettingViewController alloc] init];
            [about backsomething:^{
                [self signOut];
            }];
            [self.navigationController pushViewController:about animated:YES];
        }
    }else if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            ProvacyController *p = [[ProvacyController alloc] init];
            [self.navigationController pushViewController:p animated:YES];
        }else if (indexPath.row == 1) {
            PrivcyViewController *p = [[PrivcyViewController alloc] init];
            
            [self.navigationController pushViewController:p animated:YES];
        }else if (indexPath.row == 2) {
            ShippingPolicyViewController *p = [[ShippingPolicyViewController alloc] init];
            [self.navigationController pushViewController:p animated:YES];
        }else if (indexPath.row == 3) {
            Return2ViewController *r = [[Return2ViewController alloc] init];
            [self.navigationController pushViewController:r animated:YES];
        }else if (indexPath.row == 4) {
            ReturnViewController *r = [[ReturnViewController alloc] init];
            r.viewtitle = @"MoneyGram";
            r.imageReturn.image = [UIImage imageNamed:@"Money.png"];
            [self.navigationController pushViewController:r animated:YES];
        }else if (indexPath.row == 5) {
            [self signOut];
        }
        if (indexPath.row == 5) {
            
        }else{
            [[AppDelegate getAppDelegate].tabbarVC removeTabbar];
        }
    }
}

- (void)login:(UIButton *)btn
{
    [[AppDelegate getAppDelegate].tabbarVC removeTabbar];
    LoginViewController *loginVC = [[LoginViewController alloc]init];
    NSLog(@"登陆");
    loginVC.isLogin = YES;
    loginVC.tags = 11;
    [self.navigationController pushViewController:loginVC animated:NO];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tableView reloadData];
}
- (void)signOut
{

    NSDictionary *dic = [NSUserDefaultsDic dictionaryForKey:@"loginOK"];
    if (dic) {
        if ([[dic objectForKey:@"fb"]isEqualToString:@"1"]) {
                FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
                if (![FBSDKAccessToken currentAccessToken]) {
                    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];

                    [LORequestManger GET:Signout_Url success:^(id response) {
                        NSLog(@"%@",response);
                        [SVProgressHUD dismissWithSuccess:@"Login out"];
                        [NSUserDefaultsDic removeObjectForKey:@"loginOK"];
                        [NSUserDefaultsDic synchronize];
                        [self.tableView reloadData];
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        //失败重走
                    }];
                } else {
                    [loginManager logOut];
                    UIAlertController *alertController = [AlertControllerUtility alertControllerWithTitle:@"Logout"
                                                                                                  message:@"Logout"];
                    [self presentViewController:alertController animated:YES completion:nil];
                    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];

                    [LORequestManger GET:Signout_Url success:^(id response) {
                        NSLog(@"%@",response);
                        [SVProgressHUD dismissWithSuccess:@"Login out"];
                        [NSUserDefaultsDic removeObjectForKey:@"loginOK"];
                        [NSUserDefaultsDic synchronize];
                        [self.tableView reloadData];
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        //失败重走
                    }];
                }
        }else {
            [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];

            [LORequestManger GET:Signout_Url success:^(id response) {
                NSLog(@"%@",response);
                [SVProgressHUD dismissWithSuccess:@"Login out"];
                [NSUserDefaultsDic removeObjectForKey:@"loginOK"];
                [NSUserDefaultsDic synchronize];
                [self.tableView reloadData];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //失败重走
            }];
        }
    }else {
       
    }
    
}

- (void)sendEmail
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    if (!mailClass) {
        return;
    }
    if (![mailClass canSendMail]) {
        return;
    }
    [self displayMailPicker];
}

//调出邮件发送窗口
- (void)displayMailPicker
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    [mailPicker setSubject: @"Feedback from an iOS user!"];
    //添加收件人
    NSString *email1 = [AppDelegate getAppDelegate].email;
    NSString *email;
    if (email1) {
        email =[AppDelegate getAppDelegate].email;
    }else{
        email = @"";
    }
    NSArray *toRecipients = [NSArray arrayWithObject: email];
//    NSString *emailBody = [NSString stringWithFormat:@"user_email:%@\n app_version:%@ \n device_model:iPhone \n os_version:%@", @"dsada", @"dawdaw", @"fgawqw"];
//    [mailPicker setMessageBody:emailBody isHTML:YES];
    [mailPicker setToRecipients: toRecipients];
    
    [self presentViewController:mailPicker animated:YES completion:^{
        
    }];
}

#pragma mark - 实现 MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    //关闭邮件发送窗口
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
            msg = @"用户取消编辑邮件";
            break;
        case MFMailComposeResultSaved:
            msg = @"用户成功保存邮件";
            break;
        case MFMailComposeResultSent:
            msg = @"用户点击发送，将邮件放到队列中，还没发送";
            break;
        case MFMailComposeResultFailed:
            msg = @"用户试图保存或者发送邮件失败";
            break;
        default:
            msg = @"";
            break;
    }
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

@end
