//
//  UILabelAdditions.m
//  DWiPhone
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import "UILabelAdditions.h"


@implementation UILabel (Extends)



// Generate a label by the given parameters.
+ (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
                  textColor:(UIColor *)textColor
                       font:(UIFont *)font
                        tag:(NSInteger)tag
                  hasShadow:(BOOL)hasShadow
{
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.text = text;
	label.textColor = textColor;
	label.backgroundColor = [UIColor clearColor];
	if(hasShadow)
    {
		label.shadowColor = [UIColor blackColor];
		label.shadowOffset = CGSizeMake(0,1);
	}
	label.textAlignment = TEXT_ALIGN_CENTER;
	label.font = font;
	label.tag = tag;
#if __has_feature(objc_arc)
    return label;
#else
    return [label autorelease];
#endif
    
}

// colin: generate label with auto calculated frame size
+ (UILabel *) labelWithText:(NSString *)text font:(UIFont *)font x:(CGFloat)x y:(CGFloat)y
{
	CGSize size = [text sizeWithFont:font];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x,y,size.width, size.height)];
	label.text = text;
	label.font = font;
	label.textColor = [UIColor blackColor];
	label.backgroundColor = [UIColor clearColor];
#if __has_feature(objc_arc)
    return label;
#else
    return [label autorelease];
#endif
}


+ (UILabel *) labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font x:(CGFloat)x y:(CGFloat)y
{
	CGSize size = [text sizeWithFont:font];
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x,y,size.width, size.height)];
	label.text = text;
	label.font = font;
	label.textColor = textColor;
	label.backgroundColor = [UIColor clearColor];
#if __has_feature(objc_arc)
    return label;
#else
    return [label autorelease];
#endif
}

+ (UILabel *) labelWithFrame:(CGRect)frame textColor:(UIColor *)textColor font:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = textColor;
    label.backgroundColor = [UIColor clearColor];
    label.font = font;
#if __has_feature(objc_arc)
    return label;
#else
    return [label autorelease];
#endif
}

+ (void) setLableText:(UILabel *)label text:(NSString *)text
{
	CGSize size = [text sizeWithFont:label.font];
	label.text = text;
	CGRect r = label.frame;
    r.size.width = size.width;
    r.size.height = size.height;
    label.frame = r;
}
@end
