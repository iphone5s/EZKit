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
#import "YTKNetworkConfig.h"
#import "TestApi.h"

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
    
    UIButton *hudbtn = [UIButton new];
    
    [self.view addSubview:hudbtn];
    [hudbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 30));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(80);
    }];
    hudbtn.backgroundColor = [UIColor grayColor];
    [hudbtn setTitle:@"hudTest" forState:UIControlStateNormal];
    [hudbtn addTarget:self action:@selector(hudBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = HEX_RGB(0x000000);
    
    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
    config.baseUrl = @"http://sportsipad.qq.com";

    TestApi *api = [[TestApi alloc]init];
    [api startWithCompletionBlockWithSuccess:^(__kindof EZRequest *request) {
        id objstr = request.responseString;
        id objData = request.responseData;
        id objjson = request.responseJSONObject;
        id model = request.responseModel;
        NSLog(@"success");
    } failure:^(__kindof EZRequest *request) {
        
    }];
//    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        id objstr = request.responseString;
//        id objData = request.responseData;
//        id objjson = request.responseJSONObject;
//        NSLog(@"success");
//    } failure:^(__kindof YTKBaseRequest *request) {
//        
//    }];
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

-(void)hudBtnClicked:(UIButton *)sender
{
    [EZSharedHUD showMsg:@"测试"];
}

@end
