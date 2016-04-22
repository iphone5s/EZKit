//
//  EZDeviceManagement.m
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 Caesar. All rights reserved.
//

#import "EZDeviceManagement.h"

#import "FCUUID.h"

@implementation EZDeviceManagement

DEF_SINGLETON_AUTOLOAD(EZDeviceManagement)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.strUDID = [FCUUID uuidForDevice];
        self.strDevice = [UIDevice currentDevice].model;
        self.strNetState = @"Unknown";
        
    }
    return self;
}

-(NSString *)strTimeZone
{
    return [NSTimeZone systemTimeZone].name;
}

-(NSString *)strBuild
{
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return build;
}

-(NSString *)strVersion
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return version;
}

-(NSString *)strSystemName
{
    return [UIDevice currentDevice].systemName;
}

-(NSString *)strLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    return currentLanguage;
}

-(CGFloat)screenWidth
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return screenSize.height;
    }
    return screenSize.width;
}

-(CGFloat)screenHeight
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) && UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return screenSize.width;
    }
    return screenSize.height;
}

@end
