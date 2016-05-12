//
//  EZNetworkAgent.m
//  EZKit
//
//  Created by Ezreal on 16/5/10.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "EZNetworkAgent.h"
#import "EZNetworkConfig.h"
#import "EZCacheManager.h"
#import "AFNetworking.h"
#import "EZNetworkArgument.h"

@implementation EZNetworkAgent
{
    AFHTTPSessionManager *_manager;
    EZNetworkConfig *_config;
    NSMutableDictionary *_requestsRecord;
}

DEF_SINGLETON(EZNetworkAgent);

-(instancetype)init
{
    self = [super init];
    if (self)
    {
        _config = [EZNetworkConfig sharedInstance];
        _manager = [AFHTTPSessionManager manager];
        _requestsRecord = [NSMutableDictionary dictionary];
        _manager.operationQueue.maxConcurrentOperationCount = 4;
        _manager.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", nil];
    }
    return self;
}

- (void)addRequest:(EZRequest *)request
{
    if ([self isTaskRun:request])
    {
        return;
    }
    
    EZRequestMethod requestMethod = [request requestMethod];
    NSString *url = [self buildRequestUrl:request];
    EZResponseMethod responseMethod = [request responseMethod];
    
    switch (responseMethod)
    {
        case EZResponseMethodDefault:
        {
            request.requestSessionDataTask = [self sendNetworkRequest:requestMethod url:url];
        }
            break;
        case EZResponseMethodCache1:
        {
            NSString *strData = [EZSharedCache ez_valueByKey:url];//取缓存数据
            if (strData != nil)
            {
                [request setValue:@YES forKey:@"isCache"];
                
                [request setValue:strData forKey:@"responseString"];
                
            }
            else
            {
                request.requestSessionDataTask = [self sendNetworkRequest:requestMethod url:url];
            }
        }
            break;
        case EZResponseMethodCache2:
        {
            
        }
            break;
        default:
        {
            
        }
            break;
    }
    
    [self addSessionDataTask:request];
}

- (NSURLSessionDataTask *)sendNetworkRequest:(EZRequestMethod)method url:(NSString *)url
{
    switch (method)
    {
        case EZRequestMethodGet:
        {
            return [_manager GET:url parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"progress");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self handleRequestResult:task];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self handleRequestResult:task];
            }];
        }
            break;
        case EZRequestMethodPost:
        {
            
        }
            break;
        default:
        {
            
        }
            break;
    }
    return nil;
}

- (void)handleRequestResult:(NSURLSessionDataTask *)task
{
    NSString *strTaskID = [self requestTaskID:task];
    EZRequest *request = _requestsRecord[strTaskID];
    if (request.successCompletionBlock != nil)
    {
        //block返回
        request.successCompletionBlock(request);
    }
    else
    {
        //代理返回
    }
    [self removeSessionDataTask:task];
}

- (NSString *)buildRequestUrl:(EZRequest *)request {
    
    NSString *detailUrl = [request requestUrl];
    if ([detailUrl hasPrefix:@"http"]) {
        return detailUrl;
    }
    
    NSString *baseUrl;
    if ([request baseUrl].length > 0) {
        baseUrl = [request baseUrl];
    } else {
        baseUrl = [_config baseUrl];
    }
    
    return [NSString stringWithFormat:@"%@%@", baseUrl, detailUrl];
}

- (NSString *)requestTaskID:(NSURLSessionDataTask *)task {
    NSString *key = [NSString stringWithFormat:@"%lu", task.taskIdentifier];
    return key;
}

- (void)addSessionDataTask:(EZRequest *)request
{
    if (request.requestSessionDataTask != nil)
    {
        NSString *strTaskID = [self requestTaskID:request.requestSessionDataTask];
        @synchronized (self)
        {
            _requestsRecord[strTaskID] = request;
        }
    }
}

-(BOOL)isTaskRun:(EZRequest *)request
{
    NSString *strTaskID = [self requestTaskID:request.requestSessionDataTask];
    id obj = _requestsRecord[strTaskID];
    if (obj != nil)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)removeSessionDataTask:(NSURLSessionDataTask *)task {
    NSString *strTaskID = [self requestTaskID:task];
    @synchronized(self) {
        [_requestsRecord removeObjectForKey:strTaskID];
    }
}

@end
