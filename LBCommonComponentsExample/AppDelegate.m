//
//  AppDelegate.m
//  LBTextFieldDemo
//
//  Created by 刘彬 on 2019/9/24.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "UIViewController+LBNavigationBarAppearance.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[MainTabBarController alloc] init];
    
    [self.window makeKeyAndVisible];
    
    
    [UINavigationBar appearance].lb_backItemTitle = @"返回文字自定义";
    [UINavigationBar appearance].lb_appearanceAvailable = YES;

    
    return YES;
}

@end
