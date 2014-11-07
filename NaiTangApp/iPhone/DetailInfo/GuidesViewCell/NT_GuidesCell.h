//
//  NT_GuidesCell.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  游戏攻略

#import <UIKit/UIKit.h>
#import "EGOImageView.h"


@interface NT_GuidesCell : UITableViewCell

@property (nonatomic,strong) EGOImageView *guidesImageView;
@property (nonatomic,strong) UILabel *guidesTitleLabel,*countLabel,*timeData;

@property (assign) BOOL isTemp;

- (void)refreshGuidesInfo:(NSDictionary *)dic;


- (void)willMoveToSuperview:(UIView *)newSuperview;
- (void)setImageURL:(NSString *)imageURL;
- (void)setImageURL:(NSString *)imageURL strTemp:(NSString *)temp;

@end