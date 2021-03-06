//
//  EZDeviceManager.m
//  EZKit
//
//  Created by Caesar on 16/4/26.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import "EZDeviceManager.h"
#import "FCUUID.h"
#import "Reachability.h"

@implementation EZDeviceManager
{
    Reachability *reach;
}
DEF_SINGLETON_AUTOLOAD(EZDeviceManager)

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.strUDID = [FCUUID uuidForDevice];
        self.strDevice = [UIDevice currentDevice].model;
        
        reach =  [Reachability reachabilityForInternetConnection];
        [reach startNotifier];
        
        self.strPathDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
    }
    return self;
}

-(NSString *)strNetState
{
    NetworkStatus status =  [reach currentReachabilityStatus];
    switch (status)
    {
        case NotReachable:
            return @"";
            break;
        case ReachableViaWiFi:
            return @"WiFi";
            break;
        case ReachableViaWWAN:
            return @"WWAN";
        default:
            return @"unknown";
            break;
    }
    return @"unknown";
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

-(NSString *)strCurrentDate
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];

    return dateString;
}
@end
