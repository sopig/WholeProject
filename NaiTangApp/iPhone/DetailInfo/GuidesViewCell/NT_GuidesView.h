//
//  NT_GuidesView.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  游戏攻略

#import <UIKit/UIKit.h>

@interface NT_GuidesView : UIView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *guidesArray;
@property (nonatomic,strong) UITableView *guidesTableView;

@property (nonatomic,strong) NSString * strType;
@property (nonatomic,strong) NSString * gameName;
@property (assign) BOOL isTemp;

@end
