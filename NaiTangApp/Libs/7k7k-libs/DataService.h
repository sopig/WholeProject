//
//  DataService.h
//  WXHL_Weibo_08
//
//  Created by JayWon on 13-10-18.
//  Copyright (c) 2013年 JayWon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
typedef void(^FinishLoadHandle) (id result);
typedef void (^ErrorHandle) (id result);

@interface DataService : NSObject<UIAlertViewDelegate>




+ (ASIHTTPRequest *)requestWithURL:(NSString *)url
                         finishBlock:(FinishLoadHandle)block;
+ (ASIHTTPRequest *)requestWithURL:(NSString *)url
                       finishBlock:(FinishLoadHandle)block errorBlock:(ErrorHandle)errorBlock;


@end
