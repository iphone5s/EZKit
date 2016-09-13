//
//  TSViewController.m
//  EZKit
//
//  Created by Ezreal on 16/9/8.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "TSViewController.h"
#import "Masonry.h"
@interface TSViewController ()

@end

@implementation TSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *v = [UIView new];
    [self.view addSubview:v];
    v.backgroundColor = [UIColor redColor];
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.view).offset(10);
        make.right.bottom.mas_equalTo(self.view).offset(-10);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear %lu",self.page);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear %lu",self.page);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear %lu",self.page);
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear %lu",self.page);
}


@end
