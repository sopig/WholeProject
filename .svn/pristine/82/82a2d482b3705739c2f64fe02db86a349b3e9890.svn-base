//
//  liBaoViewController.h
//  libao
//
//  Created by wangxing on 14-2-26.
//  Copyright (c) 2014年 wangxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"


@interface liBaoViewController : UIViewController<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,BaseTableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *buttonNav;
@property (strong, nonatomic) IBOutlet UIView *scrollerWrap;
@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) IBOutlet UIButton *listLibaoButton;
@property (strong, nonatomic) IBOutlet UIButton *myLibaoButton;
@property (strong, nonatomic) IBOutlet UIView *slideLineView;   // 蓝色的线
@property (strong, nonatomic) IBOutlet UIView *listLibaoTableViewWrap;
@property (strong, nonatomic) IBOutlet BaseTableView *listLibaoTableView;
@property (strong, nonatomic) IBOutlet UIView *myLibaoTableViewWrap;
@property (strong, nonatomic) IBOutlet UITableView *myLibaoTableView;
// 在libao list加载数据时显示的loading
//@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityForList;
// 没有领取过礼包时，展示“我的礼包”的提示内容
@property (strong, nonatomic) IBOutlet UILabel *labelPlaceHoldForMy;


- (IBAction)navButtonPressed:(UIButton *)sender;

@end
