//
//  UIView+UIView_MBProgressHUD.m
//  BaiFuBeauty
//
//  Created by 谷硕 on 13-5-26.
//  Copyright (c) 2013年 谷硕. All rights reserved.
//

#import "UIView_MBProgressHUD.h"

@implementation UIView (UIView_MBProgressHUD)

- (MBProgressHUD *)showLoadingMeg:(NSString *)meg
{
    MBProgressHUD *hudView = [MBProgressHUD HUDForView:self];
    if (!hudView) {
        hudView = [MBProgressHUD showHUDAddedTo:self animated:YES];
    }
    else
    {
        [hudView show:YES];
    }
    hudView.detailsLabelText = meg;
    return hudView;
}
- (void)hideLoading
{
    [MBProgressHUD hideHUDForView:self animated:YES];
}
- (void)showLoadingMeg:(NSString *)meg time:(NSUInteger)time
{
    MBProgressHUD *hud = [self showLoadingMeg:meg];
    hud.mode = MBProgressHUDModeCustomView;
    if (time > 0) {
        [self performSelector:@selector(hideLoading) withObject:nil afterDelay:time];
    }
}
- (void)delayHideLoading
{
    [self performSelector:@selector(hideLoading) withObject:nil afterDelay:kDefaultShowTime];
}
- (void)setLoadingUserInterfaceEnable:(BOOL)enable
{
    [MBProgressHUD HUDForView:self].userInteractionEnabled = enable;
}
@end
