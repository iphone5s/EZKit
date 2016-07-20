//
//  NSString+EZKit.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "NSString+EZKit.h"
#import "NSObject+EZKit.h"
@implementation NSString (EZKit)

- (unichar)ez_characterAtIndex:(NSUInteger)index
{
    if (index >= [self length])
    {
        return 0;
    }
    return [self ez_characterAtIndex:index];
}

- (NSString *)ez_substringWithRange:(NSRange)range
{
    if (range.location + range.length > self.length)
    {
        return @"";
    }
    return [self ez_substringWithRange:range];
}

+ (void) load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ez_hookMethod:@selector(ez_characterAtIndex:) tarClass:@"__NSCFString" tarSel:@selector(characterAtIndex:)];
        [self ez_hookMethod:@selector(ez_substringWithRange:) tarClass:@"__NSCFString" tarSel:@selector(substringWithRange:)];
    });
}

@end
