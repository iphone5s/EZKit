//
//  UIViewController+EZKit.h
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EZPresentAnimation) {
    EZPresentAnimationNone,
    EZPresentAnimationAlert,
};

@interface UIViewController (EZKit)

- (void)ez_presentViewController:(UIViewController *)viewController animatedType: (EZPresentAnimation)animation completion:(void (^ )(void))completion;

- (void)ez_dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion;
@end
