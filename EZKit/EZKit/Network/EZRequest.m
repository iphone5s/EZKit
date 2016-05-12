//
//  EZRequest.m
//  EZKit
//
//  Created by Ezreal on 16/5/11.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "EZRequest.h"
#import "EZNetworkAgent.h"

@implementation EZRequest

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
    return EZResponseMethodDefault;
}

- (NSString *)baseUrl {
    return @"";
}

- (NSString *)requestUrl {
    return @"";
}

/// append self to request queue
- (void)start {
    [[EZNetworkAgent sharedInstance] addRequest:self];
}

-(void)dealloc
{
    NSLog(@"request 释放");
}

@end
