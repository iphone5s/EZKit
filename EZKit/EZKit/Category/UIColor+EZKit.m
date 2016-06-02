//
//  UIColor+EZKit.m
//  EZKit
//
//  Created by Ezreal on 16/5/6.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "UIColor+EZKit.h"

@implementation UIColor (EZKit)

+ (UIColor *)fromHexValue:(NSUInteger)hex
{
    NSUInteger a = ((hex >> 24) & 0x000000FF);
    float fa = ((0 == a) ? 1.0f : (a * 1.0f) / 255.0f);
    
    return [UIColor fromHexValue:hex alpha:fa];
}

+ (UIColor *)fromHexValue:(NSUInteger)hex alpha:(CGFloat)alpha
{
    if ( hex == 0xECE8E3 ) {
        
    }
    NSUInteger r = ((hex >> 16) & 0x000000FF);
    NSUInteger g = ((hex >> 8) & 0x000000FF);
    NSUInteger b = ((hex >> 0) & 0x000000FF);
    
    float fr = (r * 1.0f) / 255.0f;
    float fg = (g * 1.0f) / 255.0f;
    float fb = (b * 1.0f) / 255.0f;
    
    return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}

+ (UIColor *)fromShortHexValue:(NSUInteger)hex
{
    return [UIColor fromShortHexValue:hex alpha:1.0f];
}

+ (UIColor *)fromShortHexValue:(NSUInteger)hex alpha:(CGFloat)alpha
{
    NSUInteger r = ((hex >> 8) & 0x0000000F);
    NSUInteger g = ((hex >> 4) & 0x0000000F);
    NSUInteger b = ((hex >> 0) & 0x0000000F);
    
    float fr = (r * 1.0f) / 15.0f;
    float fg = (g * 1.0f) / 15.0f;
    float fb = (b * 1.0f) / 15.0f;
    
    return [UIColor colorWithRed:fr green:fg blue:fb alpha:alpha];
}

+ (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIColor *) randomColor
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (NSUInteger) hexFromColor: (UIColor*) color
{
    if (CGColorGetNumberOfComponents(color.CGColor) < 4)
    {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return 0xffffff;
    }
    
    NSUInteger hex = 0x000000;
    
    hex = (hex << 0)|(int)((CGColorGetComponents(color.CGColor))[0]*255.0);
    
    hex = (hex << 8)|(int)((CGColorGetComponents(color.CGColor))[1]*255.0);
    
    hex = (hex << 8)|(int)((CGColorGetComponents(color.CGColor))[2]*255.0);;
    
    return hex;
}

+(UIColor *)colorPercent:(CGFloat)percent fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor
{
    NSUInteger fromColorHex = [UIColor hexFromColor:fromColor];
    NSUInteger toColorHex = [UIColor hexFromColor:toColor];
    
    NSUInteger r1 = ((fromColorHex >> 16) & 0x000000FF);
    NSUInteger g1 = ((fromColorHex >> 8) & 0x000000FF);
    NSUInteger b1 = ((fromColorHex >> 0) & 0x000000FF);
    
    NSUInteger r2 = ((toColorHex >> 16) & 0x000000FF);
    NSUInteger g2 = ((toColorHex >> 8) & 0x000000FF);
    NSUInteger b2 = ((toColorHex >> 0) & 0x000000FF);
    
    int r_ = (int)(r1 - r2);
    int g_ = (int)(g1 - g2);
    int b_ = (int)(b1 - b2);
    CGFloat r_v = r_ / 100.0;
    CGFloat g_v = g_ / 100.0;
    CGFloat b_v = b_ / 100.0;
    
    int r__ = round(r_v * percent);
    int g__ = round(g_v * percent);
    int b__ = round(b_v * percent);
    NSInteger r = r1 - r__;
    NSInteger g = g1 - g__;
    NSInteger b = b1 - b__;
    return [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1];
}

@end
