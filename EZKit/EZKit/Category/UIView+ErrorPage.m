//
//  UIView+ErrorPage.m
//  EZKit
//
//  Created by Ezreal on 16/6/27.
//  Copyright © 2016年 Ezreal. All rights reserved.
//

#import "UIView+ErrorPage.h"
#import <objc/runtime.h>
#import "Masonry.h"
#import "EZKit.h"

@interface EZErrorView : UIView
{
    UIImageView *imageView;
    UILabel *descLab;
}

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) NSString *strDesc;

@property (nonatomic, assign)BOOL isAnimation;

@end

@implementation EZErrorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        imageView = [UIImageView new];
        [self addSubview:imageView];
        
        descLab = [UILabel new];
        [self addSubview:descLab];
        descLab.textColor = HEX_RGB(0x22292f);
        descLab.textAlignment = NSTextAlignmentCenter;
        descLab.font = [UIFont systemFontOfSize:14];
        descLab.frame = CGRectMake(0, 0, 300, 20);
    }
    return self;
}

-(void)layoutSubviews
{
    imageView.size = self.image.size;
    imageView.center = CGPointMake(self.width / 2.0, self.height / 2.0);
    descLab.centerX = imageView.centerX;
    descLab.top = imageView.bottom + 10;
}


-(void)setImage:(UIImage *)image
{
    _image = image;
    imageView.image = self.image;
}

-(void)setStrDesc:(NSString *)strDesc
{
    _strDesc = strDesc;
    descLab.text = strDesc;
}

-(void)setIsAnimation:(BOOL)isAnimation
{
    _isAnimation = isAnimation;
    
    if (isAnimation)
    {
        [imageView.layer removeAllAnimations];
        [imageView.layer addAnimation:[self loadingAnimation] forKey:@"loading"];
        descLab.hidden = YES;
    }
    else
    {
        descLab.hidden = NO;
        [imageView.layer removeAllAnimations];
    }
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

@end


static const void *ez_pageTypeKey = &ez_pageTypeKey;

static char const * const kEmptyDataSetView ="emptyDataSetView";

static char const * const kErrorPageDelegate ="errorPageDelegate";

@interface UIView ()

@property (nonatomic, strong)EZErrorView *errorView;

@end

@implementation UIView (ErrorPage)
@dynamic ez_pageType,errorPageDelegate;

-(void)setEz_pageType:(EZErrorPageType)ez_pageType
{
    objc_setAssociatedObject(self, ez_pageTypeKey, [NSNumber numberWithInteger:ez_pageType], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (!self.errorView)
    {
        self.errorView = [[EZErrorView alloc]initWithFrame:CGRectMake(0, 0, self.width + 20, self.height)];
        [self addSubview:self.errorView];
        self.errorView.backgroundColor = [UIColor redColor];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
        [self.errorView addGestureRecognizer:tap];
        
    }
    
    if ([self isKindOfClass:[UIScrollView class]])
    {
        ((UIScrollView *)self).scrollEnabled = (self.ez_pageType == EZErrorPageTypeNone)?YES:NO;
    }
    
    switch (ez_pageType)
    {
        case EZErrorPageTypeNone:
        {
            [self.errorView.layer removeAllAnimations];
            self.errorView.hidden = YES;
        }
            break;
        case EZErrorPageTypeLoading:
        {
            self.errorView.hidden = NO;
            self.errorView.image = [self.errorPageDelegate imageForErrorPage];
            self.errorView.isAnimation = YES;
        }
            break;
        case EZErrorPageTypeEmptyData:
        case EZErrorPageTypeNetError:
        {
            self.errorView.hidden = NO;
            self.errorView.image = [self.errorPageDelegate imageForErrorPage];
            self.errorView.strDesc = [self.errorPageDelegate descForErrorPage];
            self.errorView.isAnimation = NO;
        }
            break;
        default:
            break;
    }
    
}

-(EZErrorPageType)ez_pageType
{
    NSNumber *num = objc_getAssociatedObject(self, ez_pageTypeKey);
    return num.integerValue;
}

-(void)setErrorView:(EZErrorView *)errorView
{
    objc_setAssociatedObject(self, kEmptyDataSetView, errorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(EZErrorView *)errorView
{
    return objc_getAssociatedObject(self, kEmptyDataSetView);
}

-(void)setErrorPageDelegate:(id<EZErrorPageDelegate>)errorPageDelegate
{
    objc_setAssociatedObject(self, kErrorPageDelegate, errorPageDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id<EZErrorPageDelegate>)errorPageDelegate
{
    return objc_getAssociatedObject(self, kErrorPageDelegate);
}

-(void)handleSingleTap:(UITapGestureRecognizer *)sender
{
    if (self.errorPageDelegate)
    {
        [self.errorPageDelegate didTapView];
    }
}

@end
