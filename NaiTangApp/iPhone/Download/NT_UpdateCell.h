//
//  NT_UpdateCell.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-15.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NT_FinishedCell.h"

@class NT_UpdateAppInfo,NT_CustomButtonStyle;

@interface NT_UpdateCell : NT_FinishedCell

@property (nonatomic,strong) UILabel *updateInfoLabel;
@property (nonatomic,strong) NT_CustomButtonStyle *customButtonStyle;
@property (nonatomic,strong) UIView *splitView;

//是否展开更新信息 是否是忽略状态
- (void)refreshUpdateData:(NT_UpdateAppInfo *)updateInfo isOpenUpdate:(BOOL)isUpdate isAllIgnore:(BOOL)isAllIgnore;

//展开更新详情
+ (CGFloat)openUpdateDetailInfo:(NT_UpdateAppInfo *)updateInfo;

@end
