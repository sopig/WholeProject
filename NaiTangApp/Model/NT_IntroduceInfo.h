//
//  NT_IntroduceInfo.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  游戏详情-介绍信息Model

#import <Foundation/Foundation.h>

@interface NT_IntroduceInfo : NSObject

@property (nonatomic,copy) NSString *jre;      //适应固件
@property (nonatomic,copy) NSString *category; //分类
@property (nonatomic,copy) NSString *size;     //大小
@property (nonatomic,copy) NSString *language; //语言
@property (nonatomic,copy) NSString *Developers;//开发商
@property (nonatomic,copy) NSString *detailInfo;//详细信息

+ (NT_IntroduceInfo *)detailInfoFromDic:(NSDictionary *)dic;

@end
