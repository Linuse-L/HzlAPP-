//
//  HomeVC.h
//  NewApp
//
//  Created by L on 15/9/17.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "BaseVC.h"
#import "ReviewVC.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
#import "DetailsViewController.h"
#import "CategoryViewController.h"
#import "OrderViewController.h"
#import "ProductViewController.h"
#import "ClassCell.h"
#import "HomeBanderCell.h"
#import "CartViewController.h"
#import "SCCreateController.h"
#import "PositioningClass.h"
#import "OrderViewController.h"
#import "UMessage.h"
#import "HomeCategortyCell.h"
#import "TabbarView.h"
#import "ActionViewController.h"
#import "NewProductViewController.h"
#import "TabViewController.h"
@interface HomeVC : BaseVC<UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate>
{
    @private
    UIImageView *loadingImage;
    NSArray *_arrayViewcontrollers;
    //
    UIImageView *cartNumberImage;
    UILabel *cartNumberLb;
    
    UIView *moveView;
    UIButton *cartBtn;
    UILabel *numberCartLabel;
    CGFloat xDistance; //触摸点和中心点x方向移动的距离
    CGFloat yDistance; //触摸点和中心点y方向移动的距离
    
}

@end
