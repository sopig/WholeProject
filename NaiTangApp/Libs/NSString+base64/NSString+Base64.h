//  NSString(Base64)
//  DJGameCenter4ALL
//
//  Created by thilong on 13-8-12.
//  Copyright (c) 2012 thilong.tao. All rights reserved.
//  Description: 


#import <Foundation/Foundation.h>

@interface NSString (Base64)

+ (NSString *)stringFromBase64String:(NSString *)str;

- (NSString *)base64String;

@end