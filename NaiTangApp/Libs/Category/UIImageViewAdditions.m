//
//  UIImageViewAdditions.m
//  TestFont
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import "UIImageViewAdditions.h"

#define kCoverViewTag           1000
#define kImageViewTag           1001
#define kAnimationDuration      0.3f
#define kImageViewWidth         300.0f
#define kBackViewColor          [UIColor colorWithWhite:0.667 alpha:0.5f]
#define COLOR_WITH_ARGB(R,G,B,A)            [UIColor colorWithRed:R / 255.0 green:G / 255.0 blue:B / 255.0 alpha:A]


@implementation UIImageView (UIImageViewEx)

-(void)hiddenView
{
    UIView *coverView = (UIView *)[[self window] viewWithTag:kCoverViewTag];
    [coverView removeFromSuperview];
    
}

-(void)hiddenViewAnimation
{
    UIImageView *imageView = (UIImageView *)[[self window] viewWithTag:kImageViewTag];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration];
    //CGRect rect = [self convertRect:self.bounds fromView:self.window];
    CGRect rect = [self convertRect:self.bounds toView:self.window];
    imageView.frame = rect;
    [UIView commitAnimations];
    [self performSelector:@selector(hiddenView) withObject:nil afterDelay:kAnimationDuration];
}

//自动按原UIImageView等比例调整目标rect
-(CGRect)autoFitFrame
{
    //调整为固定宽，高等比例动态变化
    float width = kImageViewWidth;
    float targeHeight = (width*self.frame.size.height)/self.frame.size.width;
    UIView *coverView = (UIView *)[[self window] viewWithTag:kCoverViewTag];
    CGRect targeRect = CGRectMake(coverView.frame.size.width/2 - width/2, coverView.frame.size.height/2-targeHeight/2, width, targeHeight);
    return targeRect;
}

-(void)imageTap
{
    UIView *coverView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
#if !__has_feature(objc_arc)
    [coverView autorelease];
#endif
    coverView.backgroundColor = COLOR_WITH_ARGB(0, 0, 0, 0.7);
    coverView.tag = kCoverViewTag;
    UITapGestureRecognizer *hiddenView = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenViewAnimation)];
    [coverView addGestureRecognizer:hiddenView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self.image];
    imageView.tag = kImageViewTag;
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = self.contentMode;
    //CGRect rect = [self convertRect:self.bounds fromView:self.window];
    //得到图片相对于window的相对坐标
    CGRect rect = [self convertRect:self.bounds toView:self.window];
    imageView.frame = rect;
    
    [coverView addSubview:imageView];
    [[self window] addSubview:coverView];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kAnimationDuration];
    imageView.frame = [self autoFitFrame];
    [UIView commitAnimations];
}

-(void)show
{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap)];
    [self addGestureRecognizer:tapGestureRecognizer];
}

@end



@implementation UIImageView(create)
+ (UIImageView *)imageViewWithName:(NSString *)name
{
    UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    view.backgroundColor = [UIColor clearColor];
#if __has_feature(objc_arc)
    return view;
#else
    return [view autorelease];
#endif
}
+ (UIImageView *)imageViewWithFrame:(CGRect)frame andImage:(UIImage *)image
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor clearColor];
    view.image = image;
#if __has_feature(objc_arc)
    return view;
#else
    return [view autorelease];
#endif
}
@end
