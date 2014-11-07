//
//  NT_MainSecondCell.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  下载方式：无限金币版 纯净正版 纯净版

#import <UIKit/UIKit.h>
#import "NT_AppDetailInfo.h"

@protocol NT_MainSecondCellDelegate;

@interface NT_MainSecondCell : UITableViewCell

@property (nonatomic,assign) id<NT_MainSecondCellDelegate>delegates;
@property (nonatomic,strong) NT_AppDetailInfo *appsInfoDetail;

//Cell弹出框的高度
+ (float)heightForAppsInfoDetail:(NT_AppDetailInfo *)info;
- (void)formatWithAppsInfoDetail:(NT_AppDetailInfo *)info;

@end

@protocol NT_MainSecondCellDelegate <NSObject>

- (void)installSecondCell:(NT_MainSecondCell *)installSecondCell installIndex:(int)index;

@end