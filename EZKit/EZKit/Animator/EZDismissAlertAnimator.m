//
//  EZDismissAlertAnimator.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "EZDismissAlertAnimator.h"
#import <POP/POP.h>

@implementation EZDismissAlertAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *toVC = nil;
    id obj = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if ([obj isKindOfClass:[UIViewController class]])
    {
        if ([obj isKindOfClass:[UINavigationController class]])
        {
            toVC = ((UINavigationController *)obj).topViewController;
        }
        else
        {
            toVC = obj;
        }
    }
    else
    {
        [transitionContext completeTransition:YES];
        return;
    }
    
    toVC.view.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    toVC.view.userInteractionEnabled = YES;
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    __block UIView *dimmingView;
    [transitionContext.containerView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if (view.layer.opacity < 1.f) {
            dimmingView = view;
            *stop = YES;
        }
    }];
    
    POPBasicAnimation *alphaAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    alphaAnim.toValue = @(0.0);
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.0);
    
    POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)];
    [scaleAnim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
    [fromVC.view.layer pop_addAnimation:alphaAnim forKey:@"alphaAnim"];
    [fromVC.view.layer pop_addAnimation:scaleAnim forKey:@"scaleAnim"];
    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

@end
