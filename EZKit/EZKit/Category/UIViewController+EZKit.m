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

static const void *animationKey = &animationKey;

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


- (void)ez_presentViewController:(UIViewController *)viewController animatedType: (EZPresentAnimation)animation completion:(void (^ )(void))completion
{
    self.animation = animation;
    
    switch (self.animation)
    {
        case EZPresentAnimationNone:
        {
            
        }
            break;
        case EZPresentAnimationAlert:
        {
            viewController.modalPresentationStyle = UIModalPresentationCustom;
            viewController.transitioningDelegate = self;
        }
            break;
        default:
            break;
    }
    
    [self presentViewController:viewController animated:YES completion:completion];
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
