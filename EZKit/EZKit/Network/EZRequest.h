//
//  EZRequest.h
//  EZKit
//
//  Created by Caesar on 16/5/4.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <YTKNetwork/YTKRequest.h>

@class EZRequest;

typedef void(^EZRequestCompletionBlock)(__kindof EZRequest *request);

@interface EZRequest : YTKRequest

@property (nonatomic, strong, readonly) id responseModel;

- (void)startWithCompletionBlockWithSuccess:(EZRequestCompletionBlock)success
                                    failure:(EZRequestCompletionBlock)failure;

@end
