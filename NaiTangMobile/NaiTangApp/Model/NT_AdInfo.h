//
//  NT_AdInfo.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  广告信息

#import <Foundation/Foundation.h>

@interface NT_AdInfo : NSObject

@property (nonatomic,retain) NSString *status;
@property (nonatomic,retain) NSMutableArray *dataArray;

+ (NT_AdInfo *)focusInfoFromDic:(NSDictionary *)dic;

@end

//广告详情
@interface NT_AdDetailInfo : NSObject

@property (nonatomic,retain) NSString *desc,*infoId,*pic,*title,*ctime;
@property (nonatomic,assign) int count;
+ (NT_AdDetailInfo *)infoDetialFromDic:(NSDictionary *)dic;

@end
