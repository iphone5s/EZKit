//
//  NSMutableArray+EZKitMRC.m
//  EZKit
//
//  Created by Ezreal on 16/7/20.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "NSMutableArray+EZKitMRC.h"
#import "NSObject+EZKit.h"

@implementation NSMutableArray (EZKitMRC)

- (id)ez_objectAtIndex:(NSUInteger)index {
    if (index >= [self count]) {
        return nil;
    }
    return [self ez_objectAtIndex:index];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ez_hookMethod:@selector(ez_objectAtIndex:) tarClass:@"__NSArrayM" tarSel:@selector(objectAtIndex:)];
    });
}

@end
