//  NSString(Base64)
//  DJGameCenter4ALL
//
//  Created by thilong on 13-8-12.
//  Copyright (c) 2012 thilong.tao. All rights reserved.
//  Description: 


#import "NSString+Base64.h"
#import "NSData+Base64.h"

@implementation NSString (Base64)
+ (NSString *)stringFromBase64String:(NSString *)str
{

    NSData *data = [NSData dataFromBase64String:str];
    if (data)
    {
        return [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    }
    else
    {
        return nil;
    }
}

- (NSString *)base64String
{
    static NSString *LocalStr_None = @"";
    if (self && ![self isEqualToString:LocalStr_None])
    {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        return [data base64EncodedString];
    }
    else
    {
        return nil;
    }
}


@end