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

//#import "YTKNetworkConfig.h"
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
//    http://sportsipad.qq.com/match/indexColumns
//    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
//    config.baseUrl = @"http://sportsipad.qq.com";
//
//    TestApi *api = [[TestApi alloc]init];
//    if ([api cacheJson]) {
//        NSDictionary *json = [api cacheJson];
//        NSLog(@"json = %@", json);
//        // show cached data
//    }
//    [api startWithCompletionBlockWithSuccess:^(__kindof EZRequest *request) {
//        id objstr = request.responseString;
//        id objData = request.responseData;
//        id objjson = request.responseJSONObject;
//        id model = request.responseModel;
//        NSLog(@"success");
//    } failure:^(__kindof EZRequest *request) {
//        
//    }];
//    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//        id objstr = request.responseString;
//        id objData = request.responseData;
//        id objjson = request.responseJSONObject;
//        NSLog(@"success");
//    } failure:^(__kindof YTKBaseRequest *request) {
//        
//    }];
    
    
    
//    for (int i = 0; i< 10000; i++) {
//        NSString *str = [NSString stringWithFormat:@"%d",i];
//       [EZSharedCache ez_saveCacheByKey:str value:str];
//    }
//    btn.enabled
//    EZSharedCache.enableAutoClear = YES;
    EZNetworkConfig *config = [EZNetworkConfig sharedInstance];
    config.baseUrl = @"http://sportsipad.qq.com";
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
//    EZSharedCache.enableAutoClear = YES;//!EZSharedCache.enableAutoClear;
//    TestViewController *vc = [TestViewController new];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//    [self ez_presentViewController:nav animatedType:EZPresentAnimationAlert completion:nil];
//    [EZSharedHUD showIndicatorMsg:@"正在插入数据"];

//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // something
//        NSString *strdata = @"a";
//        for (int i =0; i<1; i++) {
//            strdata = [strdata stringByAppendingString:@"a"];
//        }
//        for (int i = 0; i< 1; i++) {
//            NSString *str = [NSString stringWithFormat:@"%d",i];
//            [EZSharedCache ez_saveCacheByKey:str value:strdata];
//        }
//        
//    });
//    __weak ViewController *weakSelf = self;
//    for (int i = 0 ; i<100; i++) {
//        TestApi *api = [[TestApi alloc]init];
//        [api startWithCompletionBlockWithSuccess:^(__kindof EZBaseRequest *request) {
////            NSLog(@"Success %d",i);
//        } failure:^(__kindof EZBaseRequest *request) {
//            
//        }];
//    }

    TestApi *api = [[TestApi alloc]init];
    [api startWithCompletionBlockWithSuccess:^(__kindof EZRequest *request) {
        //            NSLog(@"Success %d",i);
    } failure:^(__kindof EZRequest *request) {
        
    }];
}

-(void)hudBtnClicked:(UIButton *)sender
{
////    [EZSharedHUD showMsg:@"测试"];
////    [EZSharedHUD showIndicatorMsg:@"正在清除数据"];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // something
//        [EZSharedCache ez_clearAllCache];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            // something
//            [EZSharedHUD showMsg:@"数据清除完成"];
//        });
//    });
    [EZSharedCache ez_clearAllCache];
    
}

@end
