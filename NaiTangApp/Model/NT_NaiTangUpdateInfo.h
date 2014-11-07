//
//  NT_NaiTangUpdateInfo.h
//  NaiTangApp
//
//  Created by 张正超 on 14-4-21.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  奶糖版本更新，更新信息

#import <Foundation/Foundation.h>

@interface NT_NaiTangUpdateInfo : NSObject

@property (copy,nonatomic) NSString *naitangAppId;
@property (copy,nonatomic) NSString *version_name;
@property (copy,nonatomic) NSString *version_code;
@property (copy,nonatomic) NSString *file_md5;
@property (copy,nonatomic) NSString *type;
@property (copy,nonatomic) NSString *app_file;
@property (copy,nonatomic) NSString *desc;
@property (copy,nonatomic) NSString *plist1;
@property (copy,nonatomic) NSString *plist2;

- (NT_NaiTangUpdateInfo *)updateInfoWithDic:(NSDictionary *)dic;

@end
