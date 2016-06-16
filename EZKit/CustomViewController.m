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

static int num = 0;

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
    NSString *str = [NSString stringWithFormat:@"%d",++num];
    [btn setTitle:str forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(testBtnClicked:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *btn2 = [UIButton new];
    [self.view addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.center.mas_equalTo(self.view).offset(80);
    }];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"Dismiss" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(testBtnClicked2:) forControlEvents:UIControlEventTouchUpInside];
    
    NSMutableDictionary *dict;
    [dict allKeysForObject:@""];
}

-(void)testBtnClicked:(UIButton *)sender
{
    CustomViewController *vc = [CustomViewController new];
//    vc.ez_isPush = NO;
    [self ez_presentViewController:vc animatedType:EZPresentAnimationAlert dismissCompletion:nil];
}

-(void)testBtnClicked2:(UIButton *)sender
{
//    [self ez_dismissViewControllerAnimated:YES completion:nil];
    self.ez_isPush = NO;
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self ez_dismissViewControllerAnimated:YES completion:nil];
}

@end
