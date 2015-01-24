//
//  NT_BaseDownloadCell.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-9.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  下载-通用的下载信息

#import <UIKit/UIKit.h>

@interface NT_BaseDownloadCell : UITableViewCell

//@property (nonatomic,strong) UIImageView *iconView;
//by 张正超 使用图片缓存显示
@property (nonatomic,strong)EGOImageView *iconView;
@property (nonatomic,strong) UILabel *nameLabel;

@end
