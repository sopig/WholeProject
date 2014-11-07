//
//  NT_CategoryBaseView.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-13.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  分类

#import <UIKit/UIKit.h>
#import "NT_CategoryInfo.h"

@interface NT_CategoryBaseView : UIView

@property (nonatomic,strong) UIButton *iconButton;
@property (nonatomic,strong) UILabel *categoryNameLabel;
@property (nonatomic,strong) UILabel *categoryTypeLabel;
@property (nonatomic,strong) UILabel *categoryCountLabel;
//@property (nonatomic,strong) UIImageView *categoryImageView;
@property (nonatomic,strong) EGOImageView *categoryImageView;

//分类信息
- (void)refreshCategoryData:(NT_CategoryInfo *)categoryInfo;

@end
