//
//  UIView+EZKit.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "UIView+EZKit.h"

@implementation UIView (EZKit)

- (CGFloat)ez_left {
    return self.frame.origin.x;
}

- (void)setEz_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)ez_top {
    return self.frame.origin.y;
}

- (void)setEz_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)ez_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setEz_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)ez_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setEz_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)ez_centerX {
    return self.center.x;
}

- (void)setEz_CenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)ez_centerY {
    return self.center.y;
}

- (void)setEz_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)ez_width {
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return self.frame.size.height;
    }
    return self.frame.size.width;
}

- (void)setEz_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)ez_height {
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return self.frame.size.width;
    }
    return self.frame.size.height;
}

- (void)setEz_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)ez_screenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.ez_left;
    }
    return x;
}

- (CGFloat)ez_screenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.ez_top;
    }
    return y;
}

- (CGFloat)ez_screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.ez_left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)ez_screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.ez_top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)ez_screenFrame {
    return CGRectMake(self.ez_screenViewX, self.ez_screenViewY, self.ez_width, self.ez_height);
}

- (CGPoint)ez_origin {
    return self.frame.origin;
}

- (void)setEz_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)ez_size {
    return self.frame.size;
}

- (void)setEz_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
