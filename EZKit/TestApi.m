//
//  TestApi.m
//  EZKit
//
//  Created by Ezreal on 16/5/10.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "TestApi.h"
#import "Model.h"

@implementation TestApi

//- (id)requestArgument {
//    return @{
//             @"username": @"c",
//             @"password": @"d"
//             };
//}

- (NSString *)requestUrl {
    return @"/match/indexColumns";
}

-(id)jsonModel:(NSDictionary *)dict
{
    NSArray *arr = [dict objectForKey:@"list"];
    

    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *js = [arr objectAtIndex: i];
//        Model *model = [[Model alloc]init];

        Model *model = [Model mj_objectWithKeyValues:js];
        NSLog(@"%@ %@ %@ %@ %@",model.strName,model.strDesc,model.strIcon,model.strColumnId,model.strRankColumn);
        [array addObject:model];
        
    }
    
    
    return array;
}
@end
