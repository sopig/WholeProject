//
//  UIView+UIView_MBProgressHUD.h
//  BaiFuBeauty
//
//  Created by 谷硕 on 13-5-26.
//  Copyright (c) 2013年 谷硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#define kDefaultShowTime 1
@interface UIView (UIView_MBProgressHUD)

- (MBProgressHUD *)showLoadingMeg:(NSString *)meg;
- (void)hideLoading;
- (void)showLoadingMeg:(NSString *)meg time:(NSUInteger)time;
- (void)delayHideLoading;//2秒后消失
- (void)setLoadingUserInterfaceEnable:(BOOL)enable;
@end
