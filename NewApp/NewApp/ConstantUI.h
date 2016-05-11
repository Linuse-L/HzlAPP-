//
//  ConstantUI.h
//  forum
//
//  Created by cyx on 12-7-26.
//  Copyright (c) 2012年 cdeledu. All rights reserved.
//

#ifndef forum_ConstantUI_h
#define forum_ConstantUI_h

/********************************* 设备信息 *********************************/
//当前设备系统版本号
#define CURRENT_VERSION                                 [UIDevice currentDevice].systemVersion
#define CURRENT_VERSION_SEVEN                           ([CURRENT_VERSION intValue]>=7)
#define IS_IOS7 ([UIDevice currentDevice].systemVersion.intValue/7 == 1)

//当前设备属性
#define CURRENT_DEVICE_HEIGHT                           [[UIScreen mainScreen] bounds].size.height
#define CURRENT_DEVICE_WIDTH                            [[UIScreen mainScreen] bounds].size.width
//当前内容属性
#define CURRENT_CONTENT_HEIGHT                          (CURRENT_VERSION_SEVEN?CURRENT_DEVICE_HEIGHT:CURRENT_DEVICE_HEIGHT-20)
#define CURRENT_CONTENT_WIDTH                           CURRENT_DEVICE_WIDTH

/********************************* 导航栏UI设置 *********************************/
#define NAVIGATIONBAR_HEIGHT                            (CURRENT_VERSION_SEVEN?64.0:44.0)              //导航高
#define NAVIGATIONBAR_WIDTH                             CURRENT_CONTENT_WIDTH                //导航宽

#define NAVIGATION_ORY (NAVIGATIONBAR_HEIGHT==64?20:0)

#define NAVIGATIONBAR_BUTTON_WIDTH              48              //标准按钮高
#define NAVIGATIONBAR_BUTTON_HEIGHT             28              //标准按钮宽
#define NAVIGATIONBAR_INTERVAL                  10              //按钮左间隔
                  //导航按钮字体样式

#define NAVIGATIONBAR_TITLE_WIDTH               200                                             //导航标题宽
#define NAVIGATIONBAR_TITLE_FRONT         [UIFont boldSystemFontOfSize:18]                      //导航标题字体样式

//#define TABBAR_HEIGHT                           44              //选项卡高度
//
////导航栏UI设置
//#define NAVIGATIONBAR_HEIGHT 55.5
//#define NAVIGATIONBAR_BUTTON_WIDTH 48
//#define NAVIGATIONBAR_INTERVAL 10
//#define NAVIGATIONBAR_TITLE_WIDTH 300
//#define NAVIGATIONBAR_FRONT_SIZE 18
//#define NAVIGATIONBAR_BUTTON_HEIGHT 28
//友盟
#define mob_key                                @"5729523ce0f55a6255000156"
//简单的以AlertView显示提示信息
#define mAlertView(title, msg) \
UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil \
cancelButtonTitle:@"Confirm" \
otherButtonTitles:nil]; \
[alert show];\
//底部MENU
#define MENU_HEIGHT 51
#define MENU_ICON_HEIGHT 38
#define MENU_FONT_COLOR  @"9b1c2d"
#define PINKMENU_FONT_COLOR  [UIColor colorWithRed:213/255.0 green:31/255.0 blue:25/255.0 alpha:1]
//#define PINKMENU_FONT_COLOR         [UIColor blackColor]

//主页
#define HOME_CUE_CELL_INTERVAL  15
#define HOME_CELL_FONT_COLOR  @"8d2c4c"
#define HOME_TITLE_FONT_COLOR @"860000"
#define HOME_CELL_HEIGHT 40
#define HOME_CELL_FONT_SIZE 15.0
#define HOME_SCECHEDULE_CELL_FONT_SIZE 13.0
#define HOME_TITLE_FONT_SIZE 12.0

//日历
#define CALANDER_COLUM_COLOR   @"fdb8cf"
#define CALANDER_TITLE_COLOR   @"1d1d1d"
#define userBack_COLOR   @"ebebeb"

#define CALANDER_WEEK_COLOR    @"e12c3a"
#define CALANDER_RIGHT_COLOR   @"941526"
#define CALANDER_CELL_B_COLOR  @"fdd0d4"
#define MEMORANDUM_CELL_FONT_COLOR   @"8d2c4c"
#define CALANDER_INTERVAL      17


//体温
#define TEMPERATURE_INTERVAL  20 
#define TEMPERATURE_CELL_DATE_COLOR  @"#8d2c4c"
#define TEMPERATURE_CELL_WENDU_COLOR @"#e12c3a"

//设置模块
#define SET_CELL_INTERVAL  14
#define SET_CELL_HEIGHT    44
#define SET_SECTION_HEIGHT  13
#define SET_CELL_COLOR  @"fcd0d4"
#define SET_CELL_SEP_COLOR   @"f48a97"
//设置加载图
#define SET_LOADING_IMAGE @"LoadingIma.png"

#define myAppDelegate (AppDelegate *)[UIApplication sharedApplication].delegate

#define RGB_Color(r,g,b) ([UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f])

//********************颜色值*************************************
//#445259
#define backGroud_Color RGB_Color(68,82,89)
//#5bacd9
#define Btn_Color RGB_Color(244,0,28)
//#f1f1f1
#define nav_Color RGB_Color(241,241,241)

//黄色价钱
#define YellowColor RGB_Color(236, 30, 36)

//所有button颜色
#define AllBtn_Color RGB_Color(0,0,0)

//适配

#define iphone_HIGHT 1
#define iphone_WIDTH 1

#define RECT(x,y,w,h) CGRectMake(x,y*iphone_HIGHT,w*iphone_WIDTH,h*iphone_HIGHT)
#define NSUserDefaultsDic       [NSUserDefaults standardUserDefaults]   //函数

#define KeyZenID                         @"ZenIDdata"
#define MyZenID     [[NSUserDefaults standardUserDefaults]valueForKey:KeyZenID]

#define LoadingImage @"LoadingImage"
#define shareSDK_APPKEY @"b336f12f9730"
#endif
