//
//  NT_CategoryViewController.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_CategoryViewController.h"
#import "NT_HttpEngine.h"
#import "NT_CategoryDetailViewController.h"
#import "NT_CategoryInfo.h"
#import "UIImageView+WebCache.h"
#import "NT_CategoryBaseView.h"
#import "DataService.h"
#import "NT_CategoryBaseCell.h"
#import "NT_LoadMoreCell.h"

@interface NT_CategoryViewController ()

@end

@implementation NT_CategoryViewController

@synthesize switchTableView;

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
    //self.navigationItem.title = @"奶糖游戏";
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = @"奶糖游戏";
    titleLable.textAlignment = TEXT_ALIGN_CENTER;
    [titleLable sizeToFit];
    self.navigationItem.titleView = titleLable;

    self.categoryArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    
    
    if (isIOS7)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-(20+58)) style:UITableViewStylePlain];
    }
    else
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-(20+58)) style:UITableViewStylePlain];
    }
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithHex:@"#efefef"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    
    _refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - _tableView.bounds.size.height, _tableView.frame.size.width, _tableView.frame.size.height)];
    _refreshHeaderView.delegate = self;
    _refreshHeaderView.backgroundColor = [UIColor clearColor];
    [self.tableView addSubview:_refreshHeaderView];
    [_refreshHeaderView refreshLastUpdatedDate];

    [self getData];
    
    //判断是否有网络，进入前台时刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshdataWithEntryForegroud) name:kApplicationWillEnterForeground object:nil];
}

//判断是否有网络，进入前台时刷新数据
- (void)refreshdataWithEntryForegroud
{
    //初始化详情视图
    [self getData];
}


- (void)getData
{
    //首次加载时，无网络的话，显示测试数据，其他时候无网络，是有缓存的数据显示的，无需其他操作
    NSString *netConnection = [[NT_HttpEngine sharedNT_HttpEngine] getCurrentNet];
    BOOL isFirstLoad = [[NSUserDefaults standardUserDefaults] boolForKey:KCategoryIsFirstLoad];
    //首次加载时，无网络的话，显示测试数据，
    if (!isFirstLoad && [netConnection isEqualToString:NETNOTWORKING])
    {
        [_refreshHeaderView setState:EGOOPullRefreshLoading];
        self.tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        _isLoading = NO;
        [self stopLoadingMore];
        self.tableView.contentOffset = CGPointZero;
        
        NSDictionary *dic1 = [NSDictionary dictionaryWithObjectsAndKeys:@"跑酷",@"title",@"天天酷跑等",@"subtitle",@"2355款",@"gameCount", nil];
        NSDictionary *dic2 = [NSDictionary dictionaryWithObjectsAndKeys:@"益智",@"title",@"史上最坑爹",@"subtitle",@"2354款",@"gameCount", nil];
        NSDictionary *dic3 = [NSDictionary dictionaryWithObjectsAndKeys:@"休闲",@"title",@"切瓜",@"subtitle",@"2243款",@"gameCount", nil];
        NSDictionary *dic4 = [NSDictionary dictionaryWithObjectsAndKeys:@"射击",@"title",@"射击等",@"subtitle",@"1455款",@"gameCount", nil];
        NSDictionary *dic5 = [NSDictionary dictionaryWithObjectsAndKeys:@"竞速",@"title",@"酷跑等",@"subtitle",@"657款",@"gameCount", nil];
        NSDictionary *dic6 = [NSDictionary dictionaryWithObjectsAndKeys:@"动作",@"title",@"杀敌等",@"subtitle",@"4365款",@"gameCount", nil];
        
        NSMutableArray *arr = [NSMutableArray arrayWithObjects:dic1,dic2,dic3,dic4,dic5,dic6, nil];
        
        
        for (int i = 0 ;i<[arr count];i++)
        {
            //分类信息值Model类
            NSDictionary *dic = [arr objectAtIndex:i];
            NT_CategoryInfo *categoryInfo = [[NT_CategoryInfo alloc] init];
            categoryInfo = [categoryInfo categoryInfoFrom:dic];
            [self.categoryArray addObject:categoryInfo];
        }
        
        
        [self.tableView reloadData];
        [self doneLoadingTableViewData];
        
        //第二次加载
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KCategoryIsFirstLoad];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        // 友盟统计-分类（找游戏）-展示量
        umengLogFindGameShow++;
        
        [_refreshHeaderView setState:EGOOPullRefreshLoading];
        self.tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);
        
        NSString *url = @"http://apitest.naitang.com/";
        
        NSString *urlString = @"mobile/v1/k7mobile/websetting/452_1_100.html";
        urlString = [NSString stringWithFormat:@"%@%@",url,urlString];
        NSLog(@"%@",urlString);
        
        _isLoading = YES;
        
        /*
         //显示加载中
         [self.view showLoadingMeg:@"加载中.."];
         [self.view setLoadingUserInterfaceEnable:YES];
         UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenLoading:)];
         [self.view addGestureRecognizer:tapGesture];
         */
        
        [DataService requestWithURL:urlString finishBlock:^(id result) {
            
            _isLoading = NO;
            [self stopLoadingMore];
            self.tableView.contentOffset = CGPointZero;
            if ([[result objectForKey:@"status"] boolValue])
            {
                [self.categoryArray removeAllObjects];
                NSArray *arr = [result objectForKey:@"data"];
                for (int i = 0 ;i<[arr count];i++)
                {
                    //分类信息值Model类
                    NSDictionary *dic = [arr objectAtIndex:i];
                    NT_CategoryInfo *categoryInfo = [[NT_CategoryInfo alloc] init];
                    categoryInfo = [categoryInfo categoryInfoFrom:dic];
                    [self.categoryArray addObject:categoryInfo];
                }
            }
            
            [self.tableView reloadData];
            [self doneLoadingTableViewData];
        } errorBlock:^(id result) {
            [self stopLoadingMore];
            _isLoading = NO;
            self.tableView.contentOffset = CGPointZero;
            [self doneLoadingTableViewData];
            [self.view showLoadingMeg:@"网络异常" time:1];
        }];

    }
}

//一行显示两个分类
- (int)rowNum
{
    return ([self.categoryArray count] +1) / 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.categoryArray count]>0)
    {
        return [self rowNum]+1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self rowNum])
    {
        static NSString *moreID = @"moreID";
        NT_LoadMoreCell *moreCell = [tableView dequeueReusableCellWithIdentifier:moreID];
        if (moreCell == nil)
        {
            moreCell = [[NT_LoadMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:moreID];
            moreCell.selectionStyle = UITableViewCellSelectionStyleNone;
            if (isIOS7)
            {
                moreCell.backgroundView = [[UIView alloc] init];
                moreCell.backgroundView.backgroundColor = [UIColor colorWithHex:@"#efefef"];
            }
            
        }
        [moreCell endLoading];
        moreCell.label.text = @"已经加载全部";
        return moreCell;
    }
    else
    {
        static NSString *categoryID = @"categroyID";
        NT_CategoryBaseCell *baseCell = [tableView dequeueReusableCellWithIdentifier:categoryID];
        if (baseCell == nil)
        {
            baseCell = [[NT_CategoryBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:categoryID];
            baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
            baseCell.delegate = self;
            if (isIOS7) {
                baseCell.backgroundView = [[UIView alloc] init];
                baseCell.backgroundView.backgroundColor = [UIColor colorWithHex:@"#efefef"];
            }
        }
        [baseCell formatWithDataArray:self.categoryArray indexPath:indexPath selectedIndex:0];
        return baseCell;

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [self rowNum]) {
        return 40;
    }
    return 75;
}


//取消加载中显示
- (void)hiddenLoading:(UITapGestureRecognizer *)tap
{
    if (tap) {
        [self.view removeGestureRecognizer:tap];
    }
    [self.view hideLoading];
}


- (void)loadContent
{
    [self.scrollView removeAllSubViews];
    [self.scrollView addSubview:_refreshHeaderView];
    
    [self.categoryArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if ([[self.categoryArray objectAtIndex:idx] count])
        {
            //分类信息值Model类
            NSDictionary *dic = [self.categoryArray objectAtIndex:idx];
            NT_CategoryInfo *categoryInfo = [[NT_CategoryInfo alloc] init];
            categoryInfo = [categoryInfo categoryInfoFrom:dic];
            
            int row = idx/2;
            int colum = idx % 2;
            //float width = (self.view.width - 15)/2;
            float width = 152;
            
            NT_CategoryBaseView *categoryBaseView = [[NT_CategoryBaseView alloc] initWithFrame:CGRectMake(5 + (width + 5) * colum,10 + (70 + 5) * row, width, 70) ];
            [categoryBaseView refreshCategoryData:categoryInfo];
            categoryBaseView.iconButton.tag = idx;
            [categoryBaseView.iconButton addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:categoryBaseView];
        }
        
    }];
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width, 10 + (self.categoryArray.count + 1)/2 * 80>self.scrollView.height?(self.categoryArray.count + 1)/2 * 80:self.scrollView.height);

}

- (void)categoryCellSelectedIndex:(NSInteger)index
{
    if (index < 0)
    {
        index = 0;
    }
    NT_CategoryInfo *categoryInfo = self.categoryArray[index];
    
    NT_CategoryDetailViewController *detailController = [[NT_CategoryDetailViewController alloc] init];
    detailController.linkID = [categoryInfo.linkId integerValue];
    detailController.linkType = categoryInfo.linkType;
    detailController.categoryName = categoryInfo.title;
    detailController.isOnlineGame = NO;
    detailController.sortType = SortTypeHotest;
    [self.navigationController pushViewController:detailController animated:NO];

}

- (void)btnPressed:(UIButton *)btn
{
    NSDictionary *dic = self.categoryArray[btn.tag];
    NT_CategoryInfo *categoryInfo = [[NT_CategoryInfo alloc] init];
    categoryInfo = [categoryInfo categoryInfoFrom:dic];
    
    NT_CategoryDetailViewController *detailController = [[NT_CategoryDetailViewController alloc] init];
    detailController.linkID = [categoryInfo.linkId integerValue];
    detailController.linkType = categoryInfo.linkType;
    detailController.categoryName = categoryInfo.title;
    detailController.isOnlineGame = NO;
    detailController.sortType = SortTypeHotest;
    /*
    detailController.categoryID = [dic[@"id"] intValue];
    detailController.titleLabel.text = dic[@"name"];
    detailController.categoryName = dic[@"name"];
    detailController.isOnlineGame = NO;
    detailController.sortType =SortTypeHotest;
    detailController.linkID = [dic[@"linkId"] integerValue];
    detailController.linkType = [dic[@"linkType"]integerValue];
    */
    [self.navigationController pushViewController:detailController animated:NO];
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

- (void)stopLoadingMore
{
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:[self.categoryArray count]];
    NT_LoadMoreCell *cell = (NT_LoadMoreCell *)[self.tableView cellForRowAtIndexPath:lastIndexPath];
    [cell endLoading];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kApplicationWillEnterForeground object:nil];
}

- (void)dealloc
{
    [self clear];
}

- (void)clear
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kApplicationWillEnterForeground object:nil];
    self.scrollView = nil;
    self.categoryArray = nil;
    self.switchTableView = nil;
    self.tableView = nil;
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
