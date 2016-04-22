//
//  EZHudManagement.h
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EZKitDefine.h"

#define EZSharedHUD [EZHud sharedInstance]

@interface EZHudManagement : NSObject

AS_SINGLETON(EZHudManagement)

- (void)hide;

- (void)showMsg:(NSString *)msg;

- (void)showMsg:(NSString *)msg completionBlock:(void (^)())completion;

- (void)showIndicatorMsg:(NSString *)msg;

@end
