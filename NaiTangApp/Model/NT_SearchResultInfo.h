//
//  NT_SearchResultInfo.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  搜索-搜索结果

#import <Foundation/Foundation.h>

@interface NT_SearchResultInfo : NSObject

@property (nonatomic,retain)NSString *appId,*game_name,*round_pic,*summary,*game_size,*game_score,*game_new_version;
@property (nonatomic,strong)NSArray *pic_allArray;
@property (nonatomic,assign)BOOL is_much_money;

@end
