//
//  NT_SettingManager.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  更多-设置

#import <Foundation/Foundation.h>
#import "NT_MacroDefine.h"

@interface NT_SettingManager : NSObject

+ (BOOL)showUpdateTips;
+ (void)setShowUpdateTips:(BOOL)showUpdate;

+ (BOOL)onlyDownloadUseWifi;
+ (void)setOnlyDownloadUseWifi:(BOOL)onlyDownloadUseWifi;

+ (BOOL)clearDataWhenQuitNT;
+ (void)setClearDataWhenQuitNT:(BOOL)clearDataWhenQuitNT;

@end
