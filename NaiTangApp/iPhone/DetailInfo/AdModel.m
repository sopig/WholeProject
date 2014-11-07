//
//  CityModel.m
//  FFWxercise
//
//  Created by 北欧 on 13-8-5.
//  Copyright (c) 2013年 IOS那些事. All rights reserved.
//

#import "AdModel.h"

@implementation AdModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.img = [dictionary objectForKey:@"image"];
        self.title = [dictionary objectForKey:@"title"];
        self.url = [dictionary objectForKey:@"adurl"];
        self.desc = [dictionary objectForKey:@"desc"];
        self.type = [dictionary objectForKey:@"type"];
    }
    return self;
}



@end
