//
//  EGImageBrowser.h
//  zhitu
//
//  Created by 陈少杰 QQ：417365260 on 13-11-1.
//  Copyright (c) 2013年 聆创科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSUInteger, GGOrientation) {
//    GGOrientationPortrait = 0,
//    GGOrientationLandscapeLeft = 1,
//    GGOrientationPortraitUpsideDown = 2,
//    GGOrientationLandscapeRight = 3
//};


@protocol EGImageBrowserDelegate <NSObject>

@optional

/**
 * @brief 远程图片准备开始下载
 */
- (void) EGImageBrowser_ImageWillLoad;

/**
 * @brief 远程图片下载完毕
 */
- (void) EGImageBrowser_ImageDidLoad;

/**
 * @brief 远程图片下载失败
 */
- (void) EGImageBrowser_ImageLoadFailed;

/**
 * @brief 图片即将被展示，view的插入，动画的播放都没开始
 */
- (void) EGImageBrowser_ImageWillAppear;

/**
 * @brief 图片正在被展示, view的插入和动画的播放，刚刚结束
 */
- (void) EGImageBrowser_ImageDidAppear;

/**
 * @brief 图片展示即将被关闭，动画的播放，view的移除，都没开始
 */
- (void) EGImageBrowser_ImageWillDisppear;

/**
 * @brief 图片展示已经被关闭，动画的播放，view的移除，刚刚结束
 */
- (void) EGImageBrowser_ImageDidDisppear;

@end

@interface EGImageBrowser : UIViewController<NSURLConnectionDataDelegate>


//@property (nonatomic, retain) UIImageView *liftedImageView;
//@property (nonatomic, assign) UIInterfaceOrientationMask supportedOrientations;
@property (nonatomic, weak) id<EGImageBrowserDelegate> delegate;

/**
 *	@brief	显示本地图片
 *
 *	@param 指向UIImage的指针
 */
-(void)showImage:(UIImage*)img;

/**
 * @brief 显示网络图片
 *
 * @param 图片的URL
 */
-(void)showImageWithURL:(NSURL *)url;
@end

