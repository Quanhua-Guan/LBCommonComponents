//
//  MainTabBarController.m
//  LBCommonComponentsExample
//
//  Created by 刘彬 on 2021/5/10.
//  Copyright © 2021 刘彬. All rights reserved.
//

#import "MainTabBarController.h"
#import "ViewController.h"
#import "LBBaseNavigationController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController
- (instancetype)init
{
    self = [super init];
    if (self) {
        UIViewController *vc = [ViewController new];
        UINavigationController *naVC = [[LBBaseNavigationController alloc] initWithRootViewController:vc];
        self.viewControllers = @[naVC];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

@end
