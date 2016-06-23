//
//  EZRequest.m
//  EZKit
//
//  Created by Ezreal on 16/5/11.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "EZRequest.h"
#import "EZNetworkAgent.h"
#import "EZNetworkConfig.h"
#import "NSDictionary+EZKit.h"

NSString *stringForArgument (NSDictionary *dict)
{
    if (dict != nil && [dict isKindOfClass:[NSDictionary class]])
    {
        NSString *strResult = @"";
        
        for (NSString *key in dict.allKeys)
        {
            strResult = [NSString stringWithFormat:@"%@&%@=%@",strResult,key,[dict ez_stringForKey:key]];
        }
        return strResult;
    }
    else
    {
        return @"";
    }

}

@implementation EZRequest
{
    NSString *_strUrl;
    EZResponseMethod _method;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _strUrl = [self buildRequestUrl];
        self.requestSessionDataTask = nil;
    }
    return self;
}
- (void)startWithCompletionBlockWithSuccess:(EZRequestCompletionBlock)success
                                    failure:(EZRequestCompletionBlock)failure {
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
}

- (void)setCompletionBlockWithSuccess:(EZRequestCompletionBlock)success
                              failure:(EZRequestCompletionBlock)failure {
    self.successCompletionBlock = success;
    self.failureCompletionBlock = failure;
}

- (EZRequestMethod)requestMethod {
    return EZRequestMethodGet;
}

- (EZResponseMethod)responseMethod {
    return _method;
}

-(id)parameters
{
    return nil;
}

- (NSString *)baseUrl {
    return @"";
}

- (NSString *)requestUrl {
    return @"";
}

- (id)requestArgument {
    return nil;
}

-(id)jsonModel:(NSDictionary *)dict
{
    return nil;
}

/// append self to request queue
- (void)start {
    [[EZNetworkAgent sharedInstance] addRequest:self];
}

- (NSString *)buildRequestUrl{
    
    EZNetworkConfig *config = [EZNetworkConfig sharedInstance];
    
    _method = config.arugment.responseMethod;
    
    NSString *detailUrl = [self requestUrl];
    if ([detailUrl hasPrefix:@"http"])
    {
        return detailUrl;
    }
    
    NSString *strCommonArgument = @"";
    NSString *strUlrArgument = @"";
    if (config.arugment != nil)
    {
        strCommonArgument = config.arugment.strUrlArgument;
    }
    
    if ([self requestArgument] != nil)
    {
        strUlrArgument = stringForArgument([self requestArgument]);
    }
    
    
    if (strCommonArgument.length == 0 && strUlrArgument.length == 0)
    {
        
    }
    else
    {
        detailUrl = [NSString stringWithFormat:@"%@?%@%@",detailUrl,strCommonArgument,strUlrArgument];
    }
    
    NSString *baseUrl;
    if ([self baseUrl].length > 0) {
        baseUrl = [self baseUrl];
    } else {
        baseUrl = [config baseUrl];
    }
    
    return [NSString stringWithFormat:@"%@%@", baseUrl, detailUrl];
}

-(NSString *)strUrl
{
    return _strUrl;
}

-(NSDictionary *)responseData:(NSDictionary *)dict
{
    return nil;
}

-(void)dealloc
{
    NSLog(@"request 释放");
}

@end
