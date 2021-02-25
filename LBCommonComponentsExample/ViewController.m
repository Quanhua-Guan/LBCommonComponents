//
//  ViewController.m
//  LBCommonComponentsExample
//
//  Created by 刘彬 on 2019/9/27.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "ViewController.h"
#import "ViewControllerDefault.h"
#import "LBUIMacro.h"
#import "UIViewController+LBNavigationBarAppearance.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%f----%f",LB_SAFE_AREA_TOP_HEIGHT(self),LB_SAFE_AREA_BOTTOM_HEIGHT(self));
    
    self.view.backgroundColor = [UIColor magentaColor];
    
    self.title = @"LBCommonComponents";
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一页" style:UIBarButtonItemStylePlain target:self action:@selector(nextPage)];
    
    [self setNavigationBarAppearanceStyle:LBNavigationBarTransparent tintColor:[UIColor whiteColor]];
}

-(void)nextPage{
    ViewControllerDefault *vc = [[ViewControllerDefault alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
