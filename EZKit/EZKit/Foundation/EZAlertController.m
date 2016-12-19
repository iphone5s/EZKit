//
//  EZAlertController.m
//  EZKit
//
//  Created by Ezreal on 2016/12/7.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "EZAlertController.h"
#import <Masonry.h>
#import <POP/POP.h>

#define ISIOS7LANDSCAPE (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)

@interface EZAlertController ()
{
    UIView *m_maskView;
    UIWindow *m_alertWindow;
    UIWindow *m_previousWindow;
}
@end

@implementation EZAlertController

- (instancetype)init
{
    self = [super init];
    if (self) {
     
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ez_showAlert
{
    m_previousWindow = [UIApplication sharedApplication].keyWindow;
    m_previousWindow.userInteractionEnabled =NO;
    
    m_alertWindow = [[UIWindow alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    m_alertWindow.windowLevel = UIWindowLevelAlert;
    m_alertWindow.backgroundColor = [UIColor clearColor];
    m_alertWindow.rootViewController = self;
    m_alertWindow.userInteractionEnabled = NO;
    
    m_maskView = [UIView new];
    [m_alertWindow addSubview:m_maskView];
    m_maskView.backgroundColor = [UIColor blackColor];
    m_maskView.layer.opacity = 0.0;
    [m_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(m_alertWindow);
    }];
    [m_alertWindow addSubview:self.view];
    
    [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view.frame.size);
        make.center.mas_equalTo(m_alertWindow);
    }];
    
    [m_alertWindow makeKeyAndVisible];
    
    [self showAnimation];
//    [self showAnimationBounce];
}

-(void)showAnimation
{
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:(ISIOS7LANDSCAPE ? kPOPLayerPositionX : kPOPLayerPositionY)];
    id positionFromValue;
    id positionToValue;
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
    {
        if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortrait)
        {
            positionFromValue = @(-self.view.frame.size.height);
            positionToValue = @(m_alertWindow.center.y);
        }
        else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            positionFromValue = @([UIScreen mainScreen].bounds.size.height + self.view.frame.size.height / 2.0);
            positionToValue = @(m_alertWindow.center.y);
        }
        else if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft)
        {
            positionFromValue = @([UIScreen mainScreen].bounds.size.width + self.view.frame.size.width / 2.0);
            positionToValue = @(m_alertWindow.center.x);
        }
        else if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
        {
            positionFromValue = @(- self.view.frame.size.width / 2.0);
            positionToValue = @(m_alertWindow.center.x);
        }
        else
        {
            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
            {
                positionFromValue = @(m_alertWindow.center.x);
                positionToValue = @(m_alertWindow.center.x);
            }
            else
            {
                positionFromValue = @(m_alertWindow.center.y);
                positionToValue = @(m_alertWindow.center.y);
            }
        }
        
    }
    else
    {
        positionFromValue = @(-self.view.frame.size.height);
        positionToValue = @(m_alertWindow.center.y);
    }
    
    positionAnimation.fromValue = positionFromValue;
    positionAnimation.toValue = positionToValue;
    positionAnimation.springBounciness = 10;
    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        m_alertWindow.userInteractionEnabled = YES;
    }];
    
    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.springBounciness = 20;
    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(0.0);
    opacityAnimation.toValue = @(0.5);
    
    [self.view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    [m_maskView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    [self.view.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
}

-(void)showAnimationBounce
{
    POPSpringAnimation *positionAnimation = [POPSpringAnimation animationWithPropertyNamed:(ISIOS7LANDSCAPE ? kPOPLayerPositionX : kPOPLayerPositionY)];
    id positionFromValue;
    id positionToValue;
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
    {
        if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortrait)
        {
            positionFromValue = @(-self.view.frame.size.height);
            positionToValue = @(m_alertWindow.center.y);
        }
        else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            positionFromValue = @([UIScreen mainScreen].bounds.size.height + self.view.frame.size.height / 2.0);
            positionToValue = @(m_alertWindow.center.y);
        }
        else if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft)
        {
            positionFromValue = @([UIScreen mainScreen].bounds.size.width + self.view.frame.size.width / 2.0);
            positionToValue = @(m_alertWindow.center.x);
        }
        else if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
        {
            positionFromValue = @(- self.view.frame.size.width / 2.0);
            positionToValue = @(m_alertWindow.center.x);
        }
        else
        {
            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
            {
                positionFromValue = @(m_alertWindow.center.x);
                positionToValue = @(m_alertWindow.center.x);
            }
            else
            {
                positionFromValue = @(m_alertWindow.center.y);
                positionToValue = @(m_alertWindow.center.y);
            }
        }
        
    }
    else
    {
        positionFromValue = @(-self.view.frame.size.height);
        positionToValue = @(m_alertWindow.center.y);
    }
    
    positionAnimation.fromValue = positionFromValue;
    positionAnimation.toValue = positionToValue;
    positionAnimation.springBounciness = 13;
    positionAnimation.springSpeed = 20;
    [positionAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        m_alertWindow.userInteractionEnabled = YES;
    }];
    
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.springBounciness = 20;
//    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.4)];
//    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(0.0);
    opacityAnimation.toValue = @(0.5);
    
//    [self.view.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    [m_maskView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    [self.view.layer pop_addAnimation:positionAnimation forKey:@"positionAnimation"];
}

-(void)hideAnimation:(void (^ __nullable)(void))completion
{
    POPBasicAnimation *offscreenAnimation = [POPBasicAnimation animationWithPropertyNamed:(ISIOS7LANDSCAPE ? kPOPLayerPositionX : kPOPLayerPositionY)];
    
    id positionToValue;
    
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1)
    {
        if([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationPortrait)
        {
            positionToValue = @([UIScreen mainScreen].bounds.size.height + self.view.frame.size.height / 2.0 - 10);
        }
        else if ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown)
        {
            positionToValue = @(-self.view.frame.size.height / 2.0);
            
        }
        else if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeLeft)
        {
            positionToValue = @(- self.view.frame.size.width / 2.0 + 10);
        }
        else if ([UIApplication sharedApplication].statusBarOrientation == UIDeviceOrientationLandscapeRight)
        {
            positionToValue = @([UIScreen mainScreen].bounds.size.width + self.view.frame.size.width / 2.0 -10);
        }
        else
        {
            if (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
            {
                positionToValue = @(m_alertWindow.center.x);
            }
            else
            {
                positionToValue = @(m_alertWindow.center.y);
            }
        }
    }
    else
    {
        positionToValue = @([UIScreen mainScreen].bounds.size.height + self.view.layer.frame.size.height / 2.0);
    }
    offscreenAnimation.toValue = positionToValue;
    [offscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        if (completion != nil)
        {
            completion();
        }
    }];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.fromValue = @(0.5);
    opacityAnimation.toValue = @(0.0);
    
    [self.view.layer pop_addAnimation:offscreenAnimation forKey:@"offscreenAnimation"];
    [m_maskView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
}

-(void)ez_hideAlert:(void (^ __nullable)(void))completion
{
    m_alertWindow.userInteractionEnabled = NO;
    
    [self hideAnimation:^{
        [self.view removeFromSuperview];
        [m_previousWindow makeKeyWindow];
        m_previousWindow.userInteractionEnabled = YES;
        
        
        m_alertWindow = nil;
        m_previousWindow = nil;
        
        if (completion != nil)
        {
            completion();
        }
    }];
}

-(void)dealloc
{

}

@end
