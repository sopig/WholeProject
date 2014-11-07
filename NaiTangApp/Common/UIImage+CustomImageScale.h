//
//  UIImage+CustomImageScale.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  根据图片高度进行缩放

#import <UIKit/UIKit.h>

@interface UIImage (CustomImageScale)

//根据图片高度来缩放图片
- (UIImage *)scaleWithImageHeight:(CGFloat)imageHeight;

@end
