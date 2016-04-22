//
//  EZDeviceManagement.h
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 Caesar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZKitDefine.h"

#define EZSharedDevice [EZDeviceManagement sharedInstance]

@interface EZDeviceManagement : NSObject

AS_SINGLETON(EZDeviceManagement)

@property (nonatomic,strong)NSString *strUDID;

@property (nonatomic,strong)NSString *strVersion;

@property (nonatomic,strong)NSString *strBuild;

@property (nonatomic,strong)NSString *strDevice;

@property (nonatomic,strong)NSString *strSystemName;

@property (nonatomic,strong)NSString *strLanguage;

@property (nonatomic,strong)NSString *strTimeZone;

@property (nonatomic,strong)NSString *strNetState;

@property (nonatomic,assign)CGFloat  screenWidth;

@property (nonatomic,assign)CGFloat  screenHeight;

@end
