//
//  UITextViewAdditions.h
//  TestFont
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extends)

+ (UITextView *)textViewWithFrame:(CGRect)frame
                        textColor:(UIColor *)textColor
                      borderColor:(UIColor *)borderColor
                             font:(UIFont *)font
                     keyboardType:(UIKeyboardType)keyboardType
                         delegate:(id)delegate;


- (void) insertString: (NSString *) insertingString;

@end
