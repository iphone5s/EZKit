//
//  NSArray+EZKit.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 Caesar. All rights reserved.
//

#import "NSArray+EZKit.h"
#import "NSObject+EZKit.h"
#import "EZKitDefine.h"

@implementation NSArray (EZKit)

- (instancetype)initWithObjects_ez:(id *)objects count:(NSUInteger)cnt
{
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++)
    {
        if (!objects[i])
        {
            break;
        }
        newCnt++;
    }
    self = [self initWithObjects_ez:objects count:newCnt];
    return self;
}

- (id)ez_objectAtIndex:(NSUInteger)index
{
    if (index >= [self count])
    {
        #ifdef DEBUG 
            ez_debug_msg(@"数组越界");
        #endif
        return nil;
    }
    return [self ez_objectAtIndex:index];
}

- (id)ez0_objectAtIndex:(NSUInteger)index
{
    if (index >= [self count])
    {
#ifdef DEBUG
        ez_debug_msg(@"数组越界");
#endif
        return nil;
    }
    return [self ez_objectAtIndex:index];
}

- (NSArray *)ez_arrayByAddingObject:(id)anObject
{
    if (!anObject) {
        return self;
    }
    return [self ez_arrayByAddingObject:anObject];
}

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ez_hookMethod:@selector(initWithObjects_ez:count:) tarClass:@"__NSPlaceholderArray" tarSel:@selector(initWithObjects:count:)];
        [self ez_hookMethod:@selector(ez_objectAtIndex:) tarClass:@"__NSArrayI" tarSel:@selector(objectAtIndex:)];
        [self ez_hookMethod:@selector(ez0_objectAtIndex:) tarClass:@"__NSArray0" tarSel:@selector(objectAtIndex:)];
        [self ez_hookMethod:@selector(ez_arrayByAddingObject:) tarClass:@"__NSArrayI" tarSel:@selector(arrayByAddingObject:)];
    });
}

-(NSArray *)ez_objectsAtIndexes:(NSIndexSet *)indexes
{
    if (self.count > indexes.firstIndex && self.count > indexes.lastIndex)
    {
        return [self objectsAtIndexes:indexes];
    }
    else
    {
        return [self objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(indexes.firstIndex, self.count - indexes.firstIndex)]];
    }
    return [NSArray array];
}

@end
