//
//  UIButtonAdditions.m
//  DWiPhone
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import "UIButtonAdditions.h"

@implementation UIButton (Extends)

+ (UIButton *)buttonWithType:(NSUInteger)type
					   title:(NSString *)title
					   frame:(CGRect)frame
                      cImage:(UIImage *)cImage
                     bgImage:(UIImage *)bgImage
				 tappedImage:(UIImage *)tappedImage
					  target:(id)target
					  action:(SEL)selector
{
    
    UIButton *btn = [UIButton buttonWithType:type];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:cImage forState:UIControlStateNormal];
    [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
    [btn setImage:tappedImage forState:UIControlStateSelected];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	return btn;
}

+ (UIButton *)buttonWithType:(NSUInteger)type
					   title:(NSString *)title
					   frame:(CGRect)frame
                      cImage:(UIImage *)cImage
                     bgImage:(UIImage *)bgImage
            highlightedImage:(UIImage *)highlightedImage
					  target:(id)target
					  action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:type];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:cImage forState:UIControlStateNormal];
    [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
    [btn setImage:highlightedImage forState:UIControlStateHighlighted];
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	return btn;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                        image:(UIImage *)image
                   titleColor:(UIColor *)aColor
                       target:(id)target
                       action:(SEL)selector;
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    [btn setTitleColor:aColor forState:UIControlStateNormal];
    
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        image:(UIImage *)image
                       target:(id)target
                       action:(SEL)selector
{
    return [self buttonWithFrame:frame title:nil image:image titleColor:nil target:target action:selector];
}

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                      bgImage:(UIImage *)bgImage
                   titleColor:(UIColor *)aColor
                       target:(id)target
                       action:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
    if (aColor) {
        [btn setTitleColor:aColor forState:UIControlStateNormal];
    }
    if (target) {
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}


@end