//
//  UIViewController+EZLoading.m
//  EZKit
//
//  Created by Ezreal on 16/6/27.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "UIViewController+EZLoading.h"
#import "Masonry.h"
#import <objc/runtime.h>
#import "EZKit.h"
#define kEmptyImageViewAnimationKey @"com.dzn.emptyDataSet.imageViewAnimation"

@interface EZEmptyDataSetView : UIView
{
    UIImageView *imageView;
    UILabel *descLab;
}

@property (nonatomic, assign) EZLoadingType ez_loadingType;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *strDesc;
@end

@implementation EZEmptyDataSetView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        imageView = [UIImageView new];
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        
        descLab = [UILabel new];
        [self addSubview:descLab];
        [descLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(imageView.mas_bottom).offset(10);
            make.height.mas_equalTo(15);
        }];
        descLab.textColor = HEX_RGB(0x22292f);
        descLab.textAlignment = NSTextAlignmentCenter;
        descLab.font = [UIFont systemFontOfSize:14];
        
    }
    return self;
}

-(void)setImage:(UIImage *)image
{
    _image = image;
}

-(CAAnimation *)loadingAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}

-(void)setEz_loadingType:(EZLoadingType)ez_loadingType
{
    switch (ez_loadingType)
    {
        case EZLoadingTypeLoading:
        {
            imageView.image = self.image;
            [imageView.layer addAnimation:[self loadingAnimation] forKey:kEmptyImageViewAnimationKey];
        }
            break;
        case EZLoadingTypeEmptyData:
        case EZLoadingTypeNetError:
        {
            [imageView.layer removeAllAnimations];
            
            imageView.image = self.image;
            descLab.text = self.strDesc;
        }
            break;
            
        default:
            break;
    }
}

@end

static const void *ez_loadingKey = &ez_loadingKey;

static char const * const kEmptyDataSetView =       "emptyDataSetView";

@interface UIViewController ()

@property (nonatomic, readonly) EZEmptyDataSetView *emptyDataSetView;

@end

@implementation UIViewController (EZLoading)
@dynamic ez_loadingType;

-(void)setEz_loadingType:(EZLoadingType)ez_loadingType
{
    objc_setAssociatedObject(self, ez_loadingKey, [NSNumber numberWithInteger:ez_loadingType], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    switch (ez_loadingType)
    {
        case EZLoadingTypeNone:
        {
            if (self.emptyDataSetView)
            {
                [self.emptyDataSetView removeFromSuperview];
                self.emptyDataSetView = nil;
            }

        }
            break;
        case EZLoadingTypeLoading:
        case EZLoadingTypeEmptyData:
        case EZLoadingTypeNetError:
        {
            if (!self.emptyDataSetView)
            {
                self.emptyDataSetView = [EZEmptyDataSetView new];
                [self.view insertSubview:self.emptyDataSetView atIndex:0];
                [self.emptyDataSetView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(self.view);
                }];
                
                UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView)];
                [self.emptyDataSetView addGestureRecognizer:singleTap];
            }
            self.emptyDataSetView.strDesc = [self descriptionForEmptyDataSet];
            self.emptyDataSetView.image = [self imageForEmptyDataSet];
            self.emptyDataSetView.ez_loadingType = ez_loadingType;
        }
            break;
        default:
            break;
    }
}

-(EZLoadingType)ez_loadingType
{
    NSNumber *num = objc_getAssociatedObject(self, ez_loadingKey);
    return num.integerValue;
}

- (EZEmptyDataSetView *)emptyDataSetView
{
    return objc_getAssociatedObject(self, kEmptyDataSetView);
}

- (void)setEmptyDataSetView:(EZEmptyDataSetView *)view
{
    objc_setAssociatedObject(self, kEmptyDataSetView, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImage *)imageForEmptyDataSet
{
    return nil;
}

-(NSString *)descriptionForEmptyDataSet
{
    return nil;
}

-(void)didTapView
{
    
}

@end
