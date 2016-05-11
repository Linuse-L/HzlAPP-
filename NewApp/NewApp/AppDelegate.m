//
//  AppDelegate.m
//  NewApp
//
//  Created by L on 15/9/17.
//  Copyright (c) 2015年 NewApp. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "LeftViewController.h"
#import "IQKeyboardManager.h"
#import "IQSegmentedNextPrevious.h"
#import "MobClick.h"
#import "ReviewVC.h"
#import "UMessage.h"

#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
@interface AppDelegate ()
{
    UIAlertView *alert1;
    UIAlertView *alert2;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];

    
    [MobClick startWithAppkey:mob_key reportPolicy:BATCH   channelId:@"Web"];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    if ([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        //IOS8
        //创建UIUserNotificationSettings，并设置消息的显示类类型
        UIUserNotificationSettings *notiSettings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge | UIUserNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
        
        [application registerUserNotificationSettings:notiSettings];
        
    } else{ // ios7
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge                                       |UIRemoteNotificationTypeSound                                      |UIRemoteNotificationTypeAlert)];
    }
    //set AppKey and AppSecret
    [UMessage startWithAppkey:@"562759a067e58e3697001fbe" launchOptions:launchOptions];
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if([application respondsToSelector:@selector(isRegisteredForRemoteNotifications)])
    {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
    [UMessage setLogEnabled:YES];
    [Singleton ISBGBF:YES];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    [[Singleton sharedInstance]getZenid];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    LeftViewController *leftVC = [[LeftViewController alloc]init];
    HomeVC *home = [[HomeVC alloc]init];
    self.naVC = [[UINavigationController alloc]initWithRootViewController:home];
    
    _tabbarVC = [[TabViewController alloc]init];
    
//    UINavigationController *leftNaVC = [[UINavigationController alloc]initWithRootViewController:leftVC];

    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:self.naVC leftDrawerViewController:leftVC];
    self.window.rootViewController = _tabbarVC;
    [self.drawerController setMaximumLeftDrawerWidth:260*iphone_WIDTH];
//    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];

    
      
    [self.drawerController setShowsShadow:YES];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
//    UITabBarController *tabbar = [[UITabBarController alloc]init];
//    tabbar.viewControllers = [self.naVC];
    if (launchOptions) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Pushserver" object:nil];
    }else {
        
    }
    return YES;
}
//返回 AppDelegate
+ (AppDelegate *)getAppDelegate
{
    return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [UMessage registerDeviceToken:deviceToken];
    NSString *pushToken = [[[[deviceToken description]
                             
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           
                           stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    [self sendProviderDeviceToken:pushToken];
    NSDictionary *dic = remoteNotification;
    NSDictionary *aps = [dic objectForKey:@"aps"];
    
    NSString *message = [NSString stringWithFormat:@"%@",[aps objectForKey:@"code"] ];
        if ([message isEqualToString:@"pid"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Pushserver" object:remoteNotification];
        }else if ([message isEqualToString:@"oid"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Pushserver2" object:nil];
        }else{
            
        }
    
}

- (void)sendProviderDeviceToken: (NSString *)deviceTokenString
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:deviceTokenString forKey:@"deviceTokenString"];
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
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [UMessage didReceiveRemoteNotification:userInfo];
    NSLog(@"userInfo == %@",userInfo);
    NSDictionary *dic = userInfo;
    NSDictionary *aps = [dic objectForKey:@"aps"];
    remoteNotification = userInfo;
//    NSString *message = [NSString stringWithFormat:@"%@",[aps objectForKey:@"alert"] ];
    NSString *code = [NSString stringWithFormat:@"%@",[aps objectForKey:@"code"]];
    if ([code isEqualToString:@"pid"]) {
        alert1 = [[UIAlertView alloc]initWithTitle:@"Message" message:[NSString stringWithFormat:@"%@",[aps objectForKey:@"showMsg"]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert1 show];

    }else if ([code isEqualToString:@"oid"]) {
        alert2 = [[UIAlertView alloc]initWithTitle:@"Message" message:[NSString stringWithFormat:@"%@",[aps objectForKey:@"alert"]] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
        [alert2 show];
    }else {
        
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView == alert1) {
        if (buttonIndex == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Pushserver" object:remoteNotification];
        }else{
            
        }
    }else {
        if (buttonIndex == 1) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Pushserver2" object:nil];
        }else{
            
        }
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [Singleton ISBGBF:NO];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when  the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [Singleton ISBGBF:YES];
    [[Singleton sharedInstance]getZenid];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.d.NewApp" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"NewApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"NewApp.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"注册推送服务时，发生以下错误： %@",error);
}

- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    NSURL * myURL_APP_A = [NSURL URLWithString:@"fbauth2://fb1673870782858912"];
    //        if ([[UIApplication sharedApplication] canOpenURL:myURL_APP_A]) {
    //          NSLog(@"canOpenURL");

    return  [[UIApplication sharedApplication] openURL:myURL_APP_A];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    
    NSLog(@"Calling Application Bundle ID: %@", sourceApplication);
    NSLog(@"URL scheme:%@", [url scheme]);
    NSLog(@"URL query: %@", [url query]);
    NSLog(@"URL query: %@", [url host]);
    NSLog(@"URL query: %@", [url port]);
    NSLog(@"URL query: %@", [url user]);
    NSLog(@"URL query: %@", [url password]);
    NSLog(@"URL query: %@", [url path]);
    NSLog(@"URL query: %@", [url fragment]);
    NSLog(@"URL query: %@", [url user]);
    NSLog(@"URL query: %@", [url password]);
    NSLog(@"URL query: %@", [url path]);
    NSLog(@"URL query: %@", [url relativePath]);
    NSLog(@"URL query: %@", [url resourceSpecifier]);
    //uggboxproduct://(host)
    if ([[url scheme] isEqualToString:@"uggboxproduct"]) {
        //进入产品
        //18837 测试id
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deeplinkproduct" object:[url host]];
    }else if ([[url scheme] isEqualToString:@"uggboxcategory"]) {
        //进入分类  //uggboxcategory://
        [[NSNotificationCenter defaultCenter] postNotificationName:@"deeplinkcategory" object:[url scheme]];
    }
    return  [[FBSDKApplicationDelegate sharedInstance] application:application
                                                           openURL:url
                                                 sourceApplication:sourceApplication
                                                        annotation:annotation];
    
}


@end
