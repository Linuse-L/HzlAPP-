//
//  TabViewController.h
//  NewApp
//
//  Created by L on 16/4/25.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabbarView.h"
#import "ActionViewController.h"
#import "HomeVC.h"
#import "CartViewController.h"
#import "LeftViewController.h"
@interface TabViewController : UIViewController<My_tabbarDelegete>
{
    NSArray *_arrayViewcontrollers;
    

}
@property (nonatomic, strong)TabbarView *tabbar;
- (void)removeTabbar;
- (void)headerMenu;
@end
