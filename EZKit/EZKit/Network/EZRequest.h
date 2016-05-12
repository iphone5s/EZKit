//
//  EZRequest.h
//  EZKit
//
//  Created by Ezreal on 16/5/11.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , EZRequestMethod) {
    EZRequestMethodGet = 0,
    EZRequestMethodPost,
};

typedef NS_ENUM(NSInteger , EZResponseMethod) {
    EZResponseMethodDefault = 0,//不使用缓存
    EZResponseMethodCache1,//有缓存则返回缓存数据，无缓存则直接请求数据
    EZResponseMethodCache2,//有缓存则先返回缓存数据，无缓存则直接请求数据
};

@class EZRequest;

typedef void(^EZRequestCompletionBlock)(__kindof EZRequest *request);

@interface EZRequest : NSObject

@property(nonatomic,assign,readonly)BOOL isCache;
//返回结果
@property (nonatomic, strong, readonly) NSString *responseString;

@property (nonatomic, strong) NSURLSessionDataTask *requestSessionDataTask;
/// Http请求的方式
- (EZRequestMethod)requestMethod;
/// Http返回方式
- (EZResponseMethod)responseMethod;

/// 请求的BaseURL
- (NSString *)baseUrl;
/// 请求的URL
- (NSString *)requestUrl;

@property (nonatomic, copy) EZRequestCompletionBlock successCompletionBlock;

@property (nonatomic, copy) EZRequestCompletionBlock failureCompletionBlock;

/// block回调
- (void)startWithCompletionBlockWithSuccess:(EZRequestCompletionBlock)success
                                    failure:(EZRequestCompletionBlock)failure;

@end
