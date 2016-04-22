//
//  EZPresentAlertAnimator.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "EZPresentAlertAnimator.h"
#import "EZDeviceManagement.h"
#import <POP/POP.h>
#import <Masonry.h>

@implementation EZPresentAlertAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5f;
}
#pragma mark -handleSingleTap
-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    fromViewController.view.userInteractionEnabled = NO;
    
    UIView *dimmingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,EZSharedDevice.screenWidth, EZSharedDevice.screenHeight)];
    dimmingView.backgroundColor = [UIColor blackColor];
    dimmingView.layer.opacity = 0.0;
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
//    id obj = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    if ([toViewController isKindOfClass:[UIViewController class]])
    {
        if ([toViewController isKindOfClass:[UINavigationController class]])
        {
            UIViewController *vc = ((UINavigationController *)toViewController).topViewController;
            
            toViewController.view.frame = vc.view.frame;
            
            if ([vc respondsToSelector:@selector(handleSingleTap:)])
            {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:vc action:@selector(handleSingleTap:)];
                [dimmingView addGestureRecognizer:tap];
            }
        }
        else
        {
            if ([toViewController respondsToSelector:@selector(handleSingleTap:)])
            {
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:toViewController action:@selector(handleSingleTap:)];
                [dimmingView addGestureRecognizer:tap];
            }
            
        }
    }
    else
    {
        [transitionContext completeTransition:YES];
        return;
    }
    
    toViewController.view.center = CGPointMake(transitionContext.containerView.center.x, -transitionContext.containerView.center.y);
    
    [transitionContext.containerView addSubview:dimmingView];
    
    [transitionContext.containerView addSubview:toViewController.view];
    
    [dimmingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(transitionContext.containerView);
        make.center.mas_equalTo(transitionContext.containerView);
    }];
    
    toViewController.view.center = transitionContext.containerView.center;
    toViewController.view.autoresizingMask = UIViewAutoresizingNone;
    
    toViewController.view.alpha = 0.0;
    
    POPBasicAnimation *alphaAnim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    alphaAnim.toValue = @(1.0);
    
    POPSpringAnimation *scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)];
    scaleAnim.springBounciness = 8;
    [scaleAnim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.4);
    
    [toViewController.view.layer pop_addAnimation:alphaAnim forKey:@"alphaAnim"];
    [toViewController.view.layer pop_addAnimation:scaleAnim forKey:@"scaleAnim"];
    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

@end
