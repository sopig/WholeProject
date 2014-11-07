//
//  NT_DetailImageView.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-7.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  详情-图片展示

#import <UIKit/UIKit.h>

#define KImageCellHeight 340

@class NT_CustomPageControl,NT_BaseAppDetailInfo;

@interface NT_DetailImageView : UIView <UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NT_CustomPageControl *pageControl;

//加载图片信息
- (void)refreshWithAppInfo:(NT_BaseAppDetailInfo *)info;

@end
