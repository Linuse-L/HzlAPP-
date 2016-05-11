//
//  AppDelegate.h
//  NewApp
//
//  Created by L on 15/9/17.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "MMDrawerController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "TabViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSDictionary * remoteNotification;
}
@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong)UINavigationController *naVC;
@property (nonatomic,strong) MMDrawerController * drawerController;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong)TabViewController *tabbarVC ;
@property float autoSizeScaleX;

@property float autoSizeScaleY;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
+ (AppDelegate *)getAppDelegate;


@end

