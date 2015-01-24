//
//  NTSpeedShowWindow.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_SpeedShowWindow.h"
#import "NT_Singleton.h"
#import "NT_MacroDefine.h"

@implementation NT_SpeedShowWindow
SYNTHESIZE_SINGLETON_FOR_CLASS(NT_SpeedShowWindow)

- (id)init
{
    CGRect frame = CGRectMake(SCREEN_WIDTH-26-100, 0, 140, StatusHeight);
    /*
    if (![[UIDevice currentDevice] isJailbroken]) {
        frame = CGRectMake(SCREEN_WIDTH-48-100+15, 0, 140, StatusHeight);
    }
     */
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        self.clipsToBounds = YES;
        self.windowLevel = UIWindowLevelStatusBar + 10;
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *text = [[UILabel alloc] initWithFrame:self.bounds];
        //text.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        text.backgroundColor = [UIColor clearColor];
        if (isIOS7)
        {
            text.backgroundColor = [UIColor colorWithHex:@"#05aaf1"];
            text.textColor = [UIColor whiteColor];
        }
        else
        {
            text.textColor = [UIColor whiteColor];
            text.backgroundColor = [UIColor blackColor];
        }
        text.font = [UIFont systemFontOfSize:13];
        text.textAlignment = TEXT_ALIGN_CENTER;
        self.textLabel = text;
        [self addSubview:text];
        
        //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateOrientation:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
}

#pragma mark -
#pragma mark Notification Handle

/*
- (void)updateOrientation:(NSNotification*)noti
{
    UIInterfaceOrientation newOrientation = [[noti.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];
    NSLog(@"new orientation: %d", newOrientation);
    
    switch (newOrientation) {
        case UIInterfaceOrientationPortrait:
        {
            self.transform = CGAffineTransformIdentity;
            //self.frame = CGRectMake(0, 0, SCREEN_WIDTH, StatusHeight);
            CGRect frame = CGRectMake(SCREEN_WIDTH-26-100, 0, 100, StatusHeight);
            if (![[UIDevice currentDevice] isJailbroken]) {
                frame = CGRectMake(SCREEN_WIDTH-48-100+15, 0, 100, StatusHeight);
            }
            
            break;
        }
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            // 先转矩阵，坐标系统落在屏幕有右下角，朝上是y，朝左是x
            self.transform = CGAffineTransformMakeRotation(M_PI);
            self.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT - StatusHeight / 2);
            //self.bounds = CGRectMake(0, 0, SCREEN_WIDTH, HEIGHT);
            CGRect frame = CGRectMake(SCREEN_WIDTH-26-100, 0, 100, StatusHeight);
            if (![[UIDevice currentDevice] isJailbroken]) {
                frame = CGRectMake(SCREEN_WIDTH-48-100+15, 0, 100, StatusHeight);
            }
            self.bounds=frame;
            break;
        }
        case UIInterfaceOrientationLandscapeLeft:
        {
            self.transform = CGAffineTransformMakeRotation(-M_PI_2);
            // 这个时候坐标轴已经转了90°，调整x相当于调节竖向调节，y相当于横向调节
            self.center = CGPointMake(StatusHeight / 2, [UIScreen mainScreen].bounds.size.height / 2);
            self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, StatusHeight);
            
            break;
        }
        case UIInterfaceOrientationLandscapeRight:
        {
            // 先设置transform，在设置位置和大小
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
            self.center = CGPointMake(SCREEN_WIDTH - StatusHeight / 2, SCREEN_HEIGHT / 2);
            self.bounds = CGRectMake(0, 0, SCREEN_HEIGHT, StatusHeight);
            
            break;
        }
        default:
            break;
    }
}
*/

- (void)showSpeed:(double)speed
{
    //    if (!speed || ![speed isKindOfClass: class]]) {
    //        return;
    //    }
    NSString *speedStr = @"";
    if (speed>1024*1024) {
        speed /= 1024*1024;
        speedStr = [NSString stringWithFormat:@"%.2fMb/s",speed];
    }else if (speed > 1024)
    {
        speed /= 1024;
        speedStr = [NSString stringWithFormat:@"%.2fKb/s",speed];
    }else
    {
        speedStr = [NSString stringWithFormat:@"%.2fb/s",speed];
    }
    self.textLabel.text = speedStr;
    self.hidden = NO;
}

+ (void)showSpeed:(double)speed
{
    [[NT_SpeedShowWindow sharedNT_SpeedShowWindow] showSpeed:speed];
}

+ (void)hideSpeedView
{
    [NT_SpeedShowWindow sharedNT_SpeedShowWindow].hidden = YES;
}


@end
