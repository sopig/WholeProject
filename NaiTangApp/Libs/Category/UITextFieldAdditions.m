//
//  UITextFieldAdditions.m
//  DWiPhone
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import "UITextFieldAdditions.h"


@implementation UITextField (Extends)




+ (UITextField *)textFieldWithFrame:(CGRect)frame
						borderStyle:(UITextBorderStyle)borderStyle
						  textColor:(UIColor *)textColor
					backgroundColor:(UIColor *)backgroundColor
							   font:(UIFont *)font
					   keyboardType:(UIKeyboardType)keyboardType
					  returnKeyType:(UIReturnKeyType)returnKeyType
                        placeholder:(NSString *)placeholder
								tag:(NSInteger)tag 
                           delegate:(id)delegate {
	UITextField *textField = [[UITextField alloc] initWithFrame:frame];
	textField.borderStyle = borderStyle;
    if (textColor) {
        textField.textColor = textColor;
    }
	if (backgroundColor) {
        textField.backgroundColor = backgroundColor;
    }
    if (font) {
        textField.font = font;
    }
    if (placeholder) {
        textField.placeholder = placeholder;
    }
	
	textField.keyboardType = keyboardType;
	textField.returnKeyType = returnKeyType;
	textField.tag = tag;
	textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	textField.leftViewMode = UITextFieldViewModeUnlessEditing;
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.delegate = delegate;
    
	return textField;
}


@end
