
//
//  NT_DetailNewsInfo.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-14.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_DetailNewsInfo.h"

@implementation NT_DetailNewsInfo

- (NT_DetailNewsInfo *)newsInfoWithDic:(NSDictionary *)dic
{
    NT_DetailNewsInfo *newsInfo = [[NT_DetailNewsInfo alloc] init];
    newsInfo.newsId = [dic objectForKey:@"id"];
    newsInfo.title = [dic objectForKey:@"title"];
    newsInfo.litpic = [dic objectForKey:@"litpic"];
    newsInfo.pubdate = [dic objectForKey:@"pubdate"];
    newsInfo.link = [dic objectForKey:@"link"];
    //newsInfo.categoryName = [dic objectForKey:@"categoryName"];
    return newsInfo;
}

@end
