//
//  NT_CategoryBaseCell.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-28.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NT_CategoryInfo.h"

//点击哪块分类
@protocol NT_CategoryCellDelegate <NSObject>

- (void)categoryCellSelectedIndex:(NSInteger)index;

@end

@interface NT_CategoryBaseCell : UITableViewCell 

@property (nonatomic,strong) UIButton *iconButton;
@property (nonatomic,strong) UILabel *categoryNameLabel;
@property (nonatomic,strong) UILabel *categoryTypeLabel;
@property (nonatomic,strong) UILabel *categoryCountLabel;
@property (nonatomic,strong) UIImageView *categoryImageView;
@property (nonatomic,weak) id delegate;

//分类信息
- (void)formatWithDataArray:(NSArray *)dataArray indexPath:(NSIndexPath *)indexPath selectedIndex:(int)index;

@end
