//
//  NT_CustomButtonStyle.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-12.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_CustomButtonStyle.h"

@implementation NT_CustomButtonStyle

/*
- (UIButton *)customButton:(UIButton *)btn title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font bgImage:(UIImage *)bgImage highlightedImage:(UIImage *)highlightedImage
{
    UIButton *button = btn;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setBackgroundImage:bgImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
    return button;
}
 */

- (void)customButton:(UIButton *)btn title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font bgImage:(UIImage *)bgImage highlightedImage:(UIImage *)highlightedImage
{
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:font];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn setBackgroundImage:bgImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightedImage forState:UIControlStateHighlighted];
}

@end
