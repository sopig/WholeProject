//
//  NTAppDelegate.h
//  NaiTangApp
//
//  Created by 张正超 on 14-2-26.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NT_MainViewController.h"
#import "ASIDownloadCache.h"

@interface NTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UITabBarController *tabController;
@property (strong, nonatomic) NT_MainViewController *mainController;
@property (strong, nonatomic) ASIDownloadCache * myCache;

+ (NTAppDelegate *)shareNTAppDelegate;

//加载根控制器
- (void)loadRootViewControl:(UIApplication *)application;
//加载数据
- (void)loadRootData;

//获取游戏更新数量
- (void)getGameUpdateCount;

//by thilong
-(void)setDownloadBadgeValue:(NSString *)val;

@property (nonatomic,readonly) BOOL installProxyStarted;
- (BOOL) beginHttpServer;

@end
