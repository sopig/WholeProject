//
//  NT_StatusBarWindow.h
//  NaiTangApp
//
//  Created by 张正超 on 14-2-26.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  状态栏窗口

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface NT_StatusBarWindow : UIWindow

@property (nonatomic, assign) UILabel *textLabel;
@property (nonatomic, strong) NSMutableArray *array;
@property (nonatomic, assign) BOOL isShowing;

+ (void)showMessage:(NSString *)meg;


@end
