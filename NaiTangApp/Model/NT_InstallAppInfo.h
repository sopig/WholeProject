//
//  NT_InstallAppInfo.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  下载-已安装的数据Model

#import <Foundation/Foundation.h>

@interface NT_InstallAppInfo : NSObject

@property (nonatomic,strong) NSString *appType,*appName,*appIdentifier,*appVersion,*appURLSchemes,*appPath,*homePath,*fileSize;
@property (nonatomic,strong) NSString *appSizeString,*doucumentSizeString,*totalSizeString;
@property (nonatomic,strong) UIImage *iconImage,*appIcon;
@property (nonatomic,strong) NSString *openUrlScheme;

+ (NT_InstallAppInfo *)infoFromDic:(NSDictionary *)dic;
//计算程序大小
- (void)calculateAppSize;

@end
