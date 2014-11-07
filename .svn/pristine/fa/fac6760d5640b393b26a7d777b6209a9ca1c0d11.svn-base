//
//  BaseTableView.m
//  CustomTableView
//
//  Created by 邹 on 13-12-17.
//  Copyright (c) 2013年 邹. All rights reserved.
//

#import "BaseTableView.h"
#import "NTAppDelegate.h"
#import "AppDelegate_Def.h"

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initViews];
    }
    
    return self;
}

-(void)awakeFromNib
{
    [self initViews];
}

-(void)initViews
{
    self.data = [NSMutableArray array];
    self.isMore = YES;
    
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.bounds.size.height, self.frame.size.width, self.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    
    self.dataSource = self;
    self.delegate = self;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = [UIColor colorWithRed:245/255.0 green:242/255.0 blue:237/255.0 alpha:1.0];
    
    [self addSubview:_refreshHeaderView];
    
    //更新 最后的更新时间
    [_refreshHeaderView refreshLastUpdatedDate];
    
    
    //加载更多
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:0.1];
    _moreButton.frame = CGRectMake(0, 0, 320, 40);
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [_moreButton setTitle:@"上拉或点击加载更多..." forState:UIControlStateNormal];
    [_moreButton setTitleColor:fontColor forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(loadMoreAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityView.frame = CGRectMake(100, 10, 20, 20);
    [activityView stopAnimating];
    activityView.tag = 2000;
    [_moreButton addSubview:activityView];
    self.tableFooterView = _moreButton;
}

//模拟一个下拉动作. 原理:让scrollview自动下拉超过属性的距离,state和剪头方向、文字变化有关

- (void)launchRefreshing
{
//    if (!_reloading) {
//        _reloading = NO;
    
        [UIView animateWithDuration:5 animations:^{
            [self setContentOffset:CGPointMake(0, -300)];
        } completion:^(BOOL finished) {
            if (finished) {
                //设置停止拖拽
                [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDidEndDragging:) withObject:self afterDelay:0.2];
            }
        }];
//    }else{
//        //下拉之前还原_refreshHeaderView的state
//        [_refreshHeaderView setState:EGOOPullRefreshNormal];
//        
//        [UIView animateWithDuration:0.4 animations:^{
//            [self setContentOffset:CGPointMake(0, -80)];
//        } completion:^(BOOL finished) {
//            if (finished) {
//                [_refreshHeaderView setState:EGOOPullRefreshPulling];
//                
//                //设置停止拖拽
//                [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDidEndDragging:) withObject:self afterDelay:0.2];
//            }
//        }];
//    }
}


- (NTAppDelegate *)appDelegate
{
    return (NTAppDelegate *)[UIApplication sharedApplication].delegate;
}

//要加载到window上
- (void)showHUD:(NSString *)title withHiddenDelay:(NSTimeInterval)delay
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithWindow:self.appDelegate.window];
    [self.appDelegate.window addSubview:hud];
    
    hud.mode = MBProgressHUDModeText;
    hud.labelText = title;
    
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(delay);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}
//上拉加载更多
- (void)loadMoreAction
{
    //如果没有更多,就返回
    if (!self.isMore) {
        [self showHUD:@"没有更多数据" withHiddenDelay:1];
        return;
    }
        //刷新正在加载的状态
        [self startLoadMore];
        
        self.requestType = Attention;
        if ([self.refreshDelegate respondsToSelector:@selector(pullUp:)]) {
        [self.refreshDelegate pullUp:self];
    }

}

-(void)startLoadMore
{
    [_moreButton setTitle:@"正在加载..." forState:UIControlStateNormal];
    _moreButton.enabled = NO;
    UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[_moreButton viewWithTag:2000];
    [activityView startAnimating];
}

- (void)stopLoadMore
{
//    NSLog(@"%d",[self.data count]);
    if (self.data.count > 0) {
        _moreButton.hidden = NO;
        _moreButton.enabled = YES;
        [_moreButton setTitle:@"上拉或点击加载更多..." forState:UIControlStateNormal];
        UIActivityIndicatorView *activityView = (UIActivityIndicatorView *)[_moreButton viewWithTag:2000];
        [activityView stopAnimating];
        
        //加载完成,如果没有更多的数据,则也隐藏
//        if (!self.isMore) {
//            _moreButton.hidden = YES;
//        }
    }else{
        _moreButton.hidden = YES;
    }
}

////重写父类方法
- (void)reloadData
{
    [super reloadData];
    
    //停止加载更多
    [self stopLoadMore];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"kBaseCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	// Configure the cell.
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
	_reloading = YES;
	
}

- (void)doneLoadingTableViewData{
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    
    
    //上拉加载更多
    //实现原理: scrollView.contentSize.height - scrollView.contentOffset.y = scrollView.height
    float sub = scrollView.contentSize.height - scrollView.contentOffset.y;
    if (scrollView.contentSize.height < scrollView.bounds.size.height) {
        if (scrollView.contentOffset.y > 30) {
            [self loadMoreAction];
        }
    } else
    {
        if (scrollView.bounds.size.height - sub > 30) {
            [self loadMoreAction];
        }
    }

    
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
//已经触发了下拉刷新的动作
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
    
    self.requestType = Fans;
    //请求网络
    if ([self.refreshDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.refreshDelegate pullDown:self];
    }

    //停止加载，模拟弹回下拉
    //	[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

//取得下拉刷新的时间
- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


@end
