//
//  NT_BUIControl.h
//  NaiTangApp
//
//  Created by 张正超 on 14-2-26.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  处理Control类别，使用block

#import <Foundation/Foundation.h>

@interface UIControl (NT_BUIControl)

- (void)handleControlEvent:(UIControlEvents)event withBlock:(void(^)(id sender))block;
- (void)removeHandlerForEvent:(UIControlEvents)event;

@end
