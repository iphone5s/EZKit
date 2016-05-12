//
//  EZNetworkAgent.h
//  EZKit
//
//  Created by Ezreal on 16/5/10.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EZKitDefine.h"
#import "EZRequest.h"

@interface EZNetworkAgent : NSObject

AS_SINGLETON(EZNetworkAgent);

- (void)addRequest:(EZRequest *)request;

@end
