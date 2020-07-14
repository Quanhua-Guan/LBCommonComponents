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
    
    //数组保护测试
    NSMutableArray *crashArray = [NSMutableArray array];
    id objct = crashArray[1];
    [crashArray objectsAtIndexes:[NSIndexSet indexSetWithIndex:1]];
    [crashArray addObject:nil];
    [crashArray insertObject:nil atIndex:3];
    [crashArray removeObjectAtIndex:1];
    [crashArray removeObjectsInRange:NSMakeRange(1, 1)];
    [crashArray subarrayWithRange:NSMakeRange(0, 1)];
    crashArray[1] = @"crash";
    [crashArray setObject:@"" atIndexedSubscript:1];
    
    [crashArray replaceObjectAtIndex:1 withObject:nil];
    [crashArray replaceObjectsInRange:NSMakeRange(1, 1) withObjectsFromArray:@[]];
    [crashArray replaceObjectsAtIndexes:[NSIndexSet indexSetWithIndex:1] withObjects:nil];
    [crashArray replaceObjectsInRange:NSMakeRange(1, 1) withObjectsFromArray:@[] range:NSMakeRange(1, 1)];
}

@end
