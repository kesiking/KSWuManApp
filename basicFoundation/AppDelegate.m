//
//  AppDelegate.m
//  basicFoundation
//
//  Created by 逸行 on 15-4-7.
//  Copyright (c) 2015年 逸行. All rights reserved.
//

#import "AppDelegate.h"
#import "KSManWuTabBarViewController.h"
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self configApplication];
    [self configUIContent];
    
    return YES;
}

-(void)configApplication{
    // 读取配置文件
    [KSConfigCenter configMatrix];
    // 配置Navigator，支持全局url跳转
    [KSBasicNavigator configNavigator];
}

-(void)configUIContent{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.window.backgroundColor = [UIColor whiteColor];
    
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController: [[KSManWuTabBarViewController alloc] init]];
    if([navigationController.navigationBar respondsToSelector:@selector(barTintColor)]){
        navigationController.navigationBar.barTintColor = RGB(0xf8, 0xf8, 0xf8);
    }
    if([navigationController.navigationBar respondsToSelector:@selector(tintColor)]){
        navigationController.navigationBar.tintColor  =   [UIColor whiteColor];
    }
    
    // 修改navbar title颜色
    NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                               RGB(0x66, 0x66, 0x66), NSForegroundColorAttributeName,
                                               [UIFont boldSystemFontOfSize:18], NSFontAttributeName,nil];
    
    [navigationController.navigationBar setTitleTextAttributes:navbarTitleTextAttributes];
    
    self.window.rootViewController = navigationController;
    
    [self.window makeKeyAndVisible];
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

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //如果极简开发包不可用,会跳转支付宝钱包进行支付,需要将支付宝钱包的支付结果回传给开 发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url
                                                  standbyCallback:^(NSDictionary *resultDic) {
                                                      NSLog(@"result = %@",resultDic);
                                                  }]; }
    if ([url.host isEqualToString:@"platformapi"]){//支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    }
    return YES; }

@end
