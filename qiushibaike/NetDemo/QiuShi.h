//
//  QiuShi.h
//  NetDemo
//
//  Created by 海锋 周  on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QiuShi : NSObject
{
    //小图片链接地址
    NSString *imageURL;
    //大图片链接地址
    NSString *imageMidURL;
    //发布时间
    NSTimeInterval published_at;
    //标签
    NSString *tag;
    //糗事id
    NSString *qiushiID;
    //内容
    NSString *content;
    //评论数量
    int commentsCount;
    //顶的数量
    int upCount;
    //踩的数量
    int downCount;
    //作者
    NSString *anchor;
 
    
}

@property (nonatomic,copy) NSString *imageURL;
@property (nonatomic,copy) NSString *imageMidURL;
@property (nonatomic,assign) NSTimeInterval published_at;
@property (nonatomic,copy) NSString *tag;
@property (nonatomic,copy) NSString *qiushiID;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,assign) int commentsCount;
@property (nonatomic,assign) int downCount;
@property (nonatomic,assign) int upCount;
@property (nonatomic,copy) NSString *anchor;
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
