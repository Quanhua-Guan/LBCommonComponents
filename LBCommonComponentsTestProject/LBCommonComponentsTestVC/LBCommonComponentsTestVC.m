//
//  ViewController.m
//  CommonComponentsTestProject
//
//  Created by 刘彬 on 2019/2/21.
//  Copyright © 2019 BIN. All rights reserved.
//

#import "LBCommonComponentsTestVC.h"
#import "LBWebViewController.h"
#import "LBAlertController.h"

@interface LBCommonComponentsTestVC ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_testTitleArray;
}
@end

@implementation LBCommonComponentsTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _testTitleArray = @[@"LBWebViewController TEST",@"LBAlertController TEST"].mutableCopy;
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _testTitleArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"TEST_CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = _testTitleArray[indexPath.row];
    return cell;
}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *testTitle = _testTitleArray[indexPath.row];
    if ([testTitle containsString:@"LBWebViewController"]){
        LBWebViewController *webVC = [[LBWebViewController alloc] initWithUrlString:@"https://www.jianshu.com/p/32024a2f5c05"];
        webVC.showFunctionMenu = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }else if ([testTitle containsString:@"LBAlertController"]){
        LBAlertController *alertTestC = [[LBAlertController alloc] initWithAlertTitle:@"测试" message:@"控件测试"];
        LBAlertActionButton *alertActionBtn = [[LBAlertActionButton alloc] initWithFrame:CGRectMake(0, 0, 80, 40) action:^(UIButton *sender) {
            [self dismissViewControllerAnimated:YES completion:NULL];
        }];
        [alertActionBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [alertActionBtn setTitle:@"测试" forState:UIControlStateNormal];
        [alertTestC addActionButton:alertActionBtn];
        [self presentViewController:alertTestC animated:YES completion:NULL];
    }
}
@end
