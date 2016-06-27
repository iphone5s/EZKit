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
#import "UIViewController+EZLoading.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.ez_loadingType = EZLoadingTypeLoading;
}

- (UIImage *)imageForEmptyDataSet
{
    switch (self.ez_loadingType)
    {
        case EZLoadingTypeNone:
        {
            return nil;
        }
            break;
        case EZLoadingTypeLoading:
        {
            return [UIImage imageNamed:@"loading"];
        }
            break;
        case EZLoadingTypeNetError:
        {
            return [UIImage imageNamed:@"default_network"];
        }
            break;
        case EZLoadingTypeEmptyData:
        {
            return [UIImage imageNamed:@"default_chat"];
        }
        default:
        {
            return nil;
        }
            break;
    }
}

-(NSString *)descriptionForEmptyDataSet
{
    return @"你的网络不给力，点击屏幕重新刷新";
}

-(void)didTapView
{
    self.ez_loadingType = arc4random() %4;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
