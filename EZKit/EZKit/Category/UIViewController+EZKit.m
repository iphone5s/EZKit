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

-(void)removeVC:(UIViewController *)vc
{
    [modalViewControllers removeObject:vc];
}

//-(UIViewController *)getVC
//{
//    if (modalViewControllers.count > 2)
//    {
//        return [modalViewControllers objectAtIndex:modalViewControllers.count - 2];
//    }
//    else
//    {
//        return nil;
//    }
//}

-(void)presentVC:(UIViewController *)vc
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    [modalViewControllers addObject:vc];
    
    if (appRootVC.presentedViewController == nil)
    {
        if (vc.ez_isPush == NO)
        {
            [modalViewControllers removeObject:vc];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^
        {
            [appRootVC presentViewController:vc animated:YES completion:nil];
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
    
    if (presentVC.ez_isPush == NO)
    {
        [modalViewControllers removeObject:presentVC];
    }
    
    if (presentVC != nil)
    {
        [appRootVC presentViewController:presentVC animated:YES completion:nil];
    }
    else
    {
        
    }
}

-(void)popVC:(UIViewController *)viewController
{
    [modalViewControllers removeObject:viewController];
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    __weak EZModalVCManager *weakSelf = self;
    [appRootVC dismissViewControllerAnimated:YES completion:^{
        [weakSelf present];
    }];

}

@end

static const void *animationKey = &animationKey;

static const void *ez_isPushKey = &ez_isPushKey;

@interface UIViewController ()<UIViewControllerTransitioningDelegate,UIViewControllerTransitioningDelegate>

@property(nonatomic,assign)EZPresentAnimation animation;

@end

@implementation UIViewController (EZKit)

-(EZPresentAnimation)animation
{
    NSNumber *num = objc_getAssociatedObject(self, animationKey);
    return num.integerValue;
}

-(void)setAnimation:(EZPresentAnimation)animation
{
    objc_setAssociatedObject(self, animationKey, [NSNumber numberWithInteger:animation], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

-(void)setEz_isPush:(BOOL)ez_isPush
{
    if (ez_isPush == NO)
    {
        [[EZModalVCManager sharedInstance]removeVC:self];
    }
    else
    {
        
    }
    
    objc_setAssociatedObject(self, ez_isPushKey, [NSNumber numberWithInteger:ez_isPush], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ez_presentViewController:(UIViewController *)viewController animatedType: (EZPresentAnimation)animation completion:(void (^ )(void))completion
{
    self.animation = animation;
    
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
        }
            break;
        default:
            break;
    }
    
    [[EZModalVCManager sharedInstance]presentVC:viewController];
    
}

- (void)ez_dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion
{
    [[EZModalVCManager sharedInstance]popVC:self];
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
