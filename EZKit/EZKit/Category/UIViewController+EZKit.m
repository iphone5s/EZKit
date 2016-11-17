//
//  UIViewController+EZKit.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "UIViewController+EZKit.h"
#import "EZPresentAlertAnimator.h"
#import "EZDismissAlertAnimator.h"
#import <objc/runtime.h>
#import "EZKitDefine.h"
#import "NSObject+EZKit.h"


static const void *ez_animationKey = &ez_animationKey;

static const void *ez_isPushKey = &ez_isPushKey;

static const void *ez_dissmissKey = &ez_dissmissKey;

static const void *ez_isPresentedKey = &ez_isPresentedKey;

static const void *ez_rectKey = &ez_rectKey;

@interface UIViewController ()<UIViewControllerTransitioningDelegate,UIViewControllerTransitioningDelegate>

@property(nonatomic,copy)EZPresentDissmissCompletionBlock dissmissComple;

@property(nonatomic,assign)EZPresentAnimation animation;

@property(nonatomic,assign)BOOL ez_isPresented;

@property(nonatomic,assign)CGRect ez_rect;

@end


@interface EZModalVCManager : NSObject
{
    NSMutableArray *modalViewControllers;
}
@end

@implementation EZModalVCManager

DEF_SINGLETON(EZModalVCManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        modalViewControllers = [NSMutableArray new];
    }
    return self;
}

-(void)presentVC:(UIViewController *)vc
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [modalViewControllers addObject:vc];
    
    if (appRootVC.presentedViewController == nil)
    {
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            @try {
                [appRootVC presentViewController:vc animated:YES completion:nil];
            } @catch (NSException *exception) {

            } @finally {
                
            }
            
        });
    }
    else
    {
        __weak EZModalVCManager *weakSelf = self;
        [appRootVC dismissViewControllerAnimated:YES completion:^{
            [weakSelf present];
        }];
    }
}

-(void)present
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *presentVC = [modalViewControllers lastObject];
    
    while (presentVC != nil && presentVC.ez_isPush == NO)
    {
        [modalViewControllers removeObject:presentVC];
        presentVC = [modalViewControllers lastObject];
    }
    
    if (presentVC != nil)
    {
        [appRootVC presentViewController:presentVC animated:YES completion:nil];
    }
    else
    {
        
    }
}

-(void)popVC
{
    UIViewController *vc = [modalViewControllers lastObject];
    [modalViewControllers removeLastObject];
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    __weak EZModalVCManager *weakSelf = self;
    __weak EZPresentDissmissCompletionBlock dissmissblock = vc.dissmissComple;
    [appRootVC dismissViewControllerAnimated:YES completion:^{
        [weakSelf present];
        if (dissmissblock != nil) {
            dissmissblock();
        }
    }];

}

@end


@implementation UIViewController (EZKit)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ez_hookMethod:@selector(viewWillLayoutSubviews) tarSel:@selector(ez_viewWillLayoutSubviews)];
    });
}

-(void)ez_viewWillLayoutSubviews
{
    [self ez_viewWillLayoutSubviews];
    
    if (self.ez_isPresented)
    {
        self.view.frame = self.ez_rect;
    }
}

-(EZPresentDissmissCompletionBlock)dissmissComple
{
    id obj = objc_getAssociatedObject(self, ez_dissmissKey);
    return obj;
}

-(void)setDissmissComple:(EZPresentDissmissCompletionBlock)dissmissComple
{
    objc_setAssociatedObject(self, ez_dissmissKey, dissmissComple, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(EZPresentAnimation)animation
{
    NSNumber *num = objc_getAssociatedObject(self, ez_animationKey);
    return num.integerValue;
}

-(void)setAnimation:(EZPresentAnimation)animation
{
    objc_setAssociatedObject(self, ez_animationKey, [NSNumber numberWithInteger:animation], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)ez_isPush
{
    NSNumber *num = objc_getAssociatedObject(self, ez_isPushKey);
    if (num != nil)
    {
        return num.integerValue;
    }
    else
    {
        return YES;
    }
    
}

-(BOOL)ez_isPresented
{
    NSNumber *num = objc_getAssociatedObject(self, ez_isPresentedKey);
    if (num != nil)
    {
        return num.integerValue;
    }
    else
    {
        return NO;
    }
}

-(CGRect)ez_rect
{
    NSValue *value = objc_getAssociatedObject(self, ez_rectKey);
    if (value != nil)
    {
        return value.CGRectValue;
    }
    else
    {
        return [UIScreen mainScreen].bounds;
    }
}

-(void)setEz_isPush:(BOOL)ez_isPush
{
    objc_setAssociatedObject(self, ez_isPushKey, [NSNumber numberWithInteger:ez_isPush], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setEz_isPresented:(BOOL)ez_isPresented
{
    objc_setAssociatedObject(self, ez_isPresentedKey, [NSNumber numberWithInteger:ez_isPresented], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)setEz_rect:(CGRect)ez_rect
{
    objc_setAssociatedObject(self, ez_rectKey, [NSValue valueWithCGRect:ez_rect], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ez_presentViewController:(UIViewController *)viewController animatedType: (EZPresentAnimation)animation dismissCompletion:(EZPresentDissmissCompletionBlock)dissmiss;
{
    self.animation = animation;

    viewController.dissmissComple = dissmiss;
    viewController.ez_isPresented = YES;
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;

    switch (self.animation)
    {
        case EZPresentAnimationNone:
        {
            
        }
            break;
        case EZPresentAnimationAlert:
        {
            viewController.modalPresentationStyle = UIModalPresentationCustom;
            viewController.transitioningDelegate = appRootVC;
            
            viewController.ez_rect = CGRectMake(([UIScreen mainScreen].bounds.size.width - viewController.view.frame.size.width) / 2.0, ([UIScreen mainScreen].bounds.size.height - viewController.view.frame.size.height) / 2.0, viewController.view.frame.size.width, viewController.view.frame.size.height);
        }
            break;
        default:
            break;
    }
    
    [[EZModalVCManager sharedInstance]presentVC:viewController];
    
}

- (void)ez_dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion
{
    [[EZModalVCManager sharedInstance]popVC];
}
#pragma mark - UIViewControllerTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    switch (self.animation)
    {
        case EZPresentAnimationAlert:
        {
            return [EZPresentAlertAnimator new];
        }
            break;
        default:
        {
            return [EZPresentAlertAnimator new];
        }
            break;
    }
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    switch (self.animation)
    {
        case EZPresentAnimationAlert:
        {
            return [EZDismissAlertAnimator new];
        }
            break;
        default:
        {
            return [EZDismissAlertAnimator new];
        }
            break;
    }
}

@end
