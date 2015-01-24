//
//  NT_OnlineGameDialog.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  网游下载弹出框

#import <Foundation/Foundation.h>
#import "NT_AppDetailInfo.h"

@interface NT_OnlineGameDialog : UIView

@property (nonatomic,strong)UIControl *bgControl;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UILabel *titTextLabel,*appNameLabel,*scoreLabel,*sizeLabel,*versionLabel,*moneyLabel;
@property (nonatomic,strong)UIImageView *roundView;
@property (nonatomic,strong)EGOImageView *iconImgView;
@property (nonatomic,strong)UIButton *ntDownBtn,*appStoreDownBtn;

- (id)initWithFrame:(CGRect)frame appsInfo:(NT_AppDetailInfo *)appInfo;

@end
