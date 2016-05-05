//
//  EZRequest.m
//  EZKit
//
//  Created by Caesar on 16/5/4.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "EZRequest.h"

@interface EZRequest ()
{
    id responseModel;
}
@end

@implementation EZRequest

- (void)requestCompleteFilter
{
    [super requestCompleteFilter];
    
    responseModel = [self jsonForModel];
}

- (id)responseModel
{
    return responseModel;
}

- (id)jsonForModel
{
    return nil;
}

- (void)startWithCompletionBlockWithSuccess:(EZRequestCompletionBlock)success failure:(EZRequestCompletionBlock)failure
{
    [super startWithCompletionBlockWithSuccess:success failure:failure];
    
}

@end
