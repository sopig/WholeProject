//
//  NT_BaseView.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  通用列表样式显示

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface NT_BaseView : UIView

@property (nonatomic,strong) UIImageView  *verticalLine, *scoreImageView,*roundCornerImageView;
@property (nonatomic,strong) UILabel *appName,*scoreLabel,*appSize,*appType,*commentLabel;//,*goldSign;
@property (nonatomic,strong) UIButton *button,*goldSign;

@property (nonatomic,strong) EGOImageView *appIcon;

- (void)willMoveToSuperview:(UIView *)newSuperview;
- (void)setImageURL:(NSString *)imageURL;
- (void)setImageURL:(NSString *)imageURL strTemp:(NSString *)temp;


//设置详情头部样式
- (void)setDetailBaseView;

@end
