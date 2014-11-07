//
//  NT_UncaughtExceptionHandler.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NT_UncaughtExceptionHandler : NSObject <UIAlertViewDelegate>
{
    BOOL dismissed;
}
@property (nonatomic,strong) NSException *exceptions;

@end

void HandleException(NSException *exception);
void SignalHandler(int signal);
void InstallUncaughtExceptionHandler(void);

