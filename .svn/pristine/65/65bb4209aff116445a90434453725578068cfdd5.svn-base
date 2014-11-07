//
//  LevelModel.m
//  PartnerProject7k
//
//  Created by 王明远 on 13-12-12.
//  Copyright (c) 2013年 王明远. All rights reserved.
//

#import "LevelModel.h"

@implementation LevelModel



- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.html = [dictionary objectForKey:@"url"];
        self.titleText = [dictionary objectForKey:@"title"];
        self.shortTitleText = [dictionary objectForKey:@"title"];
        self.bodyStr = [dictionary objectForKey:@"body"];
        self.img = [dictionary objectForKey:@"image"];
        self.content = [dictionary objectForKey:@"desc"];
        self.updatetime = [dictionary objectForKey:@"updatetime"];
        self.gameName = [dictionary objectForKey:@"gameName"];
        self.litpicImg = [dictionary objectForKey:@"litpic"];
        
        // webViewTitle 和 webViewContent 是用于webView的内容和标题的展示的数据
        // 有两种接口，在一种接口里面有"body"和"title"，一种是"content"和"gameName"
        // 下面的操作是为了适配这两种情况
        if (self.bodyStr) {
            self.webViewContent = self.bodyStr;
        }else{
            self.webViewContent = [dictionary objectForKey:@"content"];
        }
        if (self.shortTitleText) {
            self.webViewTitle = self.shortTitleText;
        }else{
            self.webViewTitle = [dictionary objectForKey:@"gameName"];
        }
    }
    return self;
}


@end
