//
//  NSArray+EZKit.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 Caesar. All rights reserved.
//

#import "NSArray+EZKit.h"
#import "NSObject+EZKit.h"

@implementation NSArray (EZKit)

- (instancetype)initWithObjects_safe:(id *)objects count:(NSUInteger)cnt
{
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!objects[i]) {
            break;
        }
        newCnt++;
    }
    self = [self initWithObjects_safe:objects count:newCnt];
    return self;
}

- (id)safe_objectAtIndex:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    return [self safe_objectAtIndex:index];
}

- (NSArray *)safe_arrayByAddingObject:(id)anObject
{
    if (!anObject) {
        return self;
    }
    return [self safe_arrayByAddingObject:anObject];
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ez_hookMethod:@selector(initWithObjects_safe:count:) tarClass:@"__NSPlaceholderArray" tarSel:@selector(initWithObjects:count:)];
        [self ez_hookMethod:@selector(safe_objectAtIndex:) tarClass:@"__NSArrayI" tarSel:@selector(objectAtIndex:)];
        [self ez_hookMethod:@selector(safe_arrayByAddingObject:) tarClass:@"__NSArrayI" tarSel:@selector(arrayByAddingObject:)];
    });
}

@end
