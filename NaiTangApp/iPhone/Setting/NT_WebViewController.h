//
//  NT_WebViewController.h
//  NaiTangApp
//
//  Created by 张正超 on 14-4-9.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  奶糖网站

#import <UIKit/UIKit.h>

@interface NT_WebViewController : UIViewController <UIWebViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,copy) NSString *webTitle;

@end
