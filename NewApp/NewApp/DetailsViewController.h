//
//  DetailsViewController.h
//  NewApp
//
//  Created by L on 15/9/17.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"
#import "LAlertView.h"
#import "MJPhotoBrowser.h"
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "GiftTalkSheetView.h"
#import <Social/Social.h>
@interface DetailsViewController : BaseVC<UITableViewDelegate,UITableViewDataSource,FBSDKSharingDelegate,UIScrollViewDelegate>
{
    NSArray  *titleArray;
    NSArray  *ImageArray;
    NSString *shareOK;
    BOOL      hascolor;
    BOOL      hassize;
    NSArray *dataArray;
    UIView *moveView;
    UIButton *cartBtn;
    UILabel *numberCartLabel;
    BOOL isMoreInfo;
    UIView *otherBtnView;
    UIButton * moreBtn;
    UIPageControl * page ;
    CGFloat xDistance; //触摸点和中心点x方向移动的距离
    CGFloat yDistance; //触摸点和中心点y方向移动的距离
    
}
@property (nonatomic, strong) NSString *positionID;
@property (nonatomic, strong) NSString *ttt;
@end
