//
//  NSMutableArray+EZKit.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "NSMutableArray+EZKit.h"
#import "NSObject+EZKit.h"
#import "EZKitDefine.h"

@implementation NSMutableArray (EZKit)

- (id)ez_objectAtIndex:(NSUInteger)index {
    if (index >= [self count])
    {
        #ifdef DEBUG
            ez_debug_msg(@"数组越界");
        #endif
        return nil;
    }
    return [self ez_objectAtIndex:index];
}


- (void)ez_addObject:(id)anObject
{
    if (!anObject)
    {
        return;
    }
    [self ez_addObject:anObject];
}

- (void)ez_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (index > [self count])
    {
        return;
    }
    if (!anObject) {
        return;
    }
    [self ez_insertObject:anObject atIndex:index];
}

- (void)ez_removeObjectAtIndex:(NSUInteger)index
{
    if (index >= [self count])
    {
        return;
    }
    
    return [self ez_removeObjectAtIndex:index];
}

- (void)ez_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index >= [self count])
    {
        return;
    }
    if (!anObject) {
        return;
    }
    [self ez_replaceObjectAtIndex:index withObject:anObject];
}

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ez_hookMethod:@selector(ez_objectAtIndex:) tarClass:@"__NSArrayM" tarSel:@selector(objectAtIndex:)];
        [self ez_hookMethod:@selector(ez_addObject:) tarClass:@"__NSArrayM" tarSel:@selector(addObject:)];
        [self ez_hookMethod:@selector(ez_insertObject:atIndex:) tarClass:@"__NSArrayM" tarSel:@selector(insertObject:atIndex:)];
        [self ez_hookMethod:@selector(ez_removeObjectAtIndex:) tarClass:@"__NSArrayM" tarSel:@selector(removeObjectAtIndex:)];
        [self ez_hookMethod:@selector(ez_replaceObjectAtIndex:withObject:) tarClass:@"__NSArrayM" tarSel:@selector(replaceObjectAtIndex:withObject:)];
    });
}

@end
