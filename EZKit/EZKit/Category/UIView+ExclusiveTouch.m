//
//  UIView+ExclusiveTouch.m
//  EZKit
//
//  Created by Ezreal on 2016/10/14.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "UIView+ExclusiveTouch.h"
#import <objc/runtime.h>

@implementation UIView (ExclusiveTouch)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{        // This ensures following code is executed once and only once for entire app life cycle.
        Class class = [self class];
        
        SEL originalSelector = @selector(isExclusiveTouch);
        SEL desiredSelector = @selector(eTouch_isExclusiveTouch);
        
        if(originalSelector){
            Method originalMethod = class_getInstanceMethod(class, originalSelector); // class_getInstanceMethod gets implementatino of method defined in the
            Method desiredMethod = class_getInstanceMethod(class, desiredSelector); // selector
            
            IMP desiredIMP = (IMP)_desired_isExclusiveTouch; // gets the implementation defined below for
            
            IMP origIMP = method_setImplementation(originalMethod, desiredIMP); // sets the implementation of isExclusiveTouch to what is
            // desired i.e. _desired_isExclusiveTouch which always returns YES
            
            method_setImplementation(desiredMethod, origIMP); // eTouch_isExclusiveTouch now points to implementatino of isExclusiveTouch which we anyhow
            //  won't be using in our project
        }
        else{
            NSLog(@"exclusiveTouch property is not exposed or deprecated");
        }
        
    });
}

#pragma mark - Method Swapping

bool _desired_isExclusiveTouch(id self, SEL _cmd){
    
    return YES;
}

-(BOOL)eTouch_isExclusiveTouch{
    
    return NO;
}

@end
