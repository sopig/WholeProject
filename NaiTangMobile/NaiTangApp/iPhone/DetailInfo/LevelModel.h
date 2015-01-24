//
//  LevelModel.h
//  PartnerProject7k
//
//  Created by 王明远 on 13-12-12.
//  Copyright (c) 2013年 王明远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LevelModel : NSObject


@property (nonatomic,strong)NSString * html;   //
@property (nonatomic,strong)NSString * titleText;   //标题
@property (nonatomic,strong)NSString * shortTitleText;//短标题
@property (nonatomic,strong)NSString * bodyStr;      //
@property (nonatomic,strong)NSString * img;
@property (nonatomic,strong)NSString * content;
@property (nonatomic,strong)NSString * updatetime;//时间
@property (nonatomic,strong)NSString * gameName;

@property (nonatomic,strong)NSString * litpicImg;

@property (nonatomic, assign) BOOL  isCollected; //是否收藏


// webView里面的内容
@property (nonatomic,strong)NSString * webViewContent;

// webView里面的文章标题
@property (nonatomic,strong)NSString * webViewTitle;

- (id)initWithDictionary:(NSDictionary *)dictionary;


@end
