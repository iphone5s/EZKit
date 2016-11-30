//
//  TSViewController.m
//  EZKit
//
//  Created by Ezreal on 16/9/8.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "TSViewController.h"
#import "Masonry.h"
#import "TestViewController.h"
#import "EZKit.h"
@interface TSViewController ()<EZErrorPageDelegate>

@end

@implementation TSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    UIView *v = [UIView new];
//    [self.view addSubview:v];
//    v.backgroundColor = [UIColor redColor];
//    [v mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.top.mas_equalTo(self.view).offset(10);
//        make.right.bottom.mas_equalTo(self.view).offset(-10);
//    }];
//    UIButton *btn = [UIButton new];
//    [self.view addSubview:btn];
//    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(100, 100));
//        make.center.mas_equalTo(self.view);
//    }];
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget: self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = RGB_RANDOM;
    self.view.errorPageDelegate = self;
    self.view.ez_pageType = EZErrorPageTypeLoading;
}

-(void)btnClicked:(UIButton *)sender
{
    TestViewController *viewController = [TestViewController new];
//    UINavigationController *navViewController = [[UINavigationController alloc]initWithRootViewController:viewController];
//    navViewController.view.frame = CGRectMake(0,0,800,600);
    [self ez_presentViewController:self animatedType:EZPresentAnimationAlert dismissCompletion:nil];
//    [self presentViewController:viewController animated:YES completion:nil];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear %lu",(long)self.page);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear %lu",(long)self.page);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear %lu",(long)self.page);
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear %lu",(long)self.page);
}



-(NSString *)descForErrorPage
{
    return @"你的网络不给力，点击屏幕重新加载";
}

-(UIImage *)imageForErrorPage
{
    switch (self.view.ez_pageType)
    {
        case EZErrorPageTypeLoading:
        {
            return [UIImage imageNamed:@"loading_imgBlue_78x78"];
        }
            break;
        case EZErrorPageTypeNetError:
        {
            return [UIImage imageNamed:@"default_network"];
        }
            
        default:
        {
            return nil;
        }
            break;
    }
    
}

-(void)didTapView
{

}

@end
