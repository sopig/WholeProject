//
//  NT_SearchResultCountCell.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  搜索-搜索结果数

#import <UIKit/UIKit.h>
#import "NT_MacroDefine.h"

@interface NT_SearchResultCountCell : UITableViewCell

@property (nonatomic,strong) UILabel *countLabel;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *searchKeywordLabel;
@property (nonatomic,strong) UILabel *searchLabel;

@end
