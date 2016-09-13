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
#import "EZNetworkArgument.h"

@interface EZNetworkConfig : NSObject

AS_SINGLETON(EZNetworkConfig);

@property (nonatomic,strong) NSString *baseUrl;

@property (nonatomic,strong)EZNetworkArgument *arugment;

@end
