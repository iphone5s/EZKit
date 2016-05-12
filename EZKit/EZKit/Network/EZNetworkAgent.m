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
#import "NSDictionary+EZKit.h"
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
    
    if (request)
    {
        BOOL succeed = [self checkResult:request];
        
        if (succeed)
        {
            if ([request responseMethod] != EZResponseMethodDefault)
            {
                //保存缓存数据
                NSString *strURL = [request requestUrl];
                [EZSharedCache ez_saveCacheByKey:request.responseString value:strURL];
            }
            
            if (request.successCompletionBlock)
            {
                //接口成功回调
                request.successCompletionBlock(request);
            }
        }
        else
        {
            if (request.failureCompletionBlock)
            {
                //接口失败回调
                request.failureCompletionBlock(request);
            }
        }
    }

    [self removeSessionDataTask:task];
}

- (BOOL)checkResult:(EZRequest *)request {
    
    return YES;
//    BOOL result = [request statusCodeValidator];
//    if (!result) {
//        return result;
//    }
//    id validator = [request jsonValidator];
//    if (validator != nil) {
//        id json = [request responseJSONObject];
//        result = [YTKNetworkPrivate checkJson:json withValidator:validator];
//    }
//    return result;
}

- (NSString *)buildRequestUrl:(EZRequest *)request {
    
    NSString *detailUrl = [request requestUrl];
    if ([detailUrl hasPrefix:@"http"]) {
        return detailUrl;
    }
    
    NSArray *filters = [_config urlFilters];
    for (id<EZNetworkArgumentProtocol> f in filters)
    {
        NSDictionary *dict = [f requestArgument];
        for (NSString *key in dict.allKeys)
        {
            detailUrl = [NSString stringWithFormat:@"%@%@",detailUrl,[dict ez_stringForKey:key]];
        }
//        detailUrl = [f filterUrl:detailUrl withRequest:request];
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
