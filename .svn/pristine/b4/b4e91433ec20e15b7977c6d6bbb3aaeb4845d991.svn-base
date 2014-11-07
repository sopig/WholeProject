//
//  DataCell.h
//  libao
//
//  Created by 小远子 on 14-3-5.
//  Copyright (c) 2014年 wangxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"


@interface DataCell : UITableViewCell

/**
 标题
 */
@property (nonatomic , strong) UILabel * titleText;
/**
 图片icon
 */
@property (nonatomic , strong) EGOImageView * imgView;
/**
 简介内容
 */
@property (nonatomic , strong) UILabel * briefLabel;
@property (assign) BOOL isTemp;

- (void)willMoveToSuperview:(UIView *)newSuperview;
- (void)setImageURL:(NSString *)imageURL;
- (void)setImageURL:(NSString *)imageURL strTemp:(NSString *)temp;


@end
