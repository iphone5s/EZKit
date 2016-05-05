//
//  TestApi.m
//  EZKit
//
//  Created by Caesar on 16/5/4.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "TestApi.h"

@implementation TestApi

- (NSString *)requestUrl {
    return @"/match/indexColumns";
}

- (YTKRequestMethod)requestMethod {
    return YTKRequestMethodGet;
}

- (id)jsonForModel
{
    return @"解析";
}

@end
