//
//  Argument.m
//  EZKit
//
//  Created by Ezreal on 16/5/12.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "Argument.h"

@implementation Argument

-(NSDictionary *)requestUrlArgument
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"A" forKey:@"username"];
    [dict setValue:@"b" forKey:@"password"];
    return dict;
}

-(NSDictionary *)requestCookieArgument
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"123" forKey:@"username"];
    [dict setValue:@"456" forKey:@"password"];
    return dict;
}

-(NSDictionary *)responseArgument:(NSDictionary *)data
{
    NSDictionary *dict = [NSDictionary dictionary];
    return dict;
}

-(EZResponseMethod)responseMethod
{
    return EZResponseMethodCache2;
}
@end
