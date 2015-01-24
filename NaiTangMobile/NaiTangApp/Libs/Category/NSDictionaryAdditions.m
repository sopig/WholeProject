//
//  NSDictionaryAdditions.m
//  TestFont
//
//  Created by 李军 on 13-4-10.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import "NSDictionaryAdditions.h"


@implementation NSDictionary (Extends)

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue
{
    return [self objectForKey:key] == [NSNull null] ? defaultValue
    : [[self objectForKey:key] boolValue];
}

- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue
{
	return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] intValue];
}

- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue
{
	NSString *stringTime   = [self objectForKey:key];
    if ((id)stringTime == [NSNull null])
    {
        stringTime = @"";
    }
	struct tm created;
    time_t now;
    time(&now);
    
	if (stringTime) {
		if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL)
        {
			strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
		}
		return mktime(&created);
	}
	return defaultValue;
}

- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue
{
	return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] longLongValue];
}

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
	return [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null]
    ? defaultValue : [self objectForKey:key];
}


@end

@implementation NSMutableArray (reverse)

-(void) reverseArray
{
    if( [self count] > 0 )
    {
        int i = 0;
        int j = [self count] - 1;
        while( i < j )
        {
            [self exchangeObjectAtIndex:i withObjectAtIndex:j];
            i++;
            j--;
        }
    }
}

@end
