//
//  NT_RankingViewController.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_RankingViewController.h"
#import "NT_MainView.h"

@interface NT_RankingViewController ()
{
    BOOL _isLoading;
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _isRefreshing;
}

@end

@implementation NT_RankingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //一级控制器的左右滑动scrollView
    
    //self.navigationItem.title = @"排行榜";
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = @"排行榜";
    titleLable.textAlignment = TEXT_ALIGN_CENTER;
    [titleLable sizeToFit];
    self.navigationItem.titleView = titleLable;

    
    //设置底部兼容信息y值
    //[[NSUserDefaults standardUserDefaults] setFloat:SCREEN_HEIGHT-(64+49+21) forKey:KBottomInfo];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    //刷新头部
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - self.view.bounds.size.height, self.view.frame.size.width, self.view.frame.size.height)];
    _refreshHeaderView.delegate = self;
    _refreshHeaderView.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:_refreshHeaderView];
    [_refreshHeaderView refreshLastUpdatedDate];
     
    
    if (isIOS7)
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - (44+49))];
    }
    else
    {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (44+49))];
    }
    
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.autoresizesSubviews = NO;
    [self.view addSubview:_scrollView];
    //调整阴影层级，将导航栏阴影遮住tableview
    //[self.view exchangeSubviewAtIndex:3 withSubviewAtIndex:1];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height);
    
    [self getData];

}

- (void)getData
{
    
    _isLoading = YES;
    [_refreshHeaderView setState:EGOOPullRefreshLoading];
    self.scrollView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
    
    [self.scrollView removeAllSubViews];
    //[self.scrollView addSubview:_refreshHeaderView];
    
    
    //游戏排行
    NT_MainView *_mainTableView = [[NT_MainView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height-20) type:AppListTypeTopUp];
    _mainTableView.tag = 204;
    _mainTableView.bottomRedHeight = _mainTableView.height-20;
    _mainTableView.delegate = self;
    [self.scrollView addSubview:_mainTableView];
    
    //友盟统计-排行榜-展示量
    umengLogRecRankListShow++;
    
    [self perform:^{
        [self doneLoadingTableViewData];
    } afterDelay:0.1];
}

#pragma mark --
#pragma mark -- NTMainViewDlegate Delegate Methods
- (void)pushNextViewController:(UIViewController *)nextViewController
{
    [self.navigationController pushViewController:nextViewController animated:NO];
}

-(void)reloadTableViewDataSource
{
    _isRefreshing = YES;
    [self getData];
}

-(void)doneLoadingTableViewData
{
    _isRefreshing = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.scrollView];
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

- (void)resetLastUpdateDate
{
    [USERDEFAULT setObject:[NSDate date] forKey:[self currentLastDateKey]];
    [USERDEFAULT synchronize];
}
- (NSString *)currentLastDateKey
{
    NSString *userdefaultKey = [NSString stringWithFormat:@"CategoryAppView"];
    return userdefaultKey;
}
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _isLoading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    
    NSDate *date = [USERDEFAULT objectForKey:[self currentLastDateKey]];
    if (![date isKindOfClass:[NSDate class]]) {
        date = nil;
    }
    if (!date) {
        return [[NSDate date] dateafterMonth:1];
    }
	return [NSDate date];
}


- (void)clear
{
    self.scrollView = nil;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self clear];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (isIOS6)
    {
        if ([self isViewLoaded] && self.view.window == nil) {
            self.view = nil;
        }
    }
    [self clear];

}

@end
