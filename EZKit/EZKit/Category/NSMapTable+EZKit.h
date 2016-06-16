//
//  NSMapTable+EZKit.h
//  EZKit
//
//  Created by Ezreal on 16/6/16.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMapTable (EZKit)

- (NSArray *) allKeys;

- (NSArray *)allKeysForObject:(NSObject *)anObject;

@end
