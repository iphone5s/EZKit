//
//  UIViewController+EZLoading.h
//  EZKit
//
//  Created by Ezreal on 16/6/27.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, EZLoadingType) {
    
    EZLoadingTypeNone = 0,
    
    EZLoadingTypeLoading,
    
    EZLoadingTypeNetError,
    
    EZLoadingTypeEmptyData,
};


@interface UIViewController (EZLoading)

@property (nonatomic, assign) EZLoadingType ez_loadingType;

@end
