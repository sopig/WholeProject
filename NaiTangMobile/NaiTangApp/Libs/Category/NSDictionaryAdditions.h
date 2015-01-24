//
//  NSDictionaryAdditions.h
//  TestFont
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (Extends)

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;

- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue;

- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;

- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;

@end

@interface NSMutableArray (reverse)

-(void) reverseArray;

@end