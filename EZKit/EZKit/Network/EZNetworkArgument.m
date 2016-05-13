//
//  EZNetworkArgument.m
//  EZKit
//
//  Created by Ezreal on 16/5/13.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "EZNetworkArgument.h"
#import "NSDictionary+EZKit.h"

@implementation EZNetworkArgument

-(NSDictionary *)requestUrlArgument
{
    return nil;
}

-(NSDictionary *)requestCookieArgument
{
    return nil;
}

-(BOOL)responseArgument:(NSDictionary *)dict
{
    return nil;
}

- (EZResponseMethod)responseMethod {
    return EZResponseMethodDefault;
}

-(NSString *)strUrlArgument
{
    NSDictionary *dict = [self requestUrlArgument];
    NSString *strArgument=@"";
    for (NSString *key in dict.allKeys)
    {
        NSString *strValue = [dict ez_stringForKey:key];
        strArgument = [NSString stringWithFormat:@"%@&%@=%@",strArgument,key,strValue];
    }
    
    return strArgument;
}


@end
