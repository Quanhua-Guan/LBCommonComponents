//
//  ViewController.m
//  LBCommonComponentsExample
//
//  Created by 刘彬 on 2019/9/27.
//  Copyright © 2019 刘彬. All rights reserved.
//

#import "ViewController.h"
#import "LBUIMacro.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%f----%f",LB_SAFE_AREA_TOP_HEIGHT(self),LB_SAFE_AREA_BOTTOM_HEIGHT(self));
    
}


@end
