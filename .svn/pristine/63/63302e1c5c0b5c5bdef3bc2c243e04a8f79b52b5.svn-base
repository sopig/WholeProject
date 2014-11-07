//
//  UITextViewAdditions.m
//  TestFont
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import "UITextViewAdditions.h"
#import <QuartzCore/QuartzCore.h>

@implementation UITextView (Extends)

+ (UITextView *)textViewWithFrame:(CGRect)frame
                        textColor:(UIColor *)textColor
                      borderColor:(UIColor *)borderColor
                             font:(UIFont *)font
                     keyboardType:(UIKeyboardType)keyboardType
                         delegate:(id)delegate
{
	UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.layer.cornerRadius = 8;
    textView.layer.masksToBounds = YES;
    textView.layer.borderWidth = 1;
    textView.layer.borderColor = [borderColor CGColor];
    textView.textColor = textColor;
    textView.delegate = delegate;
    textView.keyboardType = keyboardType;
    textView.font = font;
#if __has_feature(objc_arc)
    return textView;
#else
    return [textView autorelease];
#endif
}

- (void) insertString: (NSString *) insertingString
{
    NSRange range = self.selectedRange;
    NSString * firstHalfString = [self.text substringToIndex:range.location];
    NSString * secondHalfString = [self.text substringFromIndex: range.location + range.length];
    self.scrollEnabled = NO;  // turn off scrolling or you'll get dizzy ... I promise
	
    self.text = [NSString stringWithFormat: @"%@%@%@",
                 firstHalfString,
                 insertingString,
                 secondHalfString];
    //range.length = [insertingString length];
    range.location = range.location + [insertingString length];
	range.length = 0;
	self.scrollEnabled = YES;  // turn scrolling back on.
    self.selectedRange = range;
	
}
@end
