//
//  NT_CustomButtonStyle.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-12.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  自定义按钮样式

#import <Foundation/Foundation.h>

@interface NT_CustomButtonStyle : NSObject

- (void)customButton:(UIButton *)btn title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font bgImage:(UIImage *)bgImage highlightedImage:(UIImage *)highlightedImage;

@end
