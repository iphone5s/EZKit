//
//  EZAlertController.h
//  EZKit
//
//  Created by Ezreal on 2016/12/7.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EZAlertController : UIViewController

-(void)ez_showAlert;

-(void)ez_hideAlert:(void (^ __nullable)(void))completion;

@end
