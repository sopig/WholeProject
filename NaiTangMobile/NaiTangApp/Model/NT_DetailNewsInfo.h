//
//  NT_DetailNewsInfo.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-14.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  游戏-资讯

#import <Foundation/Foundation.h>

@interface NT_DetailNewsInfo : NSObject

@property (nonatomic,copy) NSString *newsId;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *litpic;
@property (nonatomic,copy) NSString *pubdate;
@property (nonatomic,copy) NSString *link;
//@property (nonatomic,copy) NSString *categoryName;

- (NT_DetailNewsInfo *)newsInfoWithDic:(NSDictionary *)dic;

@end
