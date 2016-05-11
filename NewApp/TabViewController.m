//
//  TabViewController.m
//  NewApp
//
//  Created by L on 16/4/25.
//  Copyright © 2016年 NewApp. All rights reserved.
//

#import "TabViewController.h"
#define SELECTED_VIEW_CONTROLLER_TAG 10202

@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _arrayViewcontrollers = [self getViewcontrollers];

    [self headerMenu];
    _tabbar = [[TabbarView alloc]init];
    _tabbar.frame = RECT(0, CURRENT_CONTENT_HEIGHT - 50, 320, 50);
    _tabbar.delegate  = self;
    _tabbar.tag = 1000;
    [self.view addSubview:_tabbar];
    [self touchBtnAtIndex:1];

    
    // Do any additional setup after loading the view.
}

#pragma mark - 设置下部菜单栏
- (void)headerMenu
{
    [UIView animateWithDuration:.5 animations:^{
        _tabbar.frame = RECT(0, CURRENT_CONTENT_HEIGHT - 50, 320, 50);

    }];

}

- (void)removeTabbar
{
    [UIView animateWithDuration:.5 animations:^{
        _tabbar.frame = RECT(0, CURRENT_CONTENT_HEIGHT+100, 320, 50);
        
    }];

}
-(void)touchBtnAtIndex:(NSInteger)index
{
 
    UIView* currentView = [self.view viewWithTag:SELECTED_VIEW_CONTROLLER_TAG];
    [currentView removeFromSuperview];
    
    
    //        NSDictionary* data = [_arrayViewcontrollers objectAtIndex:index-1];
    
    UIViewController *viewController = _arrayViewcontrollers[index-1];
    viewController.view.tag = SELECTED_VIEW_CONTROLLER_TAG;
    viewController.view.frame = CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view insertSubview:viewController.view belowSubview:_tabbar];
    
}
- (NSArray *)getViewcontrollers
{
    NSArray* tabBarItems = nil;
    HomeVC *homeVC = [[HomeVC alloc]init];
    UINavigationController *homeNaVC = [[UINavigationController alloc]initWithRootViewController:homeVC];

    ActionViewController *actionVC = [[ActionViewController alloc]init];
    UINavigationController *actionNaVC = [[UINavigationController alloc]initWithRootViewController:actionVC];
    
    LeftViewController *second = [[LeftViewController alloc]init];
    UINavigationController *secondNaVC = [[UINavigationController alloc]initWithRootViewController:second];

    tabBarItems = @[homeNaVC,actionNaVC,secondNaVC];
    return tabBarItems;
    
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
