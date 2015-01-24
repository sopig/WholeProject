//
//  NT_VideoView.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  游戏详情-视频

#import <UIKit/UIKit.h>

@interface NT_VideoView : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *videoTableView;

@property (nonatomic,strong) NSMutableArray *VideoViewArr;

// icon
@property (nonatomic,strong) NSString * urlImg;
// title
@property (nonatomic,strong) NSString * gameName;

@end
