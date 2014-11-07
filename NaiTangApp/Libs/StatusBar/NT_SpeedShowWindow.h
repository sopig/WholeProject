//
//  NT_SpeedShowWindow.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  下载速度

#import <UIKit/UIKit.h>

@interface NT_SpeedShowWindow : UIWindow

@property (nonatomic,strong) UILabel *textLabel;

+ (void)showSpeed:(double)speed;
+ (void)hideSpeedView;

@end
