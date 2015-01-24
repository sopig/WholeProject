//
//  NT_CategoryInfo.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-13.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_CategoryInfo.h"

@implementation NT_CategoryInfo

- (NT_CategoryInfo *)categoryInfoFrom:(NSDictionary *)dic
{
    NT_CategoryInfo *categoryInfo = [[NT_CategoryInfo alloc] init];
    categoryInfo.title = [dic objectForKey:@"title"];
    categoryInfo.pic = [dic objectForKey:@"pic"];
    categoryInfo.subtitle = [dic objectForKey:@"subtitle"];
    categoryInfo.gameCount = [dic objectForKey:@"gameCount"];
    categoryInfo.linkType = [[dic objectForKey:@"linkType"] integerValue];
    categoryInfo.linkId = [dic objectForKey:@"linkId"];
    return categoryInfo;
}
@end
