//
//  AppDelegate.m
//  CatShow
//
//  Created by Timmy on 2017/6/12.
//  Copyright © 2017年 ysw.com. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "SWLoginVC.h"
#import "SWTopWindow.h"

@interface AppDelegate (){
    Reachability *_reach;
    NetworkStates _states;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.rootViewController = [[SWLoginVC alloc] init];
    
    [self.window makeKeyAndVisible];
    
    [self checkNetworkStates];
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    //给状态栏添加一个按钮可以进行点击，可以让屏幕上的scrollView滚动到最顶部
    [SWTopWindow show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - private methods

/**
 实时监测网络状态
 */
-(void)checkNetworkStates{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange) name:kReachabilityChangedNotification object:nil];
    _reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [_reach startNotifier];
}

-(void)networkChange{
    NSString *tips;
    NetworkStates currentStates = [SWNetworkTool getNetworkStates];
    if (currentStates == _states) {
        return;
    }
    _states = currentStates;
    switch (currentStates) {
        case NetworkStatesNone:
            tips = @"当前无网络，请检查您的网络状态";
            break;
            
        case NetworkStates2G:
            tips = @"切换到了2G网络";
            break;
            
        case NetworkStates3G:
            tips = @"切换到了3G网络";
            break;
            
        case NetworkStates4G:
            tips = @"切换到了4G网络";
            break;
            
        case NetworkStatesWIFI:
            tips = nil;
            break;
            
        default:
            break;
    }
    
    if (tips.length) {
        [[[UIAlertView alloc] initWithTitle:@"温馨提示" message:tips delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}




@end
