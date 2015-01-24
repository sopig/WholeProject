//
//  NT_VideoCell.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface NT_VideoCell : UITableViewCell

@property (nonatomic,strong) EGOImageView *videoImageView;
@property (nonatomic,strong) UILabel *videoTitleLabel;
@property (nonatomic,strong) UILabel *descriptionLabel;
@property (nonatomic,strong) UILabel *dateLabel;
@property (assign) BOOL isTemp;

- (void)willMoveToSuperview:(UIView *)newSuperview;
- (void)setImageURL:(NSString *)imageURL;
- (void)setImageURL:(NSString *)imageURL strTemp:(NSString *)temp;

@end