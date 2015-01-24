//
//  NT_ZXObject.h
//  NaiTangApp
//
//  Created by 张正超 on 14-2-26.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (NT_ZXObject)

//perform block1 in main thread,when finished perform block2 in background
+(void)perform:(void(^)())block1 withCompletionHandler:(void (^)())block2;
-(void)perform:(void(^)())block1 withCompletionHandler:(void (^)())block2;

//add by gus n秒后执行block块
+ (void)perform:(void(^)())block afterDelay:(NSTimeInterval)delay;
- (void)perform:(void(^)())block afterDelay:(NSTimeInterval)delay;

//use ZXObject to deliver param(copy)
-(void)setZXObject:(id)obj;
-(id)getZXObject;

//设置一个block作为回调
-(void)handlerDefaultEventwithBlock:(id)block;
-(id)blockForDefaultEvent;
- (void)callBlockForDefaultEvent;
//send object
-(void)receiveObject:(void(^)(id object))sendObject;
-(void)sendObject:(id)object;

@end

