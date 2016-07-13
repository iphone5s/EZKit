//
//  NSMapTable+EZKit.m
//  EZKit
//
//  Created by Ezreal on 16/6/16.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "NSMapTable+EZKit.h"

@implementation NSMapTable (EZKit)

- (NSArray *) ez_allKeys
{
    return [[self keyEnumerator]allObjects];
}

- (NSArray *)ez_allKeysForObject:(NSObject *)anObject
{
    NSMutableArray *array = [NSMutableArray new];
    
    for (NSObject *objectKey in self.ez_allKeys)
    {
        NSObject *objectValue = [self objectForKey:objectKey];
        if ([anObject isEqual:objectValue])
        {
            [array addObject:objectKey];
        }
    }
    
    return array;
}

@end
