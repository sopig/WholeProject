//
//  NSObjectAdditions.m
//  Satellite
//
//  Created by 李军 on 13-4-20.
//  Copyright (c) 2013年 李军. All rights reserved.
//

#import "NSObjectAdditions.h"

@implementation NSObject (Extends)

//把传进来的数据为NSNull的对象移除
+ (id)turnNullToNilForObject:(id)item
{
    if([item isKindOfClass:[NSDictionary class]]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:item];
        for (NSString *key in [dic allKeys]) {
            id value = [dic objectForKey:key];
            id o = [self turnNullToNilForObject:value];
            if (o) {
                [dic setObject:o forKey:key];
            }
            else {
                [dic removeObjectForKey:key];
            }
        }
        return dic;
    }
    else if([item isKindOfClass:[NSArray class]]){
        NSMutableArray *arr= [NSMutableArray arrayWithArray:item];
        for (int i = [arr count]-1; i >= 0; i--) {
            id value = [arr objectAtIndex:i];
            id o = [self turnNullToNilForObject:value];
            if (o) {
                [arr replaceObjectAtIndex:i withObject:o];
            }
            else {
                [arr removeObjectAtIndex:i];
            }
        }
        return arr;
    }
    return [item nullTonil];
}
- (id)nullTonil
{
    if ([self isKindOfClass:[NSNull class]]) {
        return nil;
    }
    /*
     //number turn to string
     if ([self isKindOfClass:[NSNumber class]]) {
     NSNumber *number = (NSNumber *)self;
     int num = (int)([number floatValue] * 1000);
     if (num % 1000) {
     return [NSString stringWithFormat:@"%.03f",[number floatValue]];
     }
     else{
     return [NSString stringWithFormat:@"%d",[(NSNumber *)self intValue]];
     }
     }
     */
    return self;
}
- (id)objcetByRemoveNullObjects
{
    return [NSObject turnNullToNilForObject:self];
}
- (void)setArchiveredObject:(NSObject *)object forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKey:key];
}
- (id)archiveredObjectForKey:(NSString *)key
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
}
@end
