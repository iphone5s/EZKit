//
//  EZTabViewController.m
//  Demo
//
//  Created by Ezreal on 16/7/21.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "EZTabViewController.h"
#import "EZKit.h"
#import <objc/runtime.h>
#import "NSObject+EZKit.h"

static const void *ez_AppearanceStateKey = &ez_AppearanceStateKey;

typedef NS_ENUM(NSUInteger, EZAppearanceState) {
    /** 默认状态，已经消失 */
    EZAppearanceStateDidDisappear = 0,
    /** 即将消失 */
    EZAppearanceStateWillDisappear = 1,
    /** 即将显示 */
    EZAppearanceStateWillAppear = 2,
    /** 已经显示 */
    EZAppearanceStateDidAppear = 3,
};

@interface UIViewController (EZTab)

@property(nonatomic,assign)EZAppearanceState ez_appearanceState;

@end

@implementation UIViewController (EZTab)
@dynamic ez_appearanceState;

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ez_hookMethod:@selector(ez_viewWillAppear:) tarSel:@selector(viewWillAppear:)];
        [self ez_hookMethod:@selector(ez_viewDidAppear:) tarSel:@selector(viewDidAppear:)];
        [self ez_hookMethod:@selector(ez_viewWillDisappear:) tarSel:@selector(viewWillDisappear:)];
        [self ez_hookMethod:@selector(ez_viewDidDisappear:) tarSel:@selector(viewDidDisappear:)];
    });
}

-(void)ez_viewWillAppear:(BOOL)animated
{
    self.ez_appearanceState = EZAppearanceStateWillAppear;
    [self ez_viewWillAppear:animated];
}

-(void)ez_viewDidAppear:(BOOL)animated
{
    self.ez_appearanceState = EZAppearanceStateDidAppear;
    [self ez_viewDidAppear:animated];
}

-(void)ez_viewWillDisappear:(BOOL)animated
{
    self.ez_appearanceState = EZAppearanceStateWillDisappear;
    [self ez_viewWillDisappear:animated];
}

-(void)ez_viewDidDisappear:(BOOL)animated
{
    self.ez_appearanceState = EZAppearanceStateDidDisappear;
    [self ez_viewDidDisappear:animated];
}

-(void)setEz_appearanceState:(EZAppearanceState)ez_appearanceState
{
    objc_setAssociatedObject(self, ez_AppearanceStateKey, [NSNumber numberWithInteger:ez_appearanceState], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(EZAppearanceState)ez_appearanceState
{
    NSNumber *num = objc_getAssociatedObject(self, ez_AppearanceStateKey);
    if (num == nil)
    {
        return EZAppearanceStateDidDisappear;
    }
    else
    {
        return num.integerValue;
    }
}

@end

@interface EZTabViewController ()<UIScrollViewDelegate>
{
    UIView *navigationView;
    UIScrollView *menuBar;
    UIScrollView *contentView;
    
    NSMutableArray *menuArray;
    
    UIView *sliderView;
    
    BOOL isViewWillAppear;
    NSInteger nextPageIndex;
    CGFloat lastOffSetX;
    BOOL isSkipUpdate;
}

@property (nonatomic,weak,readonly) id<EZTabViewControllerDelegate> delegate;

@property (nonatomic, assign) NSUInteger currentPage;

@end

@implementation EZTabViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        menuArray = [NSMutableArray new];
        
        navigationView = [UIView new];
        menuBar = [UIScrollView new];
        menuBar.showsVerticalScrollIndicator = NO;
        menuBar.showsHorizontalScrollIndicator = NO;
        menuBar.backgroundColor = [UIColor clearColor];
        
        sliderView = [UIView new];
        sliderView.backgroundColor = RGBA(0, 0, 0, 0.3);
        
        contentView = [UIScrollView new];
        contentView.showsVerticalScrollIndicator = NO;
        contentView.showsHorizontalScrollIndicator = NO;
        contentView.pagingEnabled = YES;
        contentView.scrollsToTop = NO;
        contentView.delegate = self;
        contentView.bounces = YES;
        
        self.navigationColor = [UIColor whiteColor];
        self.navigationHeight = 88.0f;
        self.itemSize = CGSizeMake(100, 40);
        self.layoutStyle = EZTabLayoutStyleDefault;
        self.itemSpacing = 10.0f;
        
        self.itemNormalColor = [UIColor whiteColor];
        self.itemSelectedColor = [UIColor whiteColor];
        
        [navigationView addSubview:menuBar];
        [menuBar addSubview:sliderView];
        [self.view addSubview:contentView];
        [self.view addSubview:navigationView];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(id<EZTabViewControllerDelegate>)delegate
{
    if ([self isMemberOfClass:[EZTabViewController class]])
    {
        if (self.parentViewController && [self.parentViewController conformsToProtocol:@protocol(EZTabViewControllerDelegate) ])
        {
            return (id<EZTabViewControllerDelegate>)self.parentViewController;
        }
    }
    else
    {
        if ([self conformsToProtocol:@protocol(EZTabViewControllerDelegate)])
        {
            return (id<EZTabViewControllerDelegate>)self;
        }
    }
    
    return nil;
}

-(void)setNavigationColor:(UIColor *)navigationColor
{
    _navigationColor = navigationColor;
    navigationView.backgroundColor = _navigationColor;
}

-(BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}

-(void)setLeftNavigatoinItem:(UIView *)leftNavigatoinItem
{
    if (_leftNavigatoinItem != nil)
    {
        [_leftNavigatoinItem removeFromSuperview];
    }
    _leftNavigatoinItem = leftNavigatoinItem;
    [navigationView addSubview:_leftNavigatoinItem];
    
    [self.view layoutIfNeeded];
}

-(void)viewDidLayoutSubviews
{
    navigationView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.navigationHeight);
    
    contentView.frame = CGRectMake(0, self.navigationHeight, self.view.frame.size.width, self.view.frame.size.height - self.navigationHeight);
    
    CGFloat topY = _againstStatusBar ? 20 : 0;
    
    if (self.leftNavigatoinItem != nil)
    {
        menuBar.frame = CGRectMake(self.leftNavigatoinItem.width, 0, self.view.frame.size.width - self.leftNavigatoinItem.width, self.navigationHeight);
        [self.leftNavigatoinItem setFrame:CGRectMake(0, topY, self.leftNavigatoinItem.width, self.leftNavigatoinItem.height)];
    }
    
    if (menuArray.count == 0) {
        sliderView.hidden = YES;
    }else{
        sliderView.hidden = NO;
    }
    
    if (self.sliderStyle == EZSliderStyleBubble) {
        [sliderView setFrame:CGRectMake(self.currentPage * (self.itemSize.width + self.itemSpacing), (self.navigationHeight - self.itemSize.height + topY) / 2.0, self.itemSize.width, self.itemSize.height)];
    }else
    {
        
    }
    
    for (int i = 0; i < menuArray.count; i++)
    {
        UIButton *menuItem = [menuArray objectAtIndex:i];
        switch (self.layoutStyle) {
            case EZTabLayoutStyleDefault:
            {
                menuItem.frame = CGRectMake(i * (self.itemSize.width + self.itemSpacing), (self.navigationHeight - self.itemSize.height + topY) / 2.0, self.itemSize.width, self.itemSize.height);
            }
                break;
            case EZTabLayoutStyleCenter:
            {
                CGFloat offSet = (self.view.width - menuArray.count * (self.itemSize.width + self.itemSpacing)) / 2.0;
                
                menuItem.frame = CGRectMake(offSet + i * (self.itemSize.width + self.itemSpacing), (self.navigationHeight - self.itemSize.height) / 2.0, self.itemSize.width, self.itemSize.height);
            }
                break;
            case EZTabLayoutStyleDivide:
            {
                CGFloat width = self.view.width / menuArray.count;
                menuItem.frame = CGRectMake(i * width, (self.navigationHeight - self.itemSize.height) / 2.0, width, self.itemSize.height);
            }
                break;
            default:
            {
                menuItem.frame = CGRectMake(i * (self.itemSize.width + self.itemSpacing), (self.navigationHeight - self.itemSize.height) / 2.0, self.itemSize.width, self.itemSize.height);
            }
                break;
        }
        
        UIViewController *viewController = [self.childViewControllers objectAtIndex:i];
        viewController.view.frame = CGRectMake(i * contentView.frame.size.width, 0, contentView.frame.size.width, contentView.frame.size.height);
    }
    
    [contentView setContentSize:CGSizeMake(self.view.frame.size.width * menuArray.count, 0)];
    [menuBar setContentSize:CGSizeMake((self.itemSize.width + self.itemSpacing) * menuArray.count, self.itemSize.height)];
    
    isSkipUpdate = YES;
    [contentView setContentOffset:CGPointMake(self.view.frame.size.width * self.currentPage, 0) animated:NO];
    isSkipUpdate = NO;
}

-(void)reloadDataAtPage:(NSInteger)pageIndex
{
    NSInteger count = self.childViewControllers.count;
    for (int index = 0; index < count; index++)
    {
        UIViewController *viewController = [self.childViewControllers lastObject];
        if (viewController.ez_appearanceState != EZAppearanceStateDidDisappear)
        {
            [self viewControllerWillDisappear:count - index - 1];
            [self viewControllerDidDisappear:count - index - 1];
        }
        
        [viewController willMoveToParentViewController:nil];
        [viewController.view removeFromSuperview];
        [viewController removeFromParentViewController];
    }
    
    for (UIButton *menuItem in menuArray)
    {
        [menuItem removeFromSuperview];
    }
    
    [menuArray removeAllObjects];
    
    if (self.delegate)
    {
        NSInteger tabCount = [self.delegate numberOfTabIntabViewController:self];
        for (int index = 0; index < tabCount; index++)
        {
            UIButton *menuItem = [self.delegate tabViewController:self menuItemAtIndex:index];
            [menuItem setTitleColor:self.itemNormalColor forState:UIControlStateNormal];
            
            menuItem.tag = index;
            [menuItem addTarget:self action:@selector(menuItemClicked:) forControlEvents:UIControlEventTouchUpInside];
            [menuBar addSubview:menuItem];
            [menuArray addObject:menuItem];
            
            UIViewController *viewController = [self.delegate tabViewController:self viewControllerAtPage:index];
            [self addChildViewController:viewController];
            [viewController didMoveToParentViewController:self];
            [contentView addSubview:viewController.view];
        }
        
    }
    
    if (pageIndex >= menuArray.count) {
        pageIndex = 0;
    }
    
    _currentPage = pageIndex;
    
    if (menuArray.count > 0)
    {
        UIButton *menuItem = [menuArray objectAtIndex:pageIndex];
        [menuItem setTitleColor:self.itemSelectedColor forState:UIControlStateNormal];
    }
    
    [self viewControllerWillAppear:pageIndex];
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    [self viewControllerDidAppear:pageIndex];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    isViewWillAppear = NO;
    
    menuBar.userInteractionEnabled = NO;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    isViewWillAppear = YES;
    
    menuBar.userInteractionEnabled = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger newIndex;
    NSInteger tempIndex;
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat scrollWidth = scrollView.frame.size.width;
    BOOL isSwipeToLeft = scrollWidth * _currentPage < offsetX;
    
    if (offsetX < 0  || offsetX > scrollWidth * (self.childViewControllers.count - 1) || isSkipUpdate)
    {
        return;
    }
    
    if (offsetX == 0 && lastOffSetX <= 0)
    {
        return;
    }
    
    if (offsetX == scrollWidth * (self.childViewControllers.count - 1) && lastOffSetX >= offsetX)
    {
        return;
    }
    
    if (isSwipeToLeft)
    { // 向左滑动
        newIndex = floorf(offsetX/scrollWidth);
        tempIndex = ceilf(offsetX/scrollWidth);
    }
    else
    {
        newIndex = ceilf(offsetX/scrollWidth);
        tempIndex = floorf(offsetX / scrollWidth);
    }
    
    if (newIndex != _currentPage)
    {
        self.currentPage = newIndex;
    }
    
    if (nextPageIndex != tempIndex)
    {
        isViewWillAppear = NO;
    }
    
    if (!isViewWillAppear && newIndex != tempIndex)
    {
        isViewWillAppear = YES;
        NSInteger pageIndex = newIndex + (isSwipeToLeft ? 1 : -1);
        
        if (pageIndex != nextPageIndex)
        {
            [self viewControllerWillDisappear:self.currentPage];
            [self viewControllerWillAppear:pageIndex];
            nextPageIndex = pageIndex;
        }
    }
    
    if (tempIndex == _currentPage)
    {
        // 重置_nextPageIndex
        if (nextPageIndex != _currentPage)
        {
            [self viewControllerWillDisappear:nextPageIndex];
            [self viewControllerWillAppear:self.currentPage];
            [self viewControllerDidDisappear:nextPageIndex];
            [self viewControllerDidAppear:self.currentPage];
        }
        nextPageIndex = _currentPage;
    }
    
    lastOffSetX = offsetX;
    
    float percent = offsetX / scrollWidth;
    
    sliderView.left = percent * (sliderView.width + self.itemSpacing);
    
    percent = fabsf(percent - self.currentPage);

    UIButton *nextItem = [menuArray objectAtIndex:nextPageIndex];
    UIButton *currentItem = [menuArray objectAtIndex:self.currentPage];
    [nextItem setTitleColor:[UIColor colorPercent:(100 * percent) fromColor:self.itemNormalColor toColor:self.itemSelectedColor] forState:UIControlStateNormal];
    [currentItem setTitleColor:[UIColor colorPercent:(percent * 100) fromColor:self.itemSelectedColor toColor:self.itemNormalColor] forState:UIControlStateNormal];
}

- (void)viewControllerWillDisappear:(NSUInteger)pageIndex
{
    if (pageIndex >= self.childViewControllers.count)
    {
        return;
    }
    
    UIViewController *viewController = [self.childViewControllers objectAtIndex:pageIndex];
    [viewController beginAppearanceTransition:NO animated:YES];
}

- (void)viewControllerWillAppear:(NSUInteger)pageIndex
{
    if (pageIndex >= self.childViewControllers.count)
    {
        return;
    }
    
    UIViewController *viewController = [self.childViewControllers objectAtIndex:pageIndex];
    [viewController beginAppearanceTransition:YES animated:YES];
}

- (void)viewControllerDidDisappear:(NSUInteger)pageIndex
{
    if (pageIndex >= self.childViewControllers.count)
    {
        return;
    }
    
    UIViewController *viewController = [self.childViewControllers objectAtIndex:pageIndex];
    [viewController endAppearanceTransition];
}

- (void)viewControllerDidAppear:(NSUInteger)pageIndex
{
    if (pageIndex >= self.childViewControllers.count)
    {
        return;
    }
    
    UIViewController *viewController = [self.childViewControllers objectAtIndex:pageIndex];
    [viewController endAppearanceTransition];
}

-(void)setCurrentPage:(NSUInteger)currentPage
{
    if (currentPage >= self.childViewControllers.count) {
        return;
    }
    
    NSInteger disIndex = _currentPage;
    _currentPage = currentPage;
    
    [self viewControllerDidDisappear:disIndex];
    [self viewControllerDidAppear:currentPage];
}

-(void)menuItemClicked:(UIButton *)sender
{
    if (sender.tag != self.currentPage)
    {
        [self switchToPage:sender.tag];
    }
}

-(void)switchToPage:(NSInteger)pageIndex
{
    [self viewControllerWillDisappear:self.currentPage];
    [self viewControllerWillAppear:pageIndex];
    
    isSkipUpdate = YES;
    [contentView setContentOffset:CGPointMake(contentView.width * pageIndex, 0) animated:NO];
    isSkipUpdate = NO;
    
    sliderView.left = pageIndex * (self.itemSize.width + self.itemSpacing);
    
    self.currentPage = pageIndex;
    
    for (int i = 0; i < menuArray.count; i++) {
        UIButton *menuItem = [menuArray objectAtIndex:i];
        if (i == pageIndex) {
            [menuItem setTitleColor:self.itemSelectedColor forState:UIControlStateNormal];
        }else{
            [menuItem setTitleColor:self.itemNormalColor forState:UIControlStateNormal];
        }
        [menuItem setNeedsLayout];
    }
    
    [menuBar scrollRectToVisible:CGRectMake(self.currentPage * (self.itemSize.width + self.itemSpacing), 0, 100, 100) animated:YES];

}

-(void)setAgainstStatusBar:(BOOL)againstStatusBar
{
    _againstStatusBar = againstStatusBar;
    [self.view setNeedsLayout];
}

-(void)setSliderStyle:(EZSliderStyle)sliderStyle
{
    _sliderStyle = sliderStyle;
    [self.view setNeedsLayout];
}

-(void)setBubbleRadius:(CGFloat)bubbleRadius
{
    _bubbleRadius = bubbleRadius;
    sliderView.layer.cornerRadius = bubbleRadius;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    for (int i = 0; i < menuArray.count; i++) {
        UIButton *menuItem = [menuArray objectAtIndex:i];
        if (i == self.currentPage) {
            [menuItem setTitleColor:self.itemSelectedColor forState:UIControlStateNormal];
        }else{
            [menuItem setTitleColor:self.itemNormalColor forState:UIControlStateNormal];
        }
    }
    
    [menuBar scrollRectToVisible:CGRectMake(self.currentPage * (self.itemSize.width + self.itemSpacing), 0, 100, 100) animated:YES];
}

@end
