//
//  TestViewController.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "TestViewController.h"
#import "EZKit.h"
#import "Masonry.h"
@implementation TestViewController

-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, EZSharedDevice.screenWidth / 2.0, EZSharedDevice.screenHeight / 2.0);
    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.center.mas_equalTo(self.view);
    }];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"push" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(testBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)testBtnClicked:(UIButton *)sender
{
    TestViewController *vc = [TestViewController new];
    NSLog(@"%@",self.navigationController);
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
