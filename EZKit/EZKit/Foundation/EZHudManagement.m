//
//  EZHudManagement.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "EZHudManagement.h"
#import "MBProgressHUD.h"

#define delay 1.5

@interface EZHudManagement ()
{
    MBProgressHUD *hud;
}
@end

@implementation EZHudManagement

DEF_SINGLETON(EZHudManagement)

- (instancetype)init
{
    self = [super init];
    if (self) {
        hud = [[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];
        [[[UIApplication sharedApplication].delegate window] addSubview:hud];
        hud.dimBackground = YES;
    }
    return self;
}

- (void)hide
{
    [hud hide:YES];
}

- (void)showMsg:(NSString *)msg
{
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    [hud show:YES];
    [hud hide:YES afterDelay:delay];
    //    [self showMsg:msg completionBlock:nil];
}

- (void)showMsg:(NSString *)msg completionBlock:(void (^)())completion
{
    hud.mode = MBProgressHUDModeText;
    hud.labelText = msg;
    
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(delay);
    } completionBlock:completion];
}

- (void)showIndicatorMsg:(NSString *)msg
{
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = msg;
    [hud show:YES];
}

- (void)dealloc
{
    [hud removeFromSuperview];
}

@end
