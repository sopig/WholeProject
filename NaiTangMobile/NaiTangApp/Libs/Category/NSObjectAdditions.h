//
//  NSObjectAdditions.h
//  Satellite
//
//  Created by 李军 on 13-4-20.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Extends)

//把传进来的数据为NSNull的对象移除
+ (id)turnNullToNilForObject:(id)item;
- (id)nullTonil;
- (id)objcetByRemoveNullObjects;

- (void)setArchiveredObject:(NSObject *)object forKey:(NSString *)key;
- (id)archiveredObjectForKey:(NSString *)key;
@end
