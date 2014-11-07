//
//  NT_CustomPageControl.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  自定义分页

#import <UIKit/UIKit.h>

@interface NT_CustomPageControl : UIPageControl

@property (nonatomic,strong)UIImage *selectedImg,*unSelectedImg;
@property (nonatomic,assign)BOOL isCreated;

@end
