//
//  EZCacheManager.h
//  EZKit
//
//  Created by Ezreal on 16/5/8.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZKitDefine.h"

#define EZSharedCache [EZCacheManager sharedInstance]

@interface EZCacheManager : NSObject

AS_SINGLETON(EZCacheManager)

@property(nonatomic,assign)NSInteger cacheTime;

@property(nonatomic,assign)CGFloat cacheSize;

-(BOOL)ez_clearAllCache;

-(BOOL)ez_saveCacheByKey:(NSString *)key value:(NSString *)value;

-(NSString *)ez_valueByKey:(NSString *)key;

-(BOOL)ez_clearCacheByKey:(NSString *)key;

@end
