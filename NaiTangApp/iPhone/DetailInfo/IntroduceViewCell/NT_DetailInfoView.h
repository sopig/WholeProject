//
//  NT_DetailInfoView.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-7.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <UIKit/UIKit.h> 
#import "NT_DetailOtherGamesView.h"
#import "NT_DetailIntroView.h"
#define KAllDetailHeight 800

@class NT_DetailImageView,NT_BaseAppDetailInfo,NT_DetailIntroView;
@class NT_DetailNewsView,NT_DetailOtherGamesView;

@protocol NT_DetailInfoViewDelegate,NT_DetailIntroViewDelegate;

@interface NT_DetailInfoView : UIView <NT_DetailOtherGamesViewDelegate,NT_DetailIntroViewDelegate>

@property (nonatomic,strong) NT_BaseAppDetailInfo *detailInfo;
@property (nonatomic,strong) UIScrollView *detailScrollView;
@property (nonatomic,strong) NT_DetailImageView *detailImageView;
@property (nonatomic,strong) NT_DetailInfoView *detailInfoView;
@property (nonatomic,strong) NT_DetailIntroView *introView;
@property (nonatomic,strong) NT_DetailNewsView *newsView;
@property (nonatomic,strong) NT_DetailOtherGamesView *otherGamesView;
@property (nonatomic,weak) id detailInfoViewDelegate;
@property (nonatomic,assign) CGFloat allHeight;

@property (nonatomic,strong) NSArray *otherGameArray,*newsInfoArray;

//加载游戏信息 是否展开
- (void)loadAllView:(CGFloat)height isExpansion:(BOOL)flag;
//图片展示-加载图片
- (void)loadDetailImage:(NT_BaseAppDetailInfo *)info;
//游戏信息
- (void)loadDetailInfo:(NT_BaseAppDetailInfo *)info isExpansion:(BOOL)flag;
//相关游戏展示
- (void)loadOtherGames:(NSArray *)otherGamesArray;
//资讯信息
- (void)loadNewsInfo:(NSArray *)newsArray;

// 计算第二个cell的高度
- (CGFloat)calcuHeightForSecondCell;

@end

//获取其他游戏详情信息
@protocol NT_DetailInfoViewDelegate <NSObject>

//其他游戏
- (void)getOtherGamesInfo:(NSInteger)appID isOtherGames:(BOOL)flag;
//展开游戏介绍信息
- (void)expansionDetailInfoViewDelegate:(CGFloat)height expansion:(BOOL)flag;

//计算资讯 大家还喜欢 是否有数据时显示高度
- (void)loadDefaultDetailHeight:(CGFloat)defaultHeight;
@end
