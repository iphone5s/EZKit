//
//  EZNetworkArgument.h
//  EZKit
//
//  Created by Ezreal on 16/5/13.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EZRequest.h"

@interface EZNetworkArgument : NSObject

@property (nonatomic,strong,readonly)NSString *strUrlArgument;

@property (nonatomic,strong,readonly)NSString *strCookieArgument;

/// Http返回方式
- (EZResponseMethod)responseMethod;

-(BOOL)responseCheckErrorCode:(NSDictionary *)dict;

-(NSDictionary *)responseData:(NSDictionary *)dict;

@end
