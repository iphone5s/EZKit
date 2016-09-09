//
//  EZTabViewController.h
//  Demo
//
//  Created by Ezreal on 16/7/21.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EZTabViewController;

/** 导航栏布局样式 */
typedef NS_ENUM(NSUInteger, EZTabLayoutStyle) {
    /** 默认样式，导航栏居左布局,itemSize指定宽高，间距由itemSpacing决定 */
    EZTabLayoutStyleDefault,
    /** 导航栏居中布局,itemSize指定宽高，间距由itemSpacing决定 */
    EZTabLayoutStyleCenter,
    /** items等分导航条宽度，常用于item数较少时 */
    EZTabLayoutStyleDivide,
};

/** 导航栏滑块样式 */
typedef NS_ENUM(NSUInteger, EZSliderStyle) {
    /** 默认显示下划线 */
    EZSliderStyleDefault,
    /** 气泡样式，该样式下需结合bubbleInset和bubbleRadius使用 */
    EZSliderStyleBubble,
};

/****************************************delegate****************************************/
@protocol EZTabViewControllerDelegate <NSObject>

@required
/**
 *  获取页面数量
 *
 *  @param tabViewController self
 *
 *  @return tab数量
 */
- (NSInteger)numberOfTabIntabViewController:(EZTabViewController *)tabViewController;

/**
 *  根据index获取对应索引的menuItem
 *
 *  @param tabViewController self
 *  @param index     当前索引
 *
 *  @return 当前索引对应的按钮
 */
- (UIButton *)tabViewController:(EZTabViewController *)tabViewController menuItemAtIndex:(NSUInteger)itemIndex;

/**
 *  当前索引对应的控制器
 *
 *  @param tabViewController self
 *  @param index     当前索引
 *
 *  @return 控制器
 */
- (UIViewController *)tabViewController:(EZTabViewController *)tabViewController viewControllerAtPage:(NSUInteger)pageIndex;

@optional
/**
 *  视图控制器显示到当前屏幕上时触发
 *
 *  @param tabViewController      self
 *  @param viewController 当前页面展示的控制器
 *  @param index          当前控控制器对应的索引
 */
- (void)tabViewController:(EZTabViewController *)tabViewController viewDidAppear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex;

/**
 *  视图控制器从屏幕上消失时触发
 *
 *  @param tabViewController      self
 *  @param viewController 消失的视图控制器
 *  @param index          当前控制器对应的索引
 */
- (void)tabViewController:(EZTabViewController *)tabViewController viewDidDisappear:(__kindof UIViewController *)viewController atPage:(NSUInteger)pageIndex;

/**
 *  选中导航菜单item时触发
 *
 *  @param tabViewController self
 *  @param itemIndex menuItem索引
 */
- (void)tabViewController:(EZTabViewController *)tabViewController didSelectItemAtIndex:(NSUInteger)itemIndex;

@end


@interface EZTabViewController : UIViewController
/**
 *  导航菜单的布局样式
 */
@property (nonatomic, assign) EZTabLayoutStyle layoutStyle;
/**
 *  导航栏滑块样式，默认显示下划线
 */
@property (nonatomic, assign) EZSliderStyle sliderStyle;
/**
 *  滑块的圆角半径，默认10
 *
 *  @warning 该属性用于EZSliderStyleBubble样式下
 */
@property (nonatomic, assign) CGFloat bubbleRadius;
/**
 *  顶部导航栏左侧视图项
 */
@property (nonatomic, strong) UIView *leftNavigatoinItem;
/**
 *  顶部导航栏背景色
 */
@property (nonatomic, strong) UIColor *navigationColor;
/**
 *  顶部导航条的高度，默认是44
 */
@property (nonatomic, assign) CGFloat navigationHeight;
/**
 *  menuItem宽高
 */
@property (nonatomic, assign) CGSize  itemSize;
/**
 *  item间距，默认是10
 */
@property (nonatomic, assign) CGFloat itemSpacing;
/**
 *  MenuTitle的正常颜色
 */
@property (nonatomic, strong) UIColor *itemNormalColor;
/**
 *  MenuTitle的选中颜色
 */
@property (nonatomic, strong) UIColor *itemSelectedColor;

/**
 *  顶部导航栏是否紧贴系统状态栏，即是否需要为状态栏留出20个点的区域，默认NO
 */
@property (nonatomic, assign, getter=isAgainstStatusBar) BOOL againstStatusBar;


-(void)reloadDataAtPage:(NSInteger)pageIndex;

@end
