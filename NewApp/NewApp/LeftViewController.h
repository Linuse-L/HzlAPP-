//
//  LeftViewController.h
//  NewApp
//
//  Created by L on 15/9/17.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"
#import "SVProgressHUD.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface LeftViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MFMailComposeViewControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>

@end
