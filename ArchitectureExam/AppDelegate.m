//
//  AppDelegate.m
//  ArchitectureExam
//
//  Created by abc on 15/12/26.
//  Copyright © 2015年 longlz. All rights reserved.
//

#import "AppDelegate.h"

#import "LDrawerViewController.h"
#import "AELeftViewController.h"
#import "AEMainViewController.h"
#import "UIApplication+Sharing.h"
#import "WXApi.h"


@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [UIApplication registerApp];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    [[AEUserInfo shareAEUserInfo]getLocationUserInfo];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    AELeftViewController *leftVC = [[AELeftViewController alloc]init];
    AEMainViewController *mainVC = [[AEMainViewController alloc]init];
    
    AENavigationController *nav = [[AENavigationController alloc]initWithRootViewController:mainVC];
    
    LDrawerViewController *drawerVC = [[LDrawerViewController alloc]initWithCenterController:nav leftController:leftVC];
    
    self.window.rootViewController = drawerVC;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark - 如果使用SSO（可以简单理解成跳客户端授权），以下方法是必要的

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [UIApplication shareHandleOpenURL:url wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [UIApplication shareHandleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:self];
}
@end
