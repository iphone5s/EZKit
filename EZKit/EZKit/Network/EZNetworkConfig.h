//
//  EZNetworkConfig.h
//  EZKit
//
//  Created by Ezreal on 16/5/10.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EZKitDefine.h"
#import "EZRequest.h"

@protocol EZNetworkArgumentProtocol <NSObject>
- (NSDictionary *)requestArgument;
- (NSDictionary *)responseArgument;
@end

@interface EZNetworkConfig : NSObject

AS_SINGLETON(EZNetworkConfig);

@property (strong, nonatomic) NSString *baseUrl;

@property (strong, nonatomic, readonly) NSArray *urlFilters;

- (void)addUrlFilter:(id<EZNetworkArgumentProtocol>)filter;

@end
