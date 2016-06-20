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
#import "NSDictionary+EZKit.h"

NSDictionary *dictForString(NSString *str)
{
    NSError *error = nil;
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    id jsObj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error != nil)
    {
        return nil;
    }
    else
    {
        return jsObj;
    }
}

NSString *stringForDict(NSDictionary *dict)
{
    NSError *error = nil;
    NSData *jsData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (error != nil)
    {
        return nil;
    }
    else
    {
        NSString *strJson = [[NSString alloc]initWithData:jsData encoding:NSUTF8StringEncoding];
        return strJson;
    }
}



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
    
    EZResponseMethod responseMethod = [request responseMethod];
    
    
    switch (responseMethod)
    {
        case EZResponseMethodDefault:
        {
            request.requestSessionDataTask = [self sendNetworkRequest:requestMethod url:request.strUrl parameters:request.parameters];
        }
            break;
        case EZResponseMethodCache1:
        {
            NSString *strData = [EZSharedCache ez_valueByKey:request.strUrl];//取缓存数据
            
            if (strData != nil)
            {
                NSDictionary *dict = dictForString(strData);
                
                [self handleRequestResult:request responseObject:dict isCache:YES];
            }
            else
            {
                request.requestSessionDataTask = [self sendNetworkRequest:requestMethod url:request.strUrl parameters:request.parameters];
            }
        }
            break;
        case EZResponseMethodCache2:
        {
            NSString *strData = [EZSharedCache ez_valueByKey:request.strUrl];//取缓存数据
            
            if (strData != nil)
            {
                NSDictionary *dict = dictForString(strData);
                [self handleRequestResult:request responseObject:dict isCache:YES];
            }
            request.requestSessionDataTask = [self sendNetworkRequest:requestMethod url:request.strUrl parameters:request.parameters];
        }
            break;
        default:
        {
            request.requestSessionDataTask = [self sendNetworkRequest:requestMethod url:request.strUrl parameters:request.parameters];
        }
            break;
    }
    
    [self addSessionDataTask:request];
}

-(void)setCookies:(NSString *)strUrl
{
    if (_config.arugment != nil)
    {
        NSArray *array = [_config.arugment requestCookieArgument];
        if (array != nil && array.count > 0)
        {
            NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSArray *cookies = [cookieStorage cookiesForURL:[NSURL URLWithString:strUrl]];
            for (NSHTTPCookie *cookie in cookies){
                [cookieStorage deleteCookie:cookie];
            }
            
            for (int i = 0; i < array.count; i++)
            {
                id obj = [array objectAtIndex:i];
                if ([obj isKindOfClass:[NSDictionary class]])
                {
                    [cookieStorage setCookie:[NSHTTPCookie cookieWithProperties:obj]];
                }
            }
            
            
        }
    }
    return;
}

-(void)setHTTPHeaderField
{
    if (_config.arugment != nil)
    {
        NSDictionary *dict = [_config.arugment requestSerializerHTTPHeaderField];
        if (dict != nil)
        {
            for (NSString *strKey in dict.allKeys)
            {
                NSString *strValue = [dict objectForKey:strKey];
                [_manager.requestSerializer setValue:strValue forHTTPHeaderField:strKey];
            }
        }
    }
}

- (NSURLSessionDataTask *)sendNetworkRequest:(EZRequestMethod)method url:(NSString *)url parameters:(id)parameters
{
    [self setCookies:url];
    [self setHTTPHeaderField];
    
    switch (method)
    {
        case EZRequestMethodGet:
        {
            return [_manager GET:url parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
                NSLog(@"progress");
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                EZRequest *request = [self getRequestBy:task];
                [self handleRequestResult:request responseObject:responseObject isCache:NO];
                [self removeSessionDataTask:task];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                EZRequest *request = [self getRequestBy:task];
                [self handleRequestResult:request responseObject:nil isCache:NO];
                [self removeSessionDataTask:task];
            }];
        }
            break;
        case EZRequestMethodPost:
        {
            return [_manager POST:url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {

            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                EZRequest *request = [self getRequestBy:task];
                [self handleRequestResult:request responseObject:responseObject isCache:NO];
                [self removeSessionDataTask:task];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                EZRequest *request = [self getRequestBy:task];
                [self handleRequestResult:request responseObject:nil isCache:NO];
                [self removeSessionDataTask:task];
            }];
        }
            break;
        default:
        {
            
        }
            break;
    }
    return nil;
}

-(void)callBack:(EZRequest *)request success:(BOOL)success
{
    if (success)
    {
        if (request.successCompletionBlock)
        {
            request.successCompletionBlock(request);
        }
    }
    else
    {
        if (request.failureCompletionBlock)
        {
            request.failureCompletionBlock(request);
        }
    }
}

-(void)jsonModel:(EZRequest *)request
{
    if (_config.arugment != nil)
    {
        //提取公共数据
        id data = [_config.arugment responseData:request.responseJSONObject];
        if (data != nil)
        {
            id obj = [request jsonModel:data];
            
            [request setValue:obj forKey:@"responseModel"];
        }
        else
        {
            id obj = [request jsonModel:request.responseJSONObject];
            
            [request setValue:obj forKey:@"responseModel"];
        }
    }
    else
    {
        id obj = [request jsonModel:request.responseJSONObject];
        
        [request setValue:obj forKey:@"responseModel"];
    }
}

-(void)handleRequestResult:(EZRequest *)request responseObject:(id)responseObject isCache:(BOOL)isCache
{
    BOOL succeed = [self checkResult:request responseObject:responseObject];
    
    if (succeed)
    {
        [request setValue:[NSNumber numberWithBool:isCache] forKey:@"isCache"];
        [request setValue:responseObject forKey:@"responseJSONObject"];
        
        [self jsonModel:request];

        if ([request responseMethod] != EZResponseMethodDefault)
        {
            NSString *strData = stringForDict(responseObject);
            [EZSharedCache ez_saveCacheByKey:request.strUrl value:strData];
        }
    }
    else
    {
        if (isCache)
        {
            [EZSharedCache ez_clearCacheByKey:request.strUrl];
        }
    }
    
    [self callBack:request success:succeed];
}


- (BOOL)checkResult:(EZRequest *)request responseObject:(id)responseObject
{
    if (responseObject != nil)
    {
        if (_config.arugment != nil)
        {
            //公共参数检查
            return [_config.arugment responseCheckErrorCode:responseObject];
        }
        
        return YES;
        
    }
    else
    {
        return NO;
    }
}

- (NSString *)requestTaskID:(NSURLSessionDataTask *)task {
    NSNumber *num = [NSNumber numberWithUnsignedInteger:task.taskIdentifier];
    return num.description;
}

-(EZRequest *)getRequestBy:(NSURLSessionDataTask *)task
{
    NSString *strTaskID = [self requestTaskID:task];
    EZRequest *request = _requestsRecord[strTaskID];
    return request;
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
