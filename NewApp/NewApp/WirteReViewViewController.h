//
//  WirteReViewViewController.h
//  NewApp
//
//  Created by L on 15/9/24.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"
#import "ZYRatingView.h"
@interface WirteReViewViewController : BaseVC<RatingViewDelegate,UITextViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong) NSString *product_id;
@end
