//
//  CustomViewController.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "CustomViewController.h"
#import "EZKit.h"
#import "Masonry.h"
@implementation CustomViewController

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
    [btn setTitle:@"Dismiss" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(testBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)testBtnClicked:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
