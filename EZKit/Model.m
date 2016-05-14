//
//  Model.m
//  EZKit
//
//  Created by Ezreal on 16/5/14.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "Model.h"

@implementation Model

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(void)load
{
    [Model mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"strName":@"name",
                 @"strDesc":@"desc",
                 @"strIcon":@"icon",
                 @"strColumnId":@"columnId",
                 @"strRankColumn":@"rankColumn",
                 };
    }];
}
@end
