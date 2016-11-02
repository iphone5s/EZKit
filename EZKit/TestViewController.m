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
    UIButton *pushBtn = [UIButton new];
    [self.view addSubview:pushBtn];
    [pushBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.centerY.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(20);
    }];
    [pushBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [pushBtn setTitle:@"push" forState:UIControlStateNormal];
    [pushBtn addTarget:self action:@selector(pushBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *dismissBtn = [UIButton new];
    [self.view addSubview:dismissBtn];
    [dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.centerY.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view).offset(-20);
    }];
    [dismissBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [dismissBtn setTitle:@"dismiss" forState:UIControlStateNormal];
    [dismissBtn addTarget:self action:@selector(dismissBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)pushBtnClicked:(UIButton *)sender
{
//    self.navigationController.view.frame = CGRectMake(0, 0, 100, 100);
    TestViewController *vc = [TestViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
    [self ez_presentViewController:vc animatedType:EZPresentAnimationAlert dismissCompletion:nil];
}

-(void)dismissBtnClicked:(UIButton *)sender
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self ez_dismissViewControllerAnimated:YES completion:nil];
}
@end
