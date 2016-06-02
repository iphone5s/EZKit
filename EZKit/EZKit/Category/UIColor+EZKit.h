//
//  UIColor+EZKit.h
//  EZKit
//
//  Created by Ezreal on 16/5/6.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (EZKit)

+ (UIColor *)fromHexValue:(NSUInteger)hex;
+ (UIColor *)fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIColor *)fromShortHexValue:(NSUInteger)hex;
+ (UIColor *)fromShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha;

+ (UIImage*) createImageWithColor: (UIColor*) color;

+ (UIColor *) randomColor;

+(UIColor *)colorPercent:(CGFloat)percent fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor;

+ (NSUInteger) hexFromColor: (UIColor*) color;

@end
