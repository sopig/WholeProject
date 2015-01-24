//
//  OCChannel.m
//  MixDemo
//
//  Created by  张正超 on 14/11/17.
//  Copyright (c) 2014年 zhengchaoZhang. All rights reserved.
//

#import "OCChannel.h"
#import "SwiftModule-swift.h"

@interface OCChannel ()
{
    ViewController *vc;
}

@end

@implementation OCChannel

- (void)say
{
    NSLog(@"haha");
    
    vc =[[ViewController alloc]init];
    
    [vc saysay];
    
}


@end
