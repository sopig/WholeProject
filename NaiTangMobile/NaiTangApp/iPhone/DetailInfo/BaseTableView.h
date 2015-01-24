//
//  BaseTableView.h
//  CustomTableView
//
//  Created by 邹 on 13-12-17.
//  Copyright (c) 2013年 邹. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "MBProgressHUD.h"
@class BaseTableView;

@protocol BaseTableViewDelegate <NSObject>

@optional
//下拉事件
- (void)pullDown:(BaseTableView *)tableView;
//上拉事件
- (void)pullUp:(BaseTableView *)tableView;


@end


typedef NS_ENUM(NSInteger, RequestType)
{
    Attention = 100,
    Fans
};


@interface BaseTableView : UITableView<EGORefreshTableHeaderDelegate, UITableViewDataSource, UITableViewDelegate>
{
    
	
	BOOL _reloading;        //正在加载的提示
}
@property(nonatomic, strong) EGORefreshTableHeaderView * refreshHeaderView;
@property(nonatomic, retain)NSMutableArray *data;   //数据源

@property(assign)RequestType requestType;

@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, strong) NSString *titleText;


//判断是否有更多的数据
@property(assign)BOOL isMore;

//停止加载, 弹回下拉
- (void)doneLoadingTableViewData;


//上拉代理对象
@property(nonatomic, weak)id<BaseTableViewDelegate> refreshDelegate;

//自动执行下拉动作
-(void)launchRefreshing;

- (void)stopLoadMore;
- (void)startLoadMore;


//- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
//- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
- (void)loadMoreAction;
@end
