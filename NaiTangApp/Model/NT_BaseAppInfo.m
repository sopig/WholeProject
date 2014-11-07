//
//  NT_BaseAppInfo.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_BaseAppInfo.h"

@implementation NT_BaseAppInfo

+ (NT_BaseAppInfo *)inforFromDetailArray:(NSMutableArray *)array
{
    NT_BaseAppInfo *info = [[NT_BaseAppInfo alloc] init];
    info.selected = NO;
    info.selectIndex = -1;
    info.infoArray = array;
    return info;
}

@end
