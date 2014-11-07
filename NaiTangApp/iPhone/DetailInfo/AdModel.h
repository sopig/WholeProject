//
//  CityModel.h
//  FFWxercise
//
//  Created by 北欧 on 13-8-5.
//  Copyright (c) 2013年 IOS那些事. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AdModel : NSObject


@property (nonatomic,strong)NSString * img;   //图片
@property (nonatomic,strong)NSString * title;   //类型
@property (nonatomic,strong)NSString * url;      //网址
@property (nonatomic,strong)NSString * desc;    //标题
@property (nonatomic,strong)NSString * type;//区分文章页 itunes


- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
