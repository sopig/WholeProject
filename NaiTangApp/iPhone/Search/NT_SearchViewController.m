//
//  NT_SearchViewController.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_SearchViewController.h"
#import "NT_MainCell.h"
#import "NT_MainSecondCell.h"
#import "NT_LoadMoreCell.h"
#import "NT_HotKeyCell.h"
#import "NT_SearchHistoryCell.h"
#import "NT_SearchResultCountCell.h"
#import "UIView_MBProgressHUD.h"
#import "NT_DownloadManager.h"
#import "NT_DownloadModel.h"
#import "NT_OnlineGameDialog.h"
#import "UIImageView+WebCache.h"
#import "NT_SearchResultInfo.h"
#import "NT_BaseAppDetailInfo.h"
#import "NT_AppDetailInfo.h"
#import "NT_HttpEngine.h"
#import "NT_AppDetailViewController.h"
#import "NT_BaseView.h"
#import "NT_SearchNoDataCell.h"
#import "NT_UpdateAppInfo.h"
#import "DataService.h"
#import "Utile.h"
#import "NT_SettingManager.h"
#import "NT_WifiBrowseImage.h"

@interface NT_SearchViewController ()
{
    int _currentPage,_totalPages;
    BOOL _isLoading;
    UIImageView *_searchBarBgView;
}
@property (nonatomic,strong)NSMutableArray *hotKeysArray,*searchNoticeArray,*gameListsArray;
@property (nonatomic,strong)NT_SearchResultInfo *searchModel;
@property (nonatomic,strong)NT_BaseAppDetailInfo *appDetailInfo;
@property (nonatomic,strong)NT_AppDetailInfo *appInfoDetail;
@property (nonatomic,strong)UIImageView *headback;
@property (nonatomic,assign) int selectedIndex;
@property (nonatomic,copy) NSString *searchKeywordNoData;
@property (nonatomic,strong) NT_DownloadModel *downloadModel;

@end

@implementation NT_SearchViewController

@synthesize hotKeysArray = _hotKeysArray;
@synthesize searchNoticeArray = _searchNoticeArray;
@synthesize gameListsArray = _gameListsArray;
@synthesize searchBar = _searchBar;
@synthesize searchModel = _searchModel;
@synthesize appDetailInfo = _appDetailInfo;
@synthesize headback = _headback;
@synthesize selectedIndex = _selectedIndex;
@synthesize searchKeywordNoData = _searchKeywordNoData;
@synthesize downloadModel = _downloadModel;
@synthesize hotKeysTableView = _hotKeysTableView;
@synthesize searchResultTableView = _searchResultTableView;
@synthesize searchHistoryTableView = _searchHistoryTableView;
@synthesize searchNoticeTableView = _searchNoticeTableView;
@synthesize searchNoDataTableView = _searchNoDataTableView;
@synthesize whiteBgView = _whiteBgView;
@synthesize searchValue = _searchValue;
@synthesize searchHistroyArray = _searchHistroyArray;
@synthesize searchTotalCount = _searchTotalCount;
@synthesize isOnlineGame = _isOnlineGame;

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
    
    //self.navigationItem.title = @"搜索";
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = @"搜索";
    titleLable.textAlignment = TEXT_ALIGN_CENTER;
    [titleLable sizeToFit];
    self.navigationItem.titleView = titleLable;
    
    
    //[[NSUserDefaults standardUserDefaults] setFloat:SCREEN_HEIGHT-(64+44+24) forKey:KBottomInfo];
    //[[NSUserDefaults standardUserDefaults] synchronize];
    
    self.searchHistroyArray = [NSMutableArray array];
    self.gameListsArray = [NSMutableArray array];
    //若reloadData无响应，查看是否[NSMutableArray array] 或者是否添加UITableViewDataSource,UITableViewDelegate, 委托
    self.searchNoticeArray = [NSMutableArray array];
    self.selectedIndex = -1;
    
    
    
    UIView *headBack = nil;
    //白色背景
    if (isIOS7)
    {
        headBack = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.width, 44)];
    }
    else
    {
        headBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    }
    headBack.backgroundColor = [UIColor whiteColor];
    headBack.userInteractionEnabled = YES;
    [self.view addSubview:headBack];
    self.whiteBgView = headBack;
    
    //搜索栏
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(5,headBack.top+7, headBack.width-10, headBack.height-10)];
    searchBar.delegate = self;
    //searchBar.barStyle = UIBarStyleBlack;
    
    //设置搜索框的 文本颜色值 占位符色值
    UITextField *searchField = [searchBar valueForKey:@"_searchField"];
    searchField.textColor = Text_Color;
    searchField.font = [UIFont systemFontOfSize:15];
    [searchField setValue:Text_Color forKeyPath:@"_placeholderLabel.textColor"];
    if (isIOS7)
    {
#ifdef __IPHONE_7_0
        searchBar.placeholder = @"输入游戏名称                        ";
        //ios7.1去掉边框颜色值
        searchBar.barTintColor = [UIColor whiteColor];
        
        UIImageView *searchBgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, headBack.width-20, headBack.height-10)];
        //searchBgView.image = LOADBUNDLEIMAGE(@"search_bk", @"png");
        [headBack addSubview:searchBgView];
        _searchBarBgView = searchBgView;
        
        [searchBar setSearchFieldBackgroundImage:[[UIImage imageNamed:@"search_bk.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:15] forState:UIControlStateNormal];
        searchBar.clipsToBounds = YES;
        //searchBar.layer.cornerRadius = searchBar.height/2;
#endif
    }else
    {
        searchBar.placeholder = @"输入游戏名称";
        UIView *segment = [[searchBar subviews] objectAtIndex:0];
        [segment removeFromSuperview];
        for (UIView *view in searchBar.subviews) {
            if ([view isKindOfClass:[UITextField class]]) {
                UITextField *tf = (UITextField *)view;
                tf.background = [UIImage imageNamed:@"search_bk.png"];
            }
        }
    }
    [self.view addSubview:searchBar];
    self.searchBar = searchBar;
    
    //搜索历史记录
    _searchHistoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headBack.bottom+3, self.view.width, self.view.height-headBack.bottom-5) style:UITableViewStylePlain];
    _searchHistoryTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _searchHistoryTableView.backgroundColor = [UIColor colorWithHex:@"#efefef"];
    _searchHistoryTableView.delegate = self;
    _searchHistoryTableView.dataSource = self;
    _searchHistoryTableView.hidden = YES;
    //iOS7的cell分割线是由默认的15pt的偏移的，所以设置偏移量为0
    if ([_searchHistoryTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_searchHistoryTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    [self.view addSubview:_searchHistoryTableView];
    
    //去除多余的cell
    [Utile setExtraCellLineHidden:_searchHistoryTableView];
    
    
    /**
     历史记录底部添加清除按钮
     */
    
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44.0)];
    [_searchHistoryTableView setTableFooterView:footerView];
    
    UILabel * l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    l.backgroundColor = [UIColor colorWithRed:196/225.0 green:196/225.0 blue:196/225.0 alpha:1.0];
    [footerView addSubview:l];
    
    UIButton* btnNextPage = [[UIButton alloc] initWithFrame:footerView.frame];
    [btnNextPage setTitle:@"清除搜索记录" forState:UIControlStateNormal];
    [btnNextPage setTitleColor:[UIColor colorWithRed:30/225.0 green:181/225.0 blue:247/225.0 alpha:1.0] forState:UIControlStateNormal];
    [btnNextPage addTarget:self action:@selector(btnNextPageAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:btnNextPage];
    
    //搜索提示，搜索时的关联词
    _searchNoticeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headBack.bottom+3, self.view.width,self.view.height-headBack.bottom-5) style:UITableViewStylePlain];
    //_searchNoticeTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _searchNoticeTableView.backgroundColor = [UIColor colorWithHex:@"#efefef"];
    _searchNoticeTableView.delegate = self;
    _searchNoticeTableView.dataSource = self;
    _searchNoticeTableView.hidden = YES;
    //iOS7的cell分割线是由默认的15pt的偏移的，所以设置偏移量为0
    if ([_searchNoticeTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_searchNoticeTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    [self.view addSubview:_searchNoticeTableView];
    
    //去除多余的cell
    [Utile setExtraCellLineHidden:_searchNoticeTableView];
    
    //搜索结果
    //_searchResultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headBack.bottom+3, self.view.width, self.view.height-headBack.bottom-5) style:UITableViewStylePlain];
    _searchResultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headBack.bottom+3, self.view.width, SCREEN_HEIGHT - (64+49+6)) style:UITableViewStylePlain];
    _searchResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _searchResultTableView.delegate = self;
    _searchResultTableView.dataSource = self;
    _searchResultTableView.hidden = YES;
    [self.view addSubview:_searchResultTableView];
    
    //去除多余的cell
    [Utile setExtraCellLineHidden:_searchResultTableView];
    
    //热词
    _hotKeysTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headBack.bottom+3, self.view.width, self.view.height-headBack.bottom-5) style:UITableViewStylePlain];
    _hotKeysTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _hotKeysTableView.delegate = self;
    _hotKeysTableView.dataSource = self;
    _hotKeysTableView.backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _hotKeysTableView.backgroundColor = [UIColor colorWithHex:@"#efefef"];
    [self.view addSubview:_hotKeysTableView];
    
    //去除多余的cell
    [Utile setExtraCellLineHidden:_hotKeysTableView];
    
    //搜索无结果
    _searchNoDataTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, headBack.bottom+3, self.view.width, self.view.height-headBack.bottom-5) style:UITableViewStylePlain];
    //_searchNoDataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _searchNoDataTableView.delegate = self;
    _searchNoDataTableView.dataSource = self;
    _searchNoDataTableView.backgroundView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _searchNoDataTableView.backgroundColor = [UIColor colorWithHex:@"#efefef"];
    _searchNoDataTableView.hidden = YES;
    [self.view addSubview:_searchNoDataTableView];
    //去除多余的cell
    [Utile setExtraCellLineHidden:_searchNoDataTableView];
    
    [self getData];
    
    //判断是否有网络，进入前台时刷新数据
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshdataWithEntryForegroud) name:kApplicationWillEnterForeground object:nil];
    
}

//判断是否有网络，进入前台时刷新数据
- (void)refreshdataWithEntryForegroud
{
    [self getData];
}

#pragma mark --
#pragma mark -- Keyboard Event Methods

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //归档搜索历史记录
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"SearchHistoryArray"] != nil) {
        self.searchHistroyArray = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"SearchHistoryArray"]]];
    }else
    {
        self.searchHistroyArray = [[NSMutableArray alloc] init];
    }
    
    //键盘弹出框
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    //收起无限金币的弹框
    if (self.selectedIndex > -1) {
        int tmp = self.selectedIndex;
        self.selectedIndex = -1;
        //reloadSections必须使用beginUpdates和endUpdates方法
        [self.searchResultTableView beginUpdates];
        [self.searchResultTableView reloadSections:[NSIndexSet indexSetWithIndex:tmp] withRowAnimation:UITableViewRowAnimationNone];
        [self.searchResultTableView endUpdates];
        
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kApplicationWillEnterForeground object:nil];
    
}

- (void)keyboardWillShown:(NSNotification *)aNotification
{
    NSDictionary *info = [aNotification userInfo];
    CGSize size = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    //调整高度
    if (isIOS7)
    {
        self.searchHistoryTableView.height = self.view.height-(size.height+110);
        self.searchNoticeTableView.height = self.view.height-(size.height+110);
        
    }
    else
    {
        self.searchHistoryTableView.height = self.view.height-(size.height)+2;
        self.searchNoticeTableView.height = self.view.height-(size.height)+2;
    }
}

- (void)keyboardWillHidden:(NSNotification *)aNotification
{
    self.searchHistoryTableView.hidden = YES;
    self.searchNoticeTableView.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
        self.hotKeysArray = [NSMutableArray arrayWithObjects:@"爸爸去哪儿",@"天天酷跑",@"植物大战僵尸",@"神庙逃亡",@"冒险王",@"炉石传说：魔兽英雄传",@"纸境",@"未上锁的房间2",@"模拟射击2",@"黑暗之光",@"企鹅大冒险",@"迷你都市",@"仙境传说：女武神起义", nil];
        [self.hotKeysTableView reloadData];
        
        //第二次加载
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KSearchIsFirstLoad];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        // 友盟统计-搜索-展示量
        umengLogSearchShow++;
        
        [self.view showLoadingMeg:@"加载中..."];
        [self.view setLoadingUserInterfaceEnable:YES];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenLoading:)];
        [self.view addGestureRecognizer:tapGesture];
        
        //获取关键词信息
        NSString *url = @"http://apitest.naitang.com/";
        NSString *urlString = @"mobile/v1/k7mobile/websetting/52_1_1.html";
        urlString = [NSString stringWithFormat:@"%@%@",url,urlString];
        
        NSLog(@"hot key:%@",urlString);
        [DataService requestWithURL:urlString finishBlock:^(id result) {
            if (tapGesture) {
                [self.view removeGestureRecognizer:tapGesture];
            }
            [self.view hideLoading];
            NSDictionary *dic = (NSDictionary *)result;
            if ([dic[@"status"] boolValue])
            {
                if ([dic[@"data"] count] > 0)
                {
                    [self.hotKeysArray removeAllObjects];
                    //搜索有数据
                    self.appDetailInfo = [NT_BaseAppDetailInfo appDetailInfoInSearchFrom:dic[@"data"]];
                    
                    //获取关键词信息
                    NSMutableArray *keywordArray = dic[@"data"][@"hot"];
                    self.hotKeysArray = keywordArray;
                    [self.hotKeysTableView reloadData];
                    
                }
            }
            else
            {
                [self showError];
            }
        } errorBlock:^(id result) {
            if (tapGesture) {
                [self.view removeGestureRecognizer:tapGesture];
            }
            [self.view hideLoading];
            [self showError];
        }];
        /*
         [DataService requestWithURL:urlString finishBlock:^(id result) {
         if (tapGesture) {
         [self.view removeGestureRecognizer:tapGesture];
         }
         [self.view hideLoading];
         NSDictionary *dic = (NSDictionary *)result;
         if ([dic[@"status"] boolValue])
         {
         if ([dic[@"data"] count] > 0)
         {
         [self.hotKeysArray removeAllObjects];
         //搜索有数据
         self.appDetailInfo = [NT_BaseAppDetailInfo appDetailInfoInSearchFrom:dic[@"data"]];
         
         //获取关键词信息
         NSMutableArray *keywordArray = dic[@"data"][@"hot"];
         self.hotKeysArray = keywordArray;
         [self.hotKeysTableView reloadData];
         
         }
         }
         else
         {
         if (tapGesture) {
         [self.view removeGestureRecognizer:tapGesture];
         }
         [self showError];
         }
         
         }];
         */
    }
    /*
     [[NT_HttpEngine sharedNT_HttpEngine] getSearchDataCompletionHandler:^(MKNetworkOperation *completedOperation) {
     if (tapGesture) {
     [self.view removeGestureRecognizer:tapGesture];
     }
     [self.view hideLoading];
     NSDictionary *dic = [completedOperation responseJSON];
     if ([dic[@"status"] boolValue])
     {
     //搜索有数据
     self.appDetailInfo = [NT_BaseAppDetailInfo appDetailInfoInSearchFrom:dic[@"data"]];
     
     //获取关键词信息
     NSMutableArray *keywordArray = dic[@"data"][@"hot"];
     self.hotKeysArray = keywordArray;
     [self.hotKeysTableView reloadData];
     }
     else
     {
     if (tapGesture) {
     [self.view removeGestureRecognizer:tapGesture];
     }
     [self showError];
     }
     
     } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
     if (tapGesture) {
     [self.view removeGestureRecognizer:tapGesture];
     }
     [self showError];
     }];
     */
}

- (void)showError
{
    [self.view showLoadingMeg:@"数据加载失败" time:1];
}

#pragma mark --
#pragma mark -- NT_HotKeyCellDelegate method

- (void)searchWithHotKey:(NSString *)hotKey
{
    if (hotKey)
    {
        [self loadSearchResultBykeyWord:hotKey page:1];
    }
}

#pragma mark -
#pragma mark TableViewDelegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView ==self.hotKeysTableView)
    {
        return 1;
    }else if(tableView == self.searchHistoryTableView||tableView == self.searchNoticeTableView)
    {
        return 1;
    }
    else if (tableView == self.searchNoDataTableView)
    {
        //搜索无结果
        return 2;
    }
    else
    {
        //搜索结果显示 更多列 搜索数量提示
        if (self.gameListsArray.count) {
            return self.gameListsArray.count+1+1;
        }
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView ==self.hotKeysTableView) {
        return 1;
    }else if(tableView == self.searchHistoryTableView)
    {
        
        return [self.searchHistroyArray count];
    }else if(tableView == self.searchNoticeTableView)
    {
        return [self.searchNoticeArray count];
        
    }
    else if (tableView == self.searchNoDataTableView)
    {
        return 1;
    }
    else
    {
        if (self.selectedIndex >= 0 &&(self.selectedIndex == section))
        {
            return 2;
        }
        return 1;
    }
    return 0;
}

- (CGFloat)hotKeyHeight
{
    return ScreenHeight-(20+44+50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.hotKeysTableView)
    {
        return [self hotKeyHeight];
    }
    else  if(tableView == self.searchHistoryTableView||tableView == self.searchNoticeTableView)
    {
        return 50;
    }
    else if (tableView == self.searchNoDataTableView)
    {
        if (indexPath.section == 0)
        {
            //提示信息高度
            return 50;
        }
        else
        {
            //热词高度
            return [self hotKeyHeight];
        }
    }
    else
    {
        if (indexPath.section == 0)
        {
            return 50;
        }
        if (indexPath.section <= self.gameListsArray.count)
        {
            if (indexPath.row == 0)
            {
                return 71;
            }
            //NT_AppDetailInfo *info = self.gameListsArray[self.selectedIndex];
            //因为头部有条数显示，所以这里要减1
            NT_AppDetailInfo *info = self.gameListsArray[self.selectedIndex - 1];
            return [NT_MainSecondCell heightForAppsInfoDetail:info];
            
        }else if(indexPath.section == self.gameListsArray.count+1){
            //下拉刷新显示列
            return 40;
        }
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.hotKeysTableView)
    {
        NT_HotKeyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotKeyCell"];
        if (cell==nil)
        {
            cell = [[NT_HotKeyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hotKeyCell"];
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell getHotKeyArray:self.hotKeysArray];
        return cell;
        
    }else if(tableView == self.searchHistoryTableView||tableView == self.searchNoticeTableView)
    {
        NSString *cellName = (tableView == self.searchHistoryTableView?@"searchHistoryCell":@"searchNoticeCell");
        NT_SearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[NT_SearchHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            
        }
        if (tableView == self.searchNoticeTableView) {
            cell.conTextLabel.text = [self.searchNoticeArray objectAtIndex:indexPath.row];
        }else{
            cell.conTextLabel.text = [self.searchHistroyArray objectAtIndex:indexPath.row];
        }
        
        return cell;
    }
    else if (tableView == self.searchNoDataTableView)
    {
        if (indexPath.section == 0)
        {
            static NSString *noDataCell = @"noDataCell";
            
            NT_SearchNoDataCell *cell = [tableView dequeueReusableCellWithIdentifier:noDataCell];
            
            if (cell==nil) {
                cell = [[NT_SearchNoDataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noDataCell];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            if (self.searchKeywordNoData)
            {
                CGSize size = CGSizeMake(140, 30);
                CGSize maxSize = [self.searchKeywordNoData sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:size lineBreakMode:LINE_BREAK_WORD_WRAP];
                cell.searchKeywordLabel.left = 78;
                cell.searchKeywordLabel.width = maxSize.width;
                cell.searchKeywordLabel.text = self.searchKeywordNoData;
                
                cell.searchLabel.left = cell.searchKeywordLabel.right;
            }
            return cell;
        }
        else
        {
            NT_HotKeyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hotKeyCell"];
            if (cell==nil)
            {
                cell = [[NT_HotKeyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"hotKeyCell"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegate = self;
            }
            
            [cell getHotKeyArray:self.hotKeysArray];
            return cell;
            
        }
    }
    else
    {
        if (indexPath.section == 0)
        {
            NT_SearchResultCountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dataCell"];
            if (cell == nil)
            {
                cell = [[NT_SearchResultCountCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"dataCell"];
                cell.contentView.backgroundColor = [UIColor colorWithHex:@"#f2f2f2"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                
            }
            if (self.searchValue&&self.searchTotalCount)
            {
                //总条数宽度
                CGSize countSize = CGSizeMake(60, 20);
                NSString *countString = [[NSString alloc] initWithFormat:@"%d",self.searchTotalCount];
                CGSize maxSize = [countString sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:countSize lineBreakMode:LINE_BREAK_WORD_WRAP];
                //总条数
                UILabel *countLabel = (UILabel *)[cell.contentView viewWithTag:KSearchCount];
                countLabel.left = 68;
                countLabel.width = maxSize.width;
                countLabel.text = countString;
                
                //条与
                cell.label.left = countLabel.right;
                cell.label.width = 38;
                
                //搜索的热词宽度
                CGSize keySize = CGSizeMake(130, 30);
                CGSize maxKeySize = [self.searchValue sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:keySize lineBreakMode:LINE_BREAK_WORD_WRAP];
                
                //搜索的热词
                UILabel *searchKeywordLabel = (UILabel *)[cell.contentView viewWithTag:KSearchValue];
                searchKeywordLabel.left = cell.label.right;
                searchKeywordLabel.width = maxKeySize.width;
                searchKeywordLabel.text = self.searchValue;
                
                //相关结果
                cell.searchLabel.left = searchKeywordLabel.right;
                cell.searchLabel.width = 100;
                
            }
            return cell;
            
        }
        else
        {
            if (indexPath.section == self.gameListsArray.count+1)
            {
                NT_LoadMoreCell *cell = [[NT_LoadMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                if (_currentPage>=_totalPages) {
                    cell.label.text = @"已加载全部内容";
                }else
                {
                    cell.label.text = @"上拉加载更多...";
                }
                return cell;
            }
            
            static NSString *cellName = @"SearchResultCell";
            
            if (indexPath.row == 0)
            {
                //基本信息cell
                NT_MainCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
                if (!cell)
                {
                    cell = [[NT_MainCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
                    cell.delegates = self;
                    cell.tag = KSearchCellTag;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                }
                
                [cell formatWithDataArray:self.gameListsArray indexPath:indexPath selectedIndex:self.selectedIndex];
                return cell;
            }
            //无限金币cell
            NT_MainSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:nil];
            if (!cell)
            {
                cell = [[NT_MainSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.delegates = self;
            }
            [cell formatWithAppsInfoDetail:self.gameListsArray[self.selectedIndex-1]];
            return cell;
            
        }
    }
}

//选中行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.searchHistoryTableView||tableView == self.searchNoticeTableView) {
        NSString *searchWords = nil;
        if (tableView == self.searchHistoryTableView) {
            searchWords = [self.searchHistroyArray objectAtIndex:indexPath.row];
        }else
        {
            searchWords = [self.searchNoticeArray objectAtIndex:indexPath.row];
        }
        [self loadSearchResultBykeyWord:searchWords page:1];
    }
    if (tableView == self.searchResultTableView)
    {
        if (indexPath.section == 0)
        {
            //点击搜索条数，不触发事件
        }
        else
        {
            if (indexPath.section == self.gameListsArray.count+1)
            {
                //点击最后一列，不触发事件
            }
            else
            {
                if (indexPath.row < self.gameListsArray.count)
                {
                    // 友盟统计-搜索-结果点击量
                    umengLogSearchResultClick++;
                    
                    //进入应用详情界面
                    NT_AppDetailViewController *appDetail = [[NT_AppDetailViewController alloc] init];
                    NT_AppDetailInfo *detailInfo = (NT_AppDetailInfo*)[self.gameListsArray objectAtIndex:indexPath.section-1];
                    appDetail.infosDetail =detailInfo;
                    appDetail.appID = [appDetail.infosDetail.appId integerValue];
                    //[appDetail getData:[appDetail.infosDetail.appId integerValue]];
                    //隐藏tabbar
                    appDetail.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:appDetail animated:YES];
                    appDetail.hidesBottomBarWhenPushed = NO;
                }
                
            }
        }
    }
}

#pragma mark --
#pragma mark --  NTTableViewCellDelegate
//游戏图片点击
- (void)tableViewCell:(NT_MainCell *)tableViewCell didSelectSecondModel:(secondModel)model
{
    NT_AppDetailViewController *appDetail = [[NT_AppDetailViewController alloc] init];
    appDetail.infosDetail = self.gameListsArray[tableViewCell.indexParh.section-1];
    appDetail.appID = [appDetail.infosDetail.appId integerValue];
    //[appDetail getData:[appDetail.infosDetail.appId integerValue]];
    if (self.isOnlineGame) {
        appDetail.isOnlineGame = YES;
    }
    
    //隐藏tabbar
    appDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:appDetail animated:YES];
    appDetail.hidesBottomBarWhenPushed = NO;
    
}

//点击下载按钮 弹出框
- (BOOL)tableViewCell:(NT_MainCell *)tableViewCell shouldOpenSecondModel:(secondModel)model
{
    int newIndex = tableViewCell.indexParh.section;
    NSLog(@"new index:%d",newIndex);
    
    NT_AppDetailInfo *info = self.gameListsArray[newIndex-1];
    
    if (![NT_UpdateAppInfo versionCompare:info.minVersion and:[[UIDevice currentDevice] systemVersion]])
    {
        if (info.downloadArray.count <= 1)
        {
            if (!info.downloadArray.count) {
                [self.view showLoadingMeg:@"获取下载链接失败" time:1];
            }
            else
            {
                NT_DownloadAddInfo *downloadInfo = info.downloadArray[0];
                NT_DownloadModel *downModel = [[NT_DownloadModel alloc] initWithAddress:downloadInfo.download_addr andGameName:info.game_name andRoundPic:info.round_pic andVersion:info.app_version_name andAppID:info.appId];
                downModel.package = info.package;
                self.downloadModel = downModel;
                if (self.isOnlineGame) {
                    [self onlineDownLoadDialog:info];
                }else
                {
                    //只有纯净正版或纯净版下载
                    [self downloadWithMode:downModel indexPath:[NSIndexPath indexPathForRow:0 inSection:newIndex] index:model];
                }
            }
            return NO;
        }
        
        //收起弹出框
        if (self.selectedIndex == newIndex) {
            self.selectedIndex = -1;
            //reloadSections必须使用beginUpdates和endUpdates方法
            [self.searchResultTableView beginUpdates];
            [self.searchResultTableView reloadSections:[NSIndexSet indexSetWithIndex:newIndex] withRowAnimation:UITableViewRowAnimationNone];
            [self.searchResultTableView endUpdates];
            
            return NO;
        }
        
        //弹出框
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndex:newIndex];
        if (self.selectedIndex >= 0) {
            [indexSet addIndex:self.selectedIndex];
        }
        self.selectedIndex = newIndex;
        
        //reloadSections必须使用beginUpdates和endUpdates方法
        [self.searchResultTableView beginUpdates];
        [self.searchResultTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        [self.searchResultTableView endUpdates];
        
        CGRect rect = [self.searchResultTableView rectForSection:self.selectedIndex];
        [self.searchResultTableView scrollRectToVisible:rect animated:YES];
        
        return YES;
        
    }
    else
    {
        //CGFloat bottomY = [[NSUserDefaults standardUserDefaults] floatForKey:KBottomInfo];
        CGFloat bottomY = SCREEN_HEIGHT-(64+44+24);
        UILabel *_jreLabel = nil;
        if (bottomY)
        {
            //最低版本兼容信息
            //self.height-(64+13)
            _jreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, bottomY, SCREEN_WIDTH, 21)];
        }
        else
        {
            _jreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.height-(64+13), SCREEN_WIDTH, 21)];
        }
        _jreLabel.backgroundColor = [UIColor redColor];
        _jreLabel.textAlignment = TEXT_ALIGN_CENTER;
        _jreLabel.textColor = [UIColor whiteColor];
        _jreLabel.font = [UIFont  boldSystemFontOfSize:12];
        _jreLabel.text = [NSString stringWithFormat:@"您的系统版本为%@，需要%@以上版本",[[UIDevice currentDevice] systemVersion],info.minVersion];
        [self.view addSubview:_jreLabel];
        
        [self perform:^{
            [_jreLabel removeFromSuperview];
        } afterDelay:3];
        
    }
    return NO;
    
    /*
     if (info.downloadArray.count <= 1)
     {
     if (!info.downloadArray.count) {
     [self.view showLoadingMeg:@"获取下载链接失败" time:1];
     }
     else
     {
     NT_DownloadAddInfo *downloadInfo = info.downloadArray[0];
     NT_DownloadModel *downModel = [[NT_DownloadModel alloc] initWithAddress:downloadInfo.download_addr andGameName:info.game_name andRoundPic:info.round_pic andVersion:info.app_version_name andAppID:info.appId];
     downModel.package = info.package;
     self.downloadModel = downModel;
     if (self.isOnlineGame&&![[UIDevice currentDevice] isJailbroken]) {
     [self onlineDownLoadDialog:info];
     }else
     {
     //只有纯净正版或纯净版下载
     [self downloadWithMode:downModel indexPath:[NSIndexPath indexPathForRow:0 inSection:newIndex] index:model];
     }
     }
     return NO;
     }
     
     //收起弹出框
     if (self.selectedIndex == newIndex) {
     self.selectedIndex = -1;
     [self.searchResultTableView reloadSections:[NSIndexSet indexSetWithIndex:newIndex] withRowAnimation:UITableViewRowAnimationNone];
     return NO;
     }
     
     //弹出框
     NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSetWithIndex:newIndex];
     if (self.selectedIndex >= 0) {
     [indexSet addIndex:self.selectedIndex];
     }
     self.selectedIndex = newIndex;
     
     [self.searchResultTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
     
     CGRect rect = [self.searchResultTableView rectForSection:self.selectedIndex];
     [self.searchResultTableView scrollRectToVisible:rect animated:YES];
     
     return YES;
     */
    
}

//点击无限金币弹出框下载
#pragma mark InstallSecondCellDelegate
- (void)installSecondCell:(NT_MainSecondCell *)installSecondCell installIndex:(int)index
{
    if (index == 10) {
        int tmp = self.selectedIndex;
        self.selectedIndex = -1;
        
        //reloadSections必须使用beginUpdates和endUpdates方法
        [self.searchResultTableView beginUpdates];
        [self.searchResultTableView reloadSections:[NSIndexSet indexSetWithIndex:tmp] withRowAnimation:UITableViewRowAnimationNone];
        [self.searchResultTableView endUpdates];
        
        
        return;
    }
    
    //下载
    NT_DownloadAddInfo *downloadInfo = installSecondCell.appsInfoDetail.downloadArray[index];
    
    NT_AppDetailInfo *modelInfo = self.gameListsArray[self.selectedIndex-1];
    NT_DownloadModel *model = [[NT_DownloadModel alloc] initWithAddress:downloadInfo.download_addr andGameName:[NSString stringWithFormat:@"%@%@",modelInfo.game_name,downloadInfo.version_name] andRoundPic:modelInfo.round_pic andVersion:modelInfo.app_version_name  andAppID:modelInfo.appId];
    model.package = modelInfo.package;
    self.downloadModel = model;
    if (self.isOnlineGame) {
        [self onlineDownLoadDialog:installSecondCell.appsInfoDetail];
    }else{
        
        [self downloadWithMode:model indexPath:[NSIndexPath indexPathForRow:0 inSection:self.selectedIndex] index:1];
    }
    
}

//网游弹框提示
- (void)onlineDownLoadDialog:(NT_AppDetailInfo *)info
{
    UIView *view = [NTAppDelegate shareNTAppDelegate].tabController.navigationController.view;
    NT_OnlineGameDialog *online = [[NT_OnlineGameDialog alloc] initWithFrame:view.bounds appsInfo:info];
    [online.ntDownBtn addTarget:self action:@selector(ntDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [online.appStoreDownBtn addTarget:self action:@selector(appStoreDownBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.appInfoDetail = info;
    [view addSubview:online];
}

// 奶糖账号下载按钮点击
- (void)ntDownBtnClick:(UIButton *)btn
{
    if(self.downloadModel != nil)
    {
        [btn.superview setHidden:YES];
        [btn.superview removeFromSuperview];
        BOOL isDownLoad = [[NT_DownloadManager sharedNT_DownLoadManager] downLoadWithModel:self.downloadModel];
        NSLog(@"%d",isDownLoad);
    }
}

//  打开appstore按钮点击
- (void)appStoreDownBtnClick:(UIButton *)btn
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        [self openAppWithIdentifier:self.appInfoDetail.apple_id];
    }else
    {
        [self outerOpenAppWithIdentifier:self.appInfoDetail.apple_id goAppStore:btn];
    }
}

- (void)openAppWithIdentifier:(NSString *)appId {
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [self.view showLoadingMeg:@"加载中.."];
    [self.view setLoadingUserInterfaceEnable:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenLoading:)];
    [self.view addGestureRecognizer:tapGesture];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
        if (tapGesture) {
            [self.view removeGestureRecognizer:tapGesture];
        }
        [self.view hideLoading];
        if (result) {
            [self.navigationController presentViewController:storeProductVC animated:YES completion:nil];
            //[[NTAppDelegate shareNTAppDelegate].tabController.navigationController presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
    //    NSString *str = [NSString stringWithFormat:@"http://itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",appId];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8",appId]]];
}

- (void)hiddenLoading:(UITapGestureRecognizer *)tap
{
    if (tap) {
        [self.view removeGestureRecognizer:tap];
    }
    [self.view hideLoading];
}

// ios6 以下设备
- (void)outerOpenAppWithIdentifier:(NSString *)appId  goAppStore:(UIButton*)btn{
    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8", appId];
    NSURL *url = [NSURL URLWithString:urlStr];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [btn.superview setHidden:YES];
        [btn.superview removeFromSuperview];
        [[UIApplication sharedApplication] openURL:url];
        
    }
    
    
}

#pragma mark SKStoreProductViewControllerDelegate
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [viewController dismissViewControllerAnimated:YES completion:^{
        if (isIOS7) {
            [NTAppDelegate shareNTAppDelegate].tabController.navigationController.view.top = 20;
            [NTAppDelegate shareNTAppDelegate].tabController.view.height = [NTAppDelegate shareNTAppDelegate].window.height - 20;
        }
    }];
}

- (BOOL)addDownloadWithInfo:(NT_DownloadAddInfo *)downloadInfo appsInfoDetail:(NT_AppDetailInfo *)modelInfo
{
    NT_DownloadModel *model = [[NT_DownloadModel alloc] initWithAddress:downloadInfo.download_addr andGameName:modelInfo.game_name andRoundPic:modelInfo.round_pic andVersion:modelInfo.app_version_name andAppID:modelInfo.appId];
    model.package = modelInfo.package;
    // YES 可以下载，并且开始下载   NO 下载地址无效或者已经下载过了
    BOOL isDownLoad = [[NT_DownloadManager sharedNT_DownLoadManager] downLoadWithModel:model];
    //    NSLog(@"%d",isDownLoad);
    return isDownLoad;
}

- (void)downloadWithMode:(NT_DownloadModel *)model indexPath:(NSIndexPath *)indexPath index:(int)index
{
    //网络连接状态
    NSString *netConnection = [[NT_HttpEngine sharedNT_HttpEngine] getCurrentNet];
    
    //若设置里打开只在wifi下下载游戏，即在3G状态就不下载
    if ([NT_SettingManager onlyDownloadUseWifi] && [netConnection isEqualToString:NETWORKVIA3G])
    {
        showAlert(@"当前是2G/3G网络，您开启了只在Wifi下下载游戏功能");
    }
    else
    {
        NT_MainCell *cell = (NT_MainCell *)[self.searchResultTableView cellForRowAtIndexPath:indexPath];
        NT_BaseView *imageView = (NT_BaseView *)[cell.contentView viewWithTag:1];
        [imageView.button setTitle:@"下载中" forState:UIControlStateNormal];
        [imageView.button setBackgroundImage:[UIImage imageNamed:@"btn-green-download-hover.png"] forState:UIControlStateNormal];
        CGRect convertRect = [cell convertRect:imageView.appIcon.frame toView:self.view];
        convertRect.origin.x += (index-1)*SCREEN_WIDTH;
        EGOImageView *iconImgView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"default-icon.png"]];
        //若有缓存，使用缓存
        [iconImgView imageUrl:[NSURL URLWithString:model.iconName] tempSTR:@"false"];
        /*
         NT_WifiBrowseImage *wifiImage = [[NT_WifiBrowseImage alloc] init];
         [wifiImage wifiBrowseImage:iconImgView urlString:model.iconName];
         */
        //[iconImgView setImageWithURL:[NSURL URLWithString:model.iconName]];
        iconImgView.frame = convertRect;
        iconImgView.clipsToBounds = YES;
        iconImgView.layer.cornerRadius = 15;
        iconImgView.layer.borderWidth = 1;
        [self.view addSubview:iconImgView];
        [UIView animateWithDuration:0.7 animations:^{
            iconImgView.center = CGPointMake(4*SCREEN_WIDTH/5.0, SCREEN_HEIGHT-49);
            iconImgView.bounds = CGRectMake(0, 0, 0, 0);
        }];
        //    }
        [self perform:^{
            [imageView.button setTitle:@"免费下载" forState:UIControlStateNormal];
            [imageView.button setBackgroundImage:[UIImage imageNamed:@"btn-green-download.png"] forState:UIControlStateNormal];
            [imageView.button setBackgroundImage:[UIImage imageNamed:@"btn-green-download-hover.png"] forState:UIControlStateHighlighted];
        } afterDelay:10];
        
        // YES 可以下载，并且开始下载   NO 下载地址无效或者已经下载过了
        BOOL flag = [[NT_DownloadManager sharedNT_DownLoadManager] downLoadWithModel:model];
        if (flag)
        {
            NSString *downloadCountString = [[NSUserDefaults standardUserDefaults] objectForKey:KDownloadCount];
            if (downloadCountString)
            {
                UITabBarController *tabController = [NTAppDelegate shareNTAppDelegate].tabController;
                [[tabController.tabBar.items objectAtIndex:4] setBadgeValue:downloadCountString];
                
            }
        }
    }
}

#pragma mark SearchBarDelegate Method

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    searchBar.placeholder=@"";
    if (self.searchHistroyArray.count) {
        self.searchHistoryTableView.hidden = NO;
        [self.searchHistoryTableView reloadData];
        [self.view bringSubviewToFront:self.searchHistoryTableView];
    }
    searchBar.showsCancelButton = YES;
    if (searchBar.showsCancelButton) {
        _searchBarBgView.width = self.view.width-75;
    }
    if (isIOS7)
    {
        //ios7下的取消按钮
        UIView *topView = self.searchBar.subviews[0];
        UIButton *btn = nil;
        for (id obj in [topView subviews])
        {
            if ([obj isKindOfClass:[UIButton class]])
            {
                btn = (UIButton *)obj;
            }
        }
        if (btn)
        {
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHex:@"#1eb5f7"] forState:UIControlStateNormal];
        }
        
    }
    else
    {
        //ios5 ios6的取消按钮
        UIButton *btn = nil;
        for (id obj in [searchBar subviews])
        {
            if ([obj isKindOfClass:[UIButton class]])
            {
                btn = (UIButton *)obj;
            }
        }
        if (btn)
        {
            //若按钮值是取消，系统按钮背景是黑色，按钮值是cancel，所以用空格遮住
            [btn setTitle:@"  " forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"search-cancel.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"search-cancel.png"] forState:UIControlStateHighlighted];
        }
        
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.placeholder = @"输入游戏名称！                       ";
    searchBar.text = @"";
    self.searchHistoryTableView.hidden = YES;
    self.searchNoticeTableView.hidden = YES;
    self.searchNoDataTableView.hidden = YES;
    searchBar.showsCancelButton = NO;
    self.hotKeysTableView.hidden = NO;
    [self.view bringSubviewToFront:self.hotKeysTableView];
    [searchBar resignFirstResponder];
    if (!searchBar.showsCancelButton) {
        _searchBarBgView.width = self.view.width-30;
    }
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if ([searchText length])
    {
        //获取搜索时显示的关联词表
        self.searchValue = searchText;
        
        NSString *url = @"http://apitest.naitang.com/";
        NSString *urlString = nil;
        if (isIpad)
        {
            urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile_v1.php?action=search&op=sotitle&product=2&version_type=2&keyword=%@",[searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] : [NSString stringWithFormat:@"mobile_v1.php?action=search&op=sotitle&product=2&version_type=1&keyword=%@",[searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        else
        {
            urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile_v1.php?action=search&op=sotitle&product=1&version_type=1&keyword=%@",[searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] : [NSString stringWithFormat:@"mobile_v1.php?action=search&op=sotitle&product=1&version_type=1&keyword=%@",[searchText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
        urlString = [NSString stringWithFormat:@"%@%@",url,urlString];
        NSLog(@"urlstring:%@",urlString);
        
        [DataService requestWithURL:urlString finishBlock:^(id result) {
            NSDictionary *dic = (NSDictionary *)result;
            if ([dic[@"status"] boolValue])
            {
                if ([dic[@"data"] count] > 0)
                {
                    //获取搜索关联词
                    id noticeDic = dic[@"data"][@"game_name"];
                    [self.searchNoticeArray removeAllObjects];
                    if ([noticeDic isKindOfClass:[NSDictionary class]]) {
                        NSEnumerator *enumerator = [noticeDic objectEnumerator];
                        id obj;
                        while (obj = [enumerator nextObject]) {
                            [self.searchNoticeArray addObject:obj];
                        }
                    }else if ([noticeDic isKindOfClass:[NSArray class]])
                    {
                        for (NSString *notice in noticeDic) {
                            [self.searchNoticeArray addObject:notice];
                        }
                    }
                    [self.searchNoticeTableView reloadData];
                    
                }
            }
        }];
        
        self.searchNoticeTableView.hidden = NO;
        [self.searchNoticeTableView reloadData];
        [self.view bringSubviewToFront:self.searchNoticeTableView];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self loadSearchResultBykeyWord:searchBar.text page:1];
}

#pragma mark -
#pragma mark LoadSearchResult 搜索函数


//获取搜索结果数据
- (void)loadSearchResultBykeyWord:(NSString *)keyword page:(int)page
{
    self.searchValue = keyword;
    self.searchBar.text = keyword;
    self.searchBar.showsCancelButton = YES;
    [self.searchBar resignFirstResponder];
    self.searchHistoryTableView.hidden = YES;
    // 使cancel可以点击
    _searchBarBgView.width = self.view.width-75;
    
    if (isIOS7_1)
    {
        [[[[_searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
        [_searchBar setBackgroundColor:[UIColor colorWithRed:245.f/255.f green:238.f/255.f blue:219.f/255.f alpha:1]];
    }
    else if (isIOS7)
    {
        //ios7下的取消按钮
        UIView *topView = self.searchBar.subviews[0];
        UIButton *btn = nil;
        for (id obj in [topView subviews])
        {
            if ([obj isKindOfClass:[UIButton class]])
            {
                btn = (UIButton *)obj;
            }
        }
        if (btn)
        {
            [btn setTitle:@"取消" forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor colorWithHex:@"#1eb5f7"] forState:UIControlStateNormal];
            btn.enabled = YES;
        }
        
    }
    else
    {
        //ios5 ios6的取消按钮
        UIButton *btn = nil;
        for (id obj in [self.searchBar subviews])
        {
            if ([obj isKindOfClass:[UIButton class]])
            {
                btn = (UIButton *)obj;
            }
        }
        if (btn)
        {
            //若按钮值是取消，系统按钮背景是黑色，按钮值是cancel，所以用空格遮住
            [btn setTitle:@"  " forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"search-cancel.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"search-cancel.png"] forState:UIControlStateHighlighted];
            btn.enabled = YES;
        }
        
    }
    
    /*
     for (id obj in self.searchBar.subviews) {
     if ([obj isKindOfClass:[UIButton class]]) {
     UIButton *btn = obj;
     btn.enabled = YES;
     break;
     }
     }
     */
    
    //[self addHistoryWord:keyword];
    
    if (page<=1) {
        [self.view showLoadingMeg:@"搜索中..."];
    }
    else
    {
        [self startLoadingMore];
    }
    
    self.searchModel = nil;
    
    _isLoading = YES;
    
    [self.view setLoadingUserInterfaceEnable:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenLoading:)];
    [self.view addGestureRecognizer:tapGesture];
    
    // 友盟统计-搜索-检索量
    umengLogSearchUse++;
    
    NSString *searchValue = [self.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    //NSString *searchValue = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)(self.searchBar.text), NULL, NULL, kCFStringEncodingUTF8));
    //NSString *searchValue = self.searchBar.text;
    NSLog(@"searchValue:%@",searchValue);
    
    NSString *url = @"http://apitest.naitang.com/";
    NSString *urlString = nil;
    if (isIpad) {
        urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile_v1.php?action=search&op=result&product=2&version_type=2&key=%@&page=%d",searchValue,page] : [NSString stringWithFormat:@"mobile_v1.php?action=search&op=result&product=2&version_type=1&key=%@&page=%d",searchValue,page];
    }else
    {
        urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile_v1.php?action=search&op=result&product=1&version_type=1&key=%@&page=%d",searchValue,page] : [NSString stringWithFormat:@"mobile_v1.php?action=search&op=result&product=1&version_type=1&key=%@&page=%d",searchValue,page];
    }
    
    urlString = [NSString stringWithFormat:@"%@%@",url,urlString];
    NSLog(@"search url:%@",urlString);
    
    [DataService requestWithURL:urlString finishBlock:^(id result) {
        
        NSLog(@"search result:%@",result);
        _isLoading = NO;
        if (tapGesture) {
            [self.view removeGestureRecognizer:tapGesture];
        }
        if (page <= 1) {
            [self.view hideLoading];
        }
        else
        {
            [self stopLoadingMore];
        }
        
        NSDictionary *dic = (NSDictionary *)result;
        if ([dic[@"status"] boolValue])
        {
            self.searchResultTableView.hidden = NO;
            [self.view bringSubviewToFront:self.searchResultTableView];
            //NSLog(@"%@",dic);
            
            if (page<=1) {
                self.searchResultTableView.contentOffset = CGPointMake(0, 0);
                [self.gameListsArray removeAllObjects];
            }
            
            _currentPage = page;
            _totalPages = [[dic objectForKey:@"page"] intValue];
            
            
            NSArray *gameList = [dic objectForKey:@"data"];
            if (gameList.count > 0)
            {
                //有搜索结果，添加到历史记录
                [self addHistoryWord:keyword];
                
                //获取搜索结果总条数
                self.searchTotalCount=_totalPages*gameList.count;
                if (gameList.count>0) {
                    for (int i=0;i<[gameList count];i++)
                    {
                        //获取搜索结果数据
                        NSDictionary *subDic = [gameList objectAtIndex:i];
                        NT_AppDetailInfo *detailnfo = [NT_AppDetailInfo inforFromDetailDic:subDic];
                        [self.gameListsArray addObject:detailnfo];
                    }
                    [self.searchResultTableView reloadData];
                    
                    //收起无限金币的弹框
                    if (self.selectedIndex > -1) {
                        int tmp = self.selectedIndex;
                        self.selectedIndex = -1;
                        //reloadSections必须使用beginUpdates和endUpdates方法
                        [self.searchResultTableView beginUpdates];
                        [self.searchResultTableView reloadSections:[NSIndexSet indexSetWithIndex:tmp] withRowAnimation:UITableViewRowAnimationNone];
                        [self.searchResultTableView endUpdates];
                        
                    }
                    
                }
            }
        }
        else
        {
            self.searchHistoryTableView.hidden = YES;
            //搜索无结果
            self.searchKeywordNoData = keyword;
            self.searchNoDataTableView.hidden = NO;
            [self.searchNoDataTableView reloadData];
            [self.view bringSubviewToFront:self.searchNoDataTableView];
            
        }
        
    } errorBlock:^(id result) {
        [self stopLoadingMore];
        _isLoading = NO;
        [self.view showLoadingMeg:@"网络异常" time:1];
    }];
    /*
     [DataService requestWithURL:urlString finishBlock:^(id result) {
     _isLoading = NO;
     if (tapGesture) {
     [self.view removeGestureRecognizer:tapGesture];
     }
     if (page <= 1) {
     [self.view hideLoading];
     }
     else
     {
     [self stopLoadingMore];
     }
     
     NSDictionary *dic = (NSDictionary *)result;
     if ([dic[@"status"] boolValue])
     {
     self.searchResultTableView.contentOffset = CGPointMake(0, 0);
     self.searchResultTableView.hidden = NO;
     [self.view bringSubviewToFront:self.searchResultTableView];
     //NSLog(@"%@",dic);
     
     if (page<=1) {
     [self.gameListsArray removeAllObjects];
     }
     
     _currentPage = page;
     _totalPages = [[dic objectForKey:@"page"] intValue];
     
     
     NSArray *gameList = [dic objectForKey:@"data"];
     if (gameList.count > 0)
     {
     //有搜索结果，添加到历史记录
     [self addHistoryWord:keyword];
     
     //获取搜索结果总条数
     self.searchTotalCount=_totalPages*gameList.count;
     if (gameList.count>0) {
     for (int i=0;i<[gameList count];i++)
     {
     //获取搜索结果数据
     NSDictionary *subDic = [gameList objectAtIndex:i];
     NT_AppDetailInfo *detailnfo = [NT_AppDetailInfo inforFromDetailDic:subDic];
     [self.gameListsArray addObject:detailnfo];
     }
     [self.searchResultTableView reloadData];
     }
     }
     }
     else
     {
     self.searchHistoryTableView.hidden = YES;
     //搜索无结果
     self.searchKeywordNoData = keyword;
     self.searchNoDataTableView.hidden = NO;
     [self.searchNoDataTableView reloadData];
     [self.view bringSubviewToFront:self.searchNoDataTableView];
     
     }
     
     }];
     */
    /*
     [[NT_HttpEngine sharedNT_HttpEngine] getSearchResultWithKeyWord:[self.searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] page:page  CompletionHandler:^(MKNetworkOperation *completedOperation) {
     
     _isLoading = NO;
     if (tapGesture) {
     [self.view removeGestureRecognizer:tapGesture];
     }
     if (page <= 1) {
     [self.view hideLoading];
     }
     else
     {
     [self stopLoadingMore];
     }
     
     NSDictionary *dic = [completedOperation responseJSON];
     if ([dic[@"status"] boolValue])
     {
     self.searchResultTableView.hidden = NO;
     [self.view bringSubviewToFront:self.searchResultTableView];
     //NSLog(@"%@",dic);
     
     if (page<=1) {
     [self.gameListsArray removeAllObjects];
     }
     
     _currentPage = page;
     _totalPages = [[dic objectForKey:@"page"] intValue];
     
     
     NSArray *gameList = [dic objectForKey:@"data"];
     
     //获取搜索结果总条数
     self.searchTotalCount=_totalPages*gameList.count;
     
     if (gameList.count>0) {
     for (int i=0;i<[gameList count];i++)
     {
     //获取搜索结果数据
     NSDictionary *subDic = [gameList objectAtIndex:i];
     NT_AppDetailInfo *detailnfo = [NT_AppDetailInfo inforFromDetailDic:subDic];
     [self.gameListsArray addObject:detailnfo];
     }
     [self.searchResultTableView reloadData];
     }
     }
     else
     {
     self.searchHistoryTableView.hidden = YES;
     //搜索无结果
     self.searchKeywordNoData = keyword;
     self.searchNoDataTableView.hidden = NO;
     [self.searchNoDataTableView reloadData];
     [self.view bringSubviewToFront:self.searchNoDataTableView];
     
     }
     } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
     _isLoading = NO;
     if (tapGesture) {
     [self.view removeGestureRecognizer:tapGesture];
     }
     if (page<=1) {
     [self.view showLoadingMeg:@"数据加载失败" time:1];
     }
     else
     {
     [self stopLoadingMore];
     }
     }];
     */
}

//添加热词到历史记录表
- (void)addHistoryWord:(NSString *)history
{
    BOOL flag = NO;
    for (NSString *str in self.searchHistroyArray) {
        if ([str isEqualToString:history]) {
            flag = YES;
            break;
        }
    }
    if (!flag) {
        [self.searchHistroyArray insertObject:history atIndex:0];
    }
    if (self.searchHistroyArray.count>10) {
        [self.searchHistroyArray removeLastObject];
    }
    if (self.searchHistroyArray && self.searchHistroyArray.count>0) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.searchHistroyArray];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"SearchHistoryArray"];
    }else
    {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SearchHistoryArray"];
    }
    
}

#pragma mark--
#pragma mark-- LoadingMore  Methods

- (void)getMore
{
    if (_isLoading) {
        return;
    }
    if (_currentPage >= _totalPages) {
        return;
    }
    if (_currentPage < 1) {
        return;
    }
    [self loadSearchResultBykeyWord:self.searchBar.text page:_currentPage + 1];
}

- (void)startLoadingMore
{
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:self.gameListsArray.count+1];
    NT_LoadMoreCell *cell = (NT_LoadMoreCell *)[self.searchResultTableView cellForRowAtIndexPath:lastIndexPath];
    [cell startLoading];
}
- (void)stopLoadingMore
{
    NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:0 inSection:self.gameListsArray.count+1];
    NT_LoadMoreCell *cell = (NT_LoadMoreCell *)[self.searchResultTableView cellForRowAtIndexPath:lastIndexPath];
    [cell endLoading];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.searchResultTableView) {
        CGPoint origin = scrollView.contentOffset;
        if (scrollView.contentSize.height > scrollView.frame.size.height && scrollView.contentSize.height - origin.y <= self.searchResultTableView.height+40) {
            [self getMore];
        }
    }
}

/**
 清除搜索历史记录
 */
- (void)btnNextPageAction
{
    NSLog(@"清除掉");
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SearchHistoryArray"];
    [self.searchHistroyArray removeAllObjects];
    _searchHistoryTableView.height = YES;
    [_searchHistoryTableView reloadData];
}

- (void)dealloc
{
    [self clear];
}

- (void)clear
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kApplicationWillEnterForeground object:nil];
    
    self.searchBar = nil;
    self.hotKeysTableView = nil;
    self.searchResultTableView = nil;
    self.searchHistoryTableView = nil;
    self.searchNoticeTableView = nil;
    self.searchNoDataTableView = nil;
    self.whiteBgView = nil;
    self.searchValue = nil;
    self.searchHistroyArray = nil;
    self.searchTotalCount = 0;
    self.isOnlineGame = NO;
    self.hotKeysArray = nil;
    self.searchNoticeArray = nil;
    self.gameListsArray = nil;
    self.searchModel = nil;
    self.appDetailInfo = nil;
    self.headback = nil;
    self.selectedIndex = 0;
    self.searchKeywordNoData = nil;
    self.downloadModel = nil;
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
