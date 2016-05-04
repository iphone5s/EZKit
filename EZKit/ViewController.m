//
//  ViewController.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "ViewController.h"
#import "CustomViewController.h"
#import "EZKit.h"
#import "Masonry.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor grayColor];
    NSArray *arr = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSLog([arr objectAtIndex:0]);
    NSLog([arr objectAtIndex:1]);
    NSLog([arr objectAtIndex:2]);
    NSLog([arr objectAtIndex:100]);
    NSLog(@"没挂");
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSLog([array objectAtIndex:0]);
    NSLog([array objectAtIndex:1]);
    NSLog([array objectAtIndex:2]);
    NSLog([array objectAtIndex:100]);
    NSLog(@"没挂");
    UIButton *vcBtn = [UIButton new];
  
    [self.view addSubview:vcBtn];
    [vcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerY.mas_equalTo(self.view);
        make.left.mas_equalTo(self.view).offset(20);
    }];
    vcBtn.backgroundColor = [UIColor grayColor];
    [vcBtn setTitle:@"Present VC" forState:UIControlStateNormal];
    [vcBtn addTarget:self action:@selector(vcBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *navbtn = [UIButton new];
    
    [self.view addSubview:navbtn];
    [navbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerY.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view).offset(-20);
    }];
    navbtn.backgroundColor = [UIColor grayColor];
    [navbtn setTitle:@"Present Nav" forState:UIControlStateNormal];
    [navbtn addTarget:self action:@selector(navBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)vcBtnClicked:(UIButton *)sender
{
    CustomViewController *vc = [CustomViewController new];

    [self ez_presentViewController:vc animatedType:EZPresentAnimationAlert completion:nil];
}

-(void)navBtnClicked:(UIButton *)sender
{
    TestViewController *vc = [TestViewController new];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    [self ez_presentViewController:nav animatedType:EZPresentAnimationAlert completion:nil];
}

@end
