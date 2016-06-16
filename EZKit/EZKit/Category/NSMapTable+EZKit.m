//
//  NSMapTable+EZKit.m
//  EZKit
//
//  Created by Ezreal on 16/6/16.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "NSMapTable+EZKit.h"

FOUNDATION_EXPORT NSArray *NSAllMapTableKeys(NSMapTable *table);
FOUNDATION_EXPORT NSArray *NSAllMapTableValues(NSMapTable *table);

@implementation NSMapTable (EZKit)

- (NSArray *) allKeys
{
    NSAllMapTableKeys(self);
    return nil;
}

- (NSArray *)allKeysForObject:(NSObject *)anObject
{
    NSMutableArray *array = [NSMutableArray new];

    for (NSObject *objectKey in self.allKeys)
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
