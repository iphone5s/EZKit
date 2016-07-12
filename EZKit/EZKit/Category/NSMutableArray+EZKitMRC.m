//
//  NSMutableArray+EZKitMRC.m
//  EZKit
//
//  Created by Ezreal on 16/7/12.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "NSMutableArray+EZKitMRC.h"
#import "NSObject+EZKit.h"
#import "EZKitDefine.h"

@implementation NSMutableArray (EZKitMRC)

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

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ez_hookMethod:@selector(ez_objectAtIndex:) tarClass:@"__NSArrayM" tarSel:@selector(objectAtIndex:)];
    });
}

@end
