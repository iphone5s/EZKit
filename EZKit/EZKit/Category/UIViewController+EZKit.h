//
//  UIViewController+EZKit.h
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^EZPresentDissmissCompletionBlock)(void);

typedef NS_ENUM(NSInteger, EZPresentAnimation) {
    EZPresentAnimationNone,
    EZPresentAnimationAlert,
};

@interface UIViewController (EZKit)

@property(nonatomic,assign)BOOL ez_isPush;

- (void)ez_presentViewController:(UIViewController *)viewController animatedType: (EZPresentAnimation)animation dismissCompletion:(EZPresentDissmissCompletionBlock)dissmiss;

- (void)ez_dismissViewControllerAnimated: (BOOL)flag completion: (void (^)(void))completion;

@end
