//
//  EZDeviceManager.m
//  EZKit
//
//  Created by Caesar on 16/4/26.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "EZDeviceManager.h"
#import "FCUUID.h"

@implementation EZDeviceManager
DEF_SINGLETON_AUTOLOAD(EZDeviceManager)

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
