//
//  CustomViewController.h
//  EZKit
//
//  Created by Caesar on 16/4/22.
//  Copyright © 2016年 EZreal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EZAlertController.h"

typedef void(^completionBlock)(NSInteger tag);

@interface CustomViewController : EZAlertController

-(void)showAlert:(nullable completionBlock)compleBlock;

@end
