//
//  NSObject+EZKit.h
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 Caesar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (EZKit)

+ (void)ez_hookMethod:(SEL)srcSel tarSel:(SEL)tarSel;

+ (void)ez_hookMethod:(SEL)srcSel tarClass:(NSString *)tarClassName tarSel:(SEL)tarSel;

+ (void)ez_hookMethod:(Class)srcClass srcSel:(SEL)srcSel tarClass:(Class)tarClass tarSel:(SEL)tarSel;

@end
