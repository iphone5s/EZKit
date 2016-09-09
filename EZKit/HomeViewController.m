//
//  HomeViewController.m
//  EZKit
//
//  Created by Ezreal on 16/9/8.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "HomeViewController.h"
#import "EZKit.h"
#import "Masonry.h"
#import "TSViewController.h"

@interface HomeViewController ()<EZTabViewControllerDelegate>
{
    UIButton *headBtn;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.layoutStyle = EZTabLayoutStyleDefault;
    self.navigationHeight = 100;
    self.navigationColor = HEX_RGB(0x22292f);
    self.itemSize = CGSizeMake(100, 40);
    self.itemSpacing = 0;
    self.againstStatusBar = YES;
    self.sliderStyle = EZSliderStyleBubble;
    self.bubbleRadius = 6;
    self.itemNormalColor = HEX_RGB(0x4e5459);
    self.itemSelectedColor = [UIColor whiteColor];
    
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 80)];
    self.leftNavigatoinItem = leftView;
    leftView.backgroundColor = [UIColor clearColor];
    
    headBtn = [[UIButton alloc]initWithFrame:CGRectMake(30, 40, 40, 40)];
    headBtn.backgroundColor = [UIColor grayColor];
    [headBtn setBackgroundImage:[UIImage imageNamed:@"default_userhead"] forState:UIControlStateNormal];
    headBtn.layer.masksToBounds = YES;
    headBtn.layer.cornerRadius = 20.f;
    headBtn.layer.borderWidth = 1.0f;
    headBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    //    [headBtn addTarget:self action:@selector(headBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [leftView addSubview:headBtn];
    [headBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.center.mas_equalTo(leftView);
    }];
    
    [self reloadDataAtPage:3];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfTabIntabViewController:(EZTabViewController *)tabViewController
{
    return 10;
}

- (UIButton *)tabViewController:(EZTabViewController *)tabViewController menuItemAtIndex:(NSUInteger)itemIndex
{
    UIButton * menuItem = [UIButton new];
    [menuItem setTitle:@"热门" forState:UIControlStateNormal];
//    [menuItem setTitleColor:HEX_RGB(0x4e5459) forState:UIControlStateNormal];
//    [menuItem setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    menuItem.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    return menuItem;
}

- (UIViewController *)tabViewController:(EZTabViewController *)tabViewController viewControllerAtPage:(NSUInteger)pageIndex
{
    TSViewController *viewController = [TSViewController new];
    viewController.view.backgroundColor = RGB_RANDOM;
    viewController.page = pageIndex;
    return viewController;
}

@end
