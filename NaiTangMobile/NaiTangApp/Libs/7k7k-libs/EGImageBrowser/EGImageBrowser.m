//
//  EGImageBrowser.m
//  zhitu
//
//  Created by 陈少杰 on 13-11-1.
//  Copyright (c) 2013年 聆创科技有限公司. All rights reserved.
//

#import "EGImageBrowser.h"
#import <QuartzCore/QuartzCore.h>


static CGRect frameBeforeMove;
static CGRect frameAfterMove;
#define moveY 50

//static const double kAnimationDuration = 0.3;
//
//static inline GGOrientation convertOrientation(UIInterfaceOrientation orientation) {
//    switch (orientation) {
//        case UIInterfaceOrientationPortrait:
//            return GGOrientationPortrait;
//            break;
//        case UIInterfaceOrientationLandscapeLeft:
//            return GGOrientationLandscapeLeft;
//            break;
//        case UIInterfaceOrientationPortraitUpsideDown:
//            return GGOrientationPortraitUpsideDown;
//            break;
//        case UIInterfaceOrientationLandscapeRight:
//            return GGOrientationLandscapeRight;
//            break;
//        default:
//            break;
//    }
//}
//
//static inline NSInteger RadianDifference(UIInterfaceOrientation from, UIInterfaceOrientation to) {
//    GGOrientation gg_from = convertOrientation(from);
//    GGOrientation gg_to = convertOrientation(to);
//    return gg_from-gg_to;
//}


@interface EGImageBrowser () <UIScrollViewDelegate>

@property (nonatomic, strong) UIWindow * win;
@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage * image;
@property (nonatomic, assign) UIInterfaceOrientation fromOrientation;
@property (nonatomic, assign) UIInterfaceOrientation toOrientation;

@property (nonatomic, strong) NSURLConnection * urlConnection;
@property (nonatomic, strong) UIActivityIndicatorView * loadingView;

// urlConnection 过程中 存储多次传递过来的数据
@property (nonatomic, strong) NSMutableData *urlData;

- (void) onDismiss:(UITapGestureRecognizer *)tap;

@end

@implementation EGImageBrowser

- (id) init {
    self = [super init];
//    if (self) {
//        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        self.supportedOrientations = UIInterfaceOrientationMaskAll;
//    }
    return self;
}

/**
 * @brief 根据传递的URL地址，下载图片，下载完成之后调用showImage: 方法展示之
 */
-(void)showImageWithURL:(NSURL *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
	NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    self.urlConnection = connection;
    
    self.win=[UIApplication sharedApplication].keyWindow;
    
    // 初始化loading图，使其居中显示
    self.loadingView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    _loadingView.center = CGPointMake(([UIScreen mainScreen].bounds.size.width)/2.0, ([UIScreen mainScreen].bounds.size.height)/2.0);
    _loadingView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    _loadingView.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
    _loadingView.layer.cornerRadius = 10;
    [_win addSubview:_loadingView];
    [_loadingView startAnimating];
    
    
    // stores data as it's loaded from the request
	self.urlData = [[NSMutableData alloc] init];
    
    [_urlConnection start];
    
    // 回调
    if([self.delegate respondsToSelector:@selector(EGImageBrowser_ImageWillLoad)]){
        [self.delegate EGImageBrowser_ImageWillLoad];
    }
}


/**
 * 此处展示图片动画的效果是：
 * 设定图片展示之后，宽度为屏幕宽度，垂直居中。再根据图片原始宽高计算 等比的新高度
 * 显示动画时，显示隐藏图片所在层，让图片比居中的y值小 moveY。然后通过animation切换到居中时的y值
 */
-(void)showImage:(UIImage *)img{
    _image=img;
    float originWidth = _image.size.width;
    float originHeight = _image.size.height;
    float targetWidth = [UIScreen mainScreen].bounds.size.width;
    float targetHeight = originHeight*targetWidth/originWidth;
    float targetY = ([UIScreen mainScreen].bounds.size.height-targetHeight)/2;
    
    
    self.win=[UIApplication sharedApplication].keyWindow;
    self.backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    // 父级的宽高的改变都会导致self.view的尺寸的变化
    _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    _backgroundView.backgroundColor = [UIColor blackColor];
    _backgroundView.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    _backgroundView.alpha=0;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:_backgroundView.bounds];
    _scrollView.delegate = self;
    
    // 可以控制图片缩放的最大值
    _scrollView.maximumZoomScale = 2;
    
    //水平滚动条隐藏
    _scrollView.showsHorizontalScrollIndicator=NO;
    
    //垂直滚动条隐藏
    _scrollView.showsVerticalScrollIndicator=NO;
    
    // 默认是NO, 可以在垂直和水平方向同时运动
    // 当值是YES, 假如一开始是垂直或者是水平运动,那么接下来会锁定另外一个方向的滚动
    // 假如一开始是对角方向滚动,则不会禁止某个方向
    _scrollView.directionalLockEnabled = NO;
    _scrollView.contentSize = CGSizeMake(targetWidth, 0);
    _scrollView.autoresizingMask = _backgroundView.autoresizingMask;
    [_backgroundView addSubview:_scrollView];
    
    
    self.containerView = [[UIView alloc] initWithFrame:_scrollView.bounds];
    _containerView.autoresizingMask = _backgroundView.autoresizingMask;
    [_scrollView addSubview:_containerView];
    
    self.imageView=[[UIImageView alloc]initWithFrame:frameBeforeMove];
    _imageView.autoresizingMask = _backgroundView.autoresizingMask;
    _imageView.userInteractionEnabled = YES;
    _imageView.image=_image;
    _imageView.tag=1;
    [_containerView addSubview: _imageView];
    
    
    frameBeforeMove = CGRectMake(0, targetY-moveY, targetWidth, targetHeight);
    frameAfterMove = CGRectMake(0,targetY, targetWidth, targetHeight);
    
    
    // 回调
    if([self.delegate respondsToSelector:@selector(EGImageBrowser_ImageWillAppear)]){
        [self.delegate EGImageBrowser_ImageWillAppear];
    }
    
    [_win addSubview:_backgroundView];
    
    
    

    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onDismiss:)];
    [_backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        _imageView.frame=frameAfterMove;
        _backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        if([self.delegate respondsToSelector:@selector(EGImageBrowser_ImageDidAppear)]){
            [self.delegate EGImageBrowser_ImageDidAppear];
        }
    }];
}


- (void) onDismiss:(UITapGestureRecognizer*)tap {
    // 回调
    if ([self.delegate respondsToSelector:@selector(EGImageBrowser_ImageWillDisppear)]) {
        [self.delegate EGImageBrowser_ImageWillDisppear];
    }
    

    [UIView animateWithDuration:0.3 animations:^{
        _imageView.frame=frameBeforeMove;
        _backgroundView.alpha=0;
    } completion:^(BOOL finished) {
        [_backgroundView removeFromSuperview];
        _backgroundView = nil;
        _containerView = nil;
        _scrollView = nil;
        _imageView = nil;
        _image = nil;
        if([self.delegate respondsToSelector:@selector(EGImageBrowser_ImageDidDisppear)]){
            [self.delegate EGImageBrowser_ImageDidDisppear];
        }
    }];
    
}


#pragma mark - UIScrollViewDelegate


- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.containerView;
}


#pragma mark - NSURLConnectionDelegate

/**
 * 使用_urlData来存储服务端返回的图片数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_urlData appendData:data];
}


/**
 * @brief 下载图片成功之后，如果有回调则调用，移除loading，调用showImage: 方法显示该图片
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    // 回调
    if([self.delegate respondsToSelector:@selector(EGImageBrowser_ImageDidLoad)]){
        [self.delegate EGImageBrowser_ImageDidLoad];
    }
    
    // 停止loading图，移除之
    [_loadingView stopAnimating];
    [_loadingView removeFromSuperview];
    
    if(_urlData){
        UIImage * img = [UIImage imageWithData:_urlData];
        [self showImage:img];
    }
}

/**
 * @brief 下载图片失败之后，移除loading，如果有回调则调用
 */
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    // 回调
    if ([self.delegate respondsToSelector:@selector(EGImageBrowser_ImageLoadFailed)]) {
        [self.delegate EGImageBrowser_ImageLoadFailed];
    }
    
    // 停止loading图，移除之
    [_loadingView stopAnimating];
    [_loadingView removeFromSuperview];
}

@end
