//
//  NSDictionary+EZKit.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "NSDictionary+EZKit.h"

@implementation NSDictionary (EZKit)

-(NSString *)ez_stringForKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]])
    {
        return obj;
    }
    else if([obj isKindOfClass:[NSNumber class]])
    {
        return [obj stringFromNumber:obj];
    }
    else
    {
        return obj;
    }
}

@end
