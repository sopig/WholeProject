//
//  UIButtonAdditions.h
//  DWiPhone
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIButton (Extends)


+ (UIButton *)buttonWithType:(NSUInteger)type
					   title:(NSString *)title
					   frame:(CGRect)frame
                      cImage:(UIImage *)cImage
                     bgImage:(UIImage *)bgImage
				 tappedImage:(UIImage *)tappedImage
					  target:(id)target
					  action:(SEL)selector;

+ (UIButton *)buttonWithType:(NSUInteger)type
					   title:(NSString *)title
					   frame:(CGRect)frame
                      cImage:(UIImage *)cImage
                     bgImage:(UIImage *)bgImage
            highlightedImage:(UIImage *)highlightedImage
					  target:(id)target
					  action:(SEL)selector;


+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                      bgImage:(UIImage *)bgImage
                   titleColor:(UIColor *)aColor
                       target:(id)target
                       action:(SEL)selector;

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        title:(NSString *)title
                        image:(UIImage *)image
                   titleColor:(UIColor *)aColor
                       target:(id)target
                       action:(SEL)selector;

+ (UIButton *)buttonWithFrame:(CGRect)frame
                        image:(UIImage *)image
                       target:(id)target
                       action:(SEL)selector;

@end
