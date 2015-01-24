//
//  NT_BaseAppInfo.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  游戏基本信息

#import <Foundation/Foundation.h>

@interface NT_BaseAppInfo : NSObject

@property (nonatomic) BOOL selected;
@property (nonatomic) int selectIndex;
@property (nonatomic) NSMutableArray *infoArray;

+ (NT_BaseAppInfo *)inforFromDetailArray:(NSMutableArray *)array;

@end
