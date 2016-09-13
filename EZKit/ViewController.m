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
#import "UIView+ErrorPage.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,EZErrorPageDelegate>

@end

@implementation ViewController
{
    UITableView *table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    
////    self.view.errorPageDelegate = self;
////    self.view.ez_pageType = EZErrorPageTypeLoading;
//    
//    table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
//    [self.view addSubview:table];
//    
////    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
////    v.backgroundColor = [UIColor redColor];
////    [table addSubview:v];
////    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
////    [v addGestureRecognizer:tap];
//    
//    table.errorPageDelegate = self;
//    table.ez_pageType = EZErrorPageTypeLoading;
////    [table reloadData];
////    self.ez_loadingType = EZLoadingTypeLoading;
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    
    NSMapTable *mapTable = [[NSMapTable alloc]initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsWeakMemory capacity:0];
    [mapTable setObject:@"key" forKey:@"1"];
    [mapTable setObject:@"key" forKey:@"2"];
    [mapTable setObject:@"key" forKey:@"3"];
    [mapTable setObject:@"key" forKey:@"4"];
    
//    NSMutableArray *ar = [NSMutableArray new];
//    [ar addObject:@"1"];
//    [ar addObject:@"2"];
//    [ar addObject:@"3"];
//    [ar addObject:@"4"];
//    NSString *obj = [ar objectAtIndex:5];
//    NSLog(@"");
}

-(void)test{
    CustomViewController *vc = [CustomViewController new];
    [self ez_presentViewController:vc animatedType:EZPresentAnimationAlert dismissCompletion:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)_tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *strCell = @"TSHighlightsPlaybackCell";
    UITableViewCell *cell = (UITableViewCell *)[_tableView dequeueReusableCellWithIdentifier:
                                                strCell];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:strCell];
    }
    cell.textLabel.text = @"10";
    return cell;
}

-(NSString *)descForErrorPage
{
    return @"你的网络不给力，点击屏幕重新加载";
}

-(UIImage *)imageForErrorPage
{
    switch (table.ez_pageType)
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
    int i = arc4random()%3;
    if (i == 0) {
        table.ez_pageType = EZErrorPageTypeNetError;
    }else if(i==1){
        table.ez_pageType = EZErrorPageTypeLoading;
    }else{
        table.ez_pageType = EZErrorPageTypeNone;
    }
}

//
//- (UIImage *)imageForEmptyDataSet
//{
//    switch (self.ez_loadingType)
//    {
//        case EZLoadingTypeNone:
//        {
//            return nil;
//        }
//            break;
//        case EZLoadingTypeLoading:
//        {
//            return [UIImage imageNamed:@"loading"];
//        }
//            break;
//        case EZLoadingTypeNetError:
//        {
//            return [UIImage imageNamed:@"default_network"];
//        }
//            break;
//        case EZLoadingTypeEmptyData:
//        {
//            return [UIImage imageNamed:@"default_chat"];
//        }
//        default:
//        {
//            return nil;
//        }
//            break;
//    }
//}
//
//-(NSString *)descriptionForEmptyDataSet
//{
//    return @"你的网络不给力，点击屏幕重新刷新";
//}
//
//-(void)didTapView
//{
//    self.ez_loadingType = arc4random() %4;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)handleSingleTap:(UITapGestureRecognizer *)sender
//{
//
//}

@end
