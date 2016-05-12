//
//  EZNetworkArgument.m
//  EZKit
//
//  Created by Ezreal on 16/5/12.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "EZNetworkArgument.h"

@implementation EZNetworkArgument

-(NSDictionary *)requestArgument
{
    NSDictionary *dict = [NSDictionary dictionary];
    [dict setValue:@"123" forKey:@"username"];
    [dict setValue:@"456" forKey:@"password"];
    return dict;
}

-(NSDictionary *)responseArgument
{
    return nil;
}

@end
