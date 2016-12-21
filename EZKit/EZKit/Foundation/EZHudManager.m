//
//  EZHudManager.m
//  EZKit
//
//  Created by Caesar on 16/4/26.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "EZHudManager.h"
#import "MBProgressHUD.h"

#define delay 1.5

@interface EZHudManager ()
{
    MBProgressHUD *m_hud;
}
@end

@implementation EZHudManager
DEF_SINGLETON(EZHudManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
//        hud = [[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];
//        [[[UIApplication sharedApplication].delegate window] addSubview:hud];
//        hud.dimBackground = YES;
    }
    return self;
}

- (void)hide
{
    [m_hud hide:YES];
}

- (void)showMsg:(NSString *)msg
{
    if (m_hud)
    {
        [m_hud hide:YES];
        m_hud = nil;
    }
    
    m_hud = [[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[[UIApplication sharedApplication].delegate window] addSubview:m_hud];
    m_hud.removeFromSuperViewOnHide = YES;
    m_hud.dimBackground = YES;
    m_hud.mode = MBProgressHUDModeText;
    m_hud.labelText = msg;
    [m_hud show:YES];
    [m_hud hide:YES afterDelay:delay];
}

- (void)showMsg:(NSString *)msg completionBlock:(void (^)())completion
{
    if (m_hud)
    {
        [m_hud hide:YES];
        m_hud.removeFromSuperViewOnHide = YES;
        m_hud = nil;
    }
    
    m_hud = [[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[[UIApplication sharedApplication].delegate window] addSubview:m_hud];
    m_hud.removeFromSuperViewOnHide = YES;
    m_hud.dimBackground = YES;
    m_hud.mode = MBProgressHUDModeText;
    m_hud.labelText = msg;
    
    [m_hud showAnimated:YES whileExecutingBlock:^{
        sleep(delay);
    } completionBlock:completion];
}

- (void)showIndicatorMsg:(NSString *)msg
{
    if (m_hud)
    {
        [m_hud hide:YES];
        m_hud.removeFromSuperViewOnHide = YES;
        m_hud = nil;
    }
    
    m_hud = [[MBProgressHUD alloc]initWithWindow:[UIApplication sharedApplication].keyWindow];
    [[[UIApplication sharedApplication].delegate window] addSubview:m_hud];
    m_hud.removeFromSuperViewOnHide = YES;
    m_hud.dimBackground = YES;
    m_hud.mode = MBProgressHUDModeIndeterminate;
    m_hud.labelText = msg;
    [m_hud show:YES];
}

- (void)dealloc
{
    [m_hud hide:YES];
    m_hud = nil;
}

@end
