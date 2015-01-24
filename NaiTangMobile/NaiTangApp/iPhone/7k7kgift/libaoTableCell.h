//
//  libaoTableCell.h
//  libao
//
//  Created by wangxing on 14-2-27.
//  Copyright (c) 2014年 wangxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface libaoTableCell : UITableViewCell

@property (nonatomic,strong) EGOImageView * gameIcon;
@property (nonatomic,strong) UILabel * gameName;

// xxx礼包
@property (nonatomic,strong) UILabel * libaoDescription;

// 库存：
@property (nonatomic,strong) UILabel * libaoInfo;

// 剩余数量
@property (nonatomic,strong) UILabel * libaoNumRest;

// 总数
@property (nonatomic,strong) UILabel * libaoNumTotal;


@property (nonatomic,strong) UIButton * libaoActionButton;
@property (nonatomic,strong) UIImageView * libaoIcon;


- (void)willMoveToSuperview:(UIView *)newSuperview;
- (void)setImageURL:(NSString *)imageURL;

//无网络请求调用
- (void)setImageURL:(NSString *)imageURL strTemp:(NSString *)temp;

// 用数据渲染cell
- (void)renderCellWithData:(NSDictionary *) data andType:(NSString *)type;

@end
