//
//  UIView+EZKit.h
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (EZKit)

@property(nonatomic) CGFloat ez_left;
@property(nonatomic) CGFloat ez_top;
@property(nonatomic) CGFloat ez_right;
@property(nonatomic) CGFloat ez_bottom;

@property(nonatomic) CGFloat ez_width;
@property(nonatomic) CGFloat ez_height;

@property(nonatomic) CGFloat ez_centerX;
@property(nonatomic) CGFloat ez_centerY;

@property(nonatomic,readonly) CGFloat ez_screenX;
@property(nonatomic,readonly) CGFloat ez_screenY;
@property(nonatomic,readonly) CGFloat ez_screenViewX;
@property(nonatomic,readonly) CGFloat ez_screenViewY;
@property(nonatomic,readonly) CGRect ez_screenFrame;

@property(nonatomic) CGPoint ez_origin;
@property(nonatomic) CGSize ez_size;

@end
