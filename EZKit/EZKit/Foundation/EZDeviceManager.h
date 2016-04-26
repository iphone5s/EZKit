//
//  EZDeviceManager.h
//  EZKit
//
//  Created by Caesar on 16/4/26.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZKitDefine.h"

#define EZSharedDevice [EZDeviceManager sharedInstance]

@interface EZDeviceManager : NSObject

AS_SINGLETON(EZDeviceManager)

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
