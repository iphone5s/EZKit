//
//  NSObject+EZKit.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 Caesar. All rights reserved.
//

#import "NSObject+EZKit.h"
#import <objc/runtime.h>

@implementation NSObject (EZKit)

+ (void)ez_hookMethod:(SEL)srcSel tarSel:(SEL)tarSel
{
    Class clazz = [self class];
    [self ez_hookMethod:clazz srcSel:srcSel tarClass:clazz tarSel:tarSel];
}

+ (void)ez_hookMethod:(SEL)srcSel tarClass:(NSString *)tarClassName tarSel:(SEL)tarSel
{
    if (!tarClassName)
    {
        return;
    }
    Class srcClass = [self class];
    Class tarClass = NSClassFromString(tarClassName);
    [self ez_hookMethod:srcClass srcSel:srcSel tarClass:tarClass tarSel:tarSel];
}

+ (void)ez_hookMethod:(Class)srcClass srcSel:(SEL)srcSel tarClass:(Class)tarClass tarSel:(SEL)tarSel
{
    if (!srcClass) {
        return;
    }
    if (!srcSel) {
        return;
    }
    if (!tarClass) {
        return;
    }
    if (!tarSel) {
        return;
    }
    Method srcMethod = class_getInstanceMethod(srcClass,srcSel);
    Method tarMethod = class_getInstanceMethod(tarClass,tarSel);
    method_exchangeImplementations(srcMethod, tarMethod);
}


@end
