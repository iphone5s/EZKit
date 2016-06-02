//
//  ViewController.m
//  EZKit
//
//  Created by Ezreal on 16/5/12.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "ViewController.h"
#import "CustomViewController.h"
#import "EZKit.h"
#import "Masonry.h"
#import "TestViewController.h"
#import "TestApi.h"
#import "Argument.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.view.backgroundColor = [UIColor grayColor];
//    NSArray *arr = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
//    NSLog([arr objectAtIndex:0]);
//    NSLog([arr objectAtIndex:1]);
//    NSLog([arr objectAtIndex:2]);
//    NSLog([arr objectAtIndex:100]);
//    NSLog(@"没挂");
//    
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1",@"2",@"3", nil];
//    NSLog([array objectAtIndex:0]);
//    NSLog([array objectAtIndex:1]);
//    NSLog([array objectAtIndex:2]);
//    NSLog([array objectAtIndex:100]);
//    NSLog(@"没挂");
//    UIButton *vcBtn = [UIButton new];
//    
//    [self.view addSubview:vcBtn];
//    [vcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100, 30));
//        make.centerY.mas_equalTo(self.view);
//        make.left.mas_equalTo(self.view).offset(20);
//    }];
//    vcBtn.backgroundColor = [UIColor grayColor];
//    [vcBtn setTitle:@"Present VC" forState:UIControlStateNormal];
//    [vcBtn addTarget:self action:@selector(vcBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *navbtn = [UIButton new];
//    
//    [self.view addSubview:navbtn];
//    [navbtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100, 30));
//        make.centerY.mas_equalTo(self.view);
//        make.right.mas_equalTo(self.view).offset(-20);
//    }];
//    navbtn.backgroundColor = [UIColor grayColor];
//    [navbtn setTitle:@"Present Nav" forState:UIControlStateNormal];
//    [navbtn addTarget:self action:@selector(navBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *hudbtn = [UIButton new];
//    
//    [self.view addSubview:hudbtn];
//    [hudbtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100, 30));
//        make.centerX.mas_equalTo(self.view);
//        make.top.mas_equalTo(self.view).offset(80);
//    }];
//    hudbtn.backgroundColor = [UIColor grayColor];
//    [hudbtn setTitle:@"hudTest" forState:UIControlStateNormal];
//    [hudbtn addTarget:self action:@selector(hudBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    self.view.backgroundColor = HEX_RGB(0x000000);
//    //    http://sportsipad.qq.com/match/indexColumns
//    //    YTKNetworkConfig *config = [YTKNetworkConfig sharedInstance];
//    //    config.baseUrl = @"http://sportsipad.qq.com";
//    //
//    //    TestApi *api = [[TestApi alloc]init];
//    //    if ([api cacheJson]) {
//    //        NSDictionary *json = [api cacheJson];
//    //        NSLog(@"json = %@", json);
//    //        // show cached data
//    //    }
//    //    [api startWithCompletionBlockWithSuccess:^(__kindof EZRequest *request) {
//    //        id objstr = request.responseString;
//    //        id objData = request.responseData;
//    //        id objjson = request.responseJSONObject;
//    //        id model = request.responseModel;
//    //        NSLog(@"success");
//    //    } failure:^(__kindof EZRequest *request) {
//    //
//    //    }];
//    //    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
//    //        id objstr = request.responseString;
//    //        id objData = request.responseData;
//    //        id objjson = request.responseJSONObject;
//    //        NSLog(@"success");
//    //    } failure:^(__kindof YTKBaseRequest *request) {
//    //
//    //    }];
//    
//    
//    
//    //    for (int i = 0; i< 10000; i++) {
//    //        NSString *str = [NSString stringWithFormat:@"%d",i];
//    //       [EZSharedCache ez_saveCacheByKey:str value:str];
//    //    }
//    //    btn.enabled
//    //    EZSharedCache.enableAutoClear = YES;
//    EZNetworkConfig *config = [EZNetworkConfig sharedInstance];
//    config.baseUrl = @"http://sportsipad.qq.com";
//    Argument *argument = [[Argument alloc]init];
//    [config setArugment:argument];
//    tabView = [[EZTabView alloc]init];
//    [self.view addSubview:tabView];
//    [tabView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
//    }];
//    tabView.tabBackgroudColor = [UIColor redColor];
//    tabView.pageBackgroundColor = [UIColor yellowColor];
//    tabView.delegate = self;
//    
//    UIView *tabBackgroundV = [[UIView alloc]init];
//    tabBackgroundV.layer.masksToBounds = YES;
//    tabBackgroundV.layer.cornerRadius = 4;
//    tabBackgroundV.backgroundColor = HEX_RGB(0x333e47);
//    
//    tabView.tabBackgroundView = tabBackgroundV;
//    
//    [tabView reloadData];
    for (int i = 0; i < 100; i++) {
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 5 * i, 100, 5)];
        [self.view addSubview:v];
//        v.backgroundColor = [self colorPercent:i fromColor:HEX_RGB(0xabb7c1) toColor:HEX_RGB(0x1c90f2)];
        v.backgroundColor = HEX_RGB_RGB(HEX_RGB(0xabb7c1), HEX_RGB(0x1c90f2), i);
//        v.backgroundColor = [self test:i color1:0xabb7c1 color2:0x1c90f2];
    }

}
//
//- (NSUInteger) hexFromColor: (UIColor*) color {
//    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
//        const CGFloat *components = CGColorGetComponents(color.CGColor);
//        color = [UIColor colorWithRed:components[0]
//                                green:components[0]
//                                 blue:components[0]
//                                alpha:components[1]];
//    }
//    
//    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
//        return 0xffffff;
//    }
//    
//    NSUInteger hex = 0x000000;
// 
//    hex = (hex << 0)|(int)((CGColorGetComponents(color.CGColor))[0]*255.0);
//    
//    hex = (hex << 8)|(int)((CGColorGetComponents(color.CGColor))[1]*255.0);
//
//    hex = (hex << 8)|(int)((CGColorGetComponents(color.CGColor))[2]*255.0);;
//    
//    return hex;
//}
//
//-(UIColor *)colorPercent:(CGFloat)percent fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor
//{
//    NSUInteger fromColorHex = [self hexFromColor:fromColor];
//    NSUInteger toColorHex = [self hexFromColor:toColor];
//    NSUInteger r1 = ((fromColorHex >> 16) & 0x000000FF);
//    NSUInteger g1 = ((fromColorHex >> 8) & 0x000000FF);
//    NSUInteger b1 = ((fromColorHex >> 0) & 0x000000FF);
//  
//    NSUInteger r2 = ((toColorHex >> 16) & 0x000000FF);
//    NSUInteger g2 = ((toColorHex >> 8) & 0x000000FF);
//    NSUInteger b2 = ((toColorHex >> 0) & 0x000000FF);
//
//    int r_ = (int)(r1 - r2);
//    int g_ = (int)(g1 - g2);
//    int b_ = (int)(b1 - b2);
//    CGFloat r_v = r_ / 100.0;
//    CGFloat g_v = g_ / 100.0;
//    CGFloat b_v = b_ / 100.0;
//    
//    int r__ = round(r_v * percent);
//    int g__ = round(g_v * percent);
//    int b__ = round(b_v * percent);
//    NSInteger r = r1 - r__;
//    NSInteger g = g1 - g__;
//    NSInteger b = b1 - b__;
//    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
//}



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
//        EZSharedCache.enableAutoClear = YES;//!EZSharedCache.enableAutoClear;
//        TestViewController *vc = [TestViewController new];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
//        [self ez_presentViewController:nav animatedType:EZPresentAnimationAlert completion:nil];
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
        NSLog(@"缓存:%d 接口调用成功",request.isCache);
    } failure:^(__kindof EZRequest *request) {
        NSLog(@"接口调用失败");
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
