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
#import "TestViewController.h"

@implementation CustomViewController
{
    completionBlock m_compleBlock;
}

-(void)viewDidLoad
{
    self.view.backgroundColor = [UIColor redColor];
    self.view.frame = CGRectMake(0, 0, 400, 380);
    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.center.mas_equalTo(self.view);
    }];
    btn.backgroundColor = RGB_RANDOM;
    [btn setTitle:@"测试" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)showAlert:(nullable completionBlock)compleBlock;
{
    m_compleBlock = compleBlock;
    [self ez_showAlert];
}

-(void)btnClicked:(UIButton *)sender
{
    [self ez_hideAlert:^{
        if (m_compleBlock != nil)
        {
            m_compleBlock(123);
        }
    }];
}

-(void)dealloc
{
    
}
@end
