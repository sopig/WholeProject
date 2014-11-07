//
//  UILabelAdditions.h
//  DWiPhone
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UILabel (Extends)

// --------------------------------------------------------------------
// Creation

+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  textColor:(UIColor *)textColor
                       font:(UIFont *)font
                        tag:(NSInteger)tag
                  hasShadow:(BOOL)hasShadow;


+ (UILabel *) labelWithText:(NSString *)text font:(UIFont *)font x:(CGFloat)x y:(CGFloat)y;
+ (UILabel *) labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font x:(CGFloat)x y:(CGFloat)y;

+ (UILabel *) labelWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font;

// --------------------------------------------------------------------
// Property Setting

+ (void) setLableText:(UILabel *)label text:(NSString *)text;


@end
