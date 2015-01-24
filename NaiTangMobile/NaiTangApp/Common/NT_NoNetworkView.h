//
//  NT_NoNetworkView.h
//  NaiTangApp
//
//  Created by 张正超 on 14-4-10.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  网络无连接时显示图片

#import <UIKit/UIKit.h>

@interface NT_NoNetworkView : UIView

@property (strong,nonatomic) UIButton *networkButton;

//网络无连接时加载图片
- (void)loadNoNetworkView;

@end
