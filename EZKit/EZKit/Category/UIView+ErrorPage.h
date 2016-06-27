//
//  UIView+ErrorPage.h
//  EZKit
//
//  Created by Ezreal on 16/6/27.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EZErrorPageDelegate <NSObject>
-(UIImage *)imageForErrorPage;

-(NSString *)descForErrorPage;

-(void)didTapView;

@optional
@end

typedef NS_ENUM(NSUInteger, EZErrorPageType) {
    
    EZErrorPageTypeNone,
    
    EZErrorPageTypeLoading,
    
    EZErrorPageTypeNetError,
    
    EZErrorPageTypeEmptyData,
};

@interface UIView (ErrorPage)

@property (nonatomic,assign)EZErrorPageType ez_pageType;

@property (nonatomic, weak) IBOutlet id <EZErrorPageDelegate> errorPageDelegate;

@end

