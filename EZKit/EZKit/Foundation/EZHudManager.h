//
//  EZHudManager.h
//  EZKit
//
//  Created by Caesar on 16/4/26.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EZKitDefine.h"

#define EZSharedHUD [EZHudManager sharedInstance]

@interface EZHudManager : NSObject

AS_SINGLETON(EZHudManagement)

- (void)hide;

- (void)showMsg:(NSString *)msg;

- (void)showMsg:(NSString *)msg completionBlock:(void (^)())completion;

- (void)showIndicatorMsg:(NSString *)msg;

@end
