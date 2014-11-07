//
//  UIImageAdditions.h
//  DWiPhone
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIImage  (Extends)

//返回一个绽放到newSize可以放下的image
+ (UIImage *)scaledCopyOfSize:(CGSize)newSize image:(UIImage *)image;
//从上到下拼出图片，在最后加上水印
+ (UIImage *) mergeImagesData:(NSArray *)imagesDatas logo:(UIImage *)logo;


- (CGRect)convertCropRect:(CGRect)cropRect;
- (UIImage *)croppedImage:(CGRect)cropRect;
- (UIImage *)resizedImage:(CGSize)size imageOrientation:(UIImageOrientation)imageOrientation;

//创建缩略图，边长，透明边距，圆角，图片质量
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

- (UIImage*)rotate:(UIImageOrientation)orient;

- (UIImage*)resizeImageWithNewSize:(CGSize)newSize;
@end


@interface UIImage (Alpha)

- (BOOL)hasAlpha;

- (UIImage *)imageWithAlpha;
//添加一个透明的边框
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
//给图片添加阴影
-(UIImage *)imageWithShadow:(UIColor*)_shadowColor
				 shadowSize:(CGSize)_shadowSize
					   blur:(CGFloat)_blur;
//将非透明区域填充上color
- (UIImage *)maskWithColor:(UIColor *)color;

- (UIImage *)maskWithColor:(UIColor *)color
			   shadowColor:(UIColor *)shadowColor
			  shadowOffset:(CGSize)shadowOffset
				shadowBlur:(CGFloat)shadowBlur;

@end

@interface UIImage(fixOrientation)
//去除拍照得来的image的Orientation属性，防止其他平台图片出现翻转
- (UIImage *)fixOrientation;

@end

@interface UIImage (RoundedCorner)
//添加圆角及边框
- (UIImage *)roundedCornerImage:(NSInteger)cornerSize borderSize:(NSInteger)borderSize;

//截取一个区域并添加上圆角
- (UIImage*)imageWithRadius:(float) radius
					  width:(float)width
					 height:(float)height;

@end