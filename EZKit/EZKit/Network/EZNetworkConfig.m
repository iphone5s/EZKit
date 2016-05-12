//
//  EZNetworkConfig.m
//  EZKit
//
//  Created by Ezreal on 16/5/10.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "EZNetworkConfig.h"


@implementation EZNetworkConfig
{
    NSMutableArray *_urlFilters;
}

DEF_SINGLETON(EZNetworkConfig);

- (instancetype)init
{
    self = [super init];
    if (self) {
        _urlFilters = [NSMutableArray array];
    }
    return self;
}

-(void)addUrlFilter:(id<EZNetworkArgumentProtocol>)filter
{
    [_urlFilters addObject:filter];
}

- (NSArray *)urlFilters {
    return [_urlFilters copy];
}

@end
