//
//  liBaoViewController.m
//  libao
//
//  Created by wangxing on 14-2-26.
//  Copyright (c) 2014年 wangxing. All rights reserved.
//

#import "liBaoViewController.h"
#import "libaoTableCell.h"
#import "AppDelegate_Def.h"
#import "liBaoViewModel.h"
// 网络请求
#import "DataService.h"
#import "liBaoDetailViewController.h"
// tableView的美化
#import "Utile.h"
// 网络检测
#import "SwitchTableView.h"

// loading
#import "MBProgressHUD.h"

#import "ASIHTTPRequest.h"

@interface liBaoViewController ()
{
    liBaoDetailViewController * detailView;
    MBProgressHUD * progressHud;
    BOOL isPullDown;
    int currentPage;
    // 每页的条目数
    int pageSize;
    
    // 静态接口返回的数据
    NSMutableArray * res;
}

@end

@implementation liBaoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        currentPage = 1;
        isPullDown = NO;
        pageSize = 10;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{

    if (iPhone4) {

        if(IOS6){
            
            self.scrollerWrap.frame = CGRectMake(0, 35, 320, 331);
            self.scroller.frame = CGRectMake(0, 0, 320, 331);
        }else{
            self.buttonNav.frame = CGRectMake(0, 64, 320, 35);
            self.scrollerWrap.frame = CGRectMake(0, 99, 320, 331);
            self.scroller.frame = CGRectMake(0, 0, 320, 331);
        }
        
    }else{
        if (IOS6) {
            
        }else{
            self.buttonNav.frame = CGRectMake(0, 64, 320, 35);
            self.scrollerWrap.frame = CGRectMake(0, 99, 320, 419);
            self.scroller.frame = CGRectMake(0, 0, 320, 419);
        }
    }
    
    self.scroller.contentSize = CGSizeMake(640, _scroller.frame.size.height);
    
    
    [_listLibaoTableView reloadData];
    
    if([[[liBaoViewModel shareLibaoViewModel] getTableListLibaoDataOfType:@"my"] count] == 0){
        _myLibaoTableView.hidden = YES;
        _labelPlaceHoldForMy.hidden = NO;
    }else{
        _myLibaoTableView.hidden = NO;
        _labelPlaceHoldForMy.hidden = YES;
    }
    [_myLibaoTableView reloadData];
    
    
//    NSLog(@"scroll view's frame, height: %f, width: %f, x: %f, y: %f",_listLibaoTableViewWrap.frame.size.height,_listLibaoTableViewWrap.frame.size.width,_listLibaoTableViewWrap.frame.origin.x,_listLibaoTableViewWrap.frame.origin.y);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    NSMutableArray * listArr = [[liBaoViewModel shareLibaoViewModel] getTableListLibaoDataOfType:@"list"];
    
    if ([listArr count])
    {
        // list在每次初始化礼包列表的时候，清空数据
        [listArr removeAllObjects];
    }
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = @"游戏礼包";
    titleLable.textAlignment = TEXT_ALIGN_CENTER;
    [titleLable sizeToFit];
    self.navigationItem.titleView = titleLable;

    
    UIButton * returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn setImage:[UIImage imageNamed:@"top-back.png"] forState:UIControlStateNormal];
    [returnBtn setImage:[UIImage imageNamed:@"top-back-hover.png"] forState:UIControlStateHighlighted];
    returnBtn.frame = CGRectMake(0, 0, 44, 44);
    [returnBtn addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * returnBar = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItem = returnBar;
    
    _scroller.delegate = self;


    
//    [_listLibaoTableView awakeFromNib];
    _listLibaoTableView.delegate = self;
    _listLibaoTableView.dataSource = self;
    _listLibaoTableView.backgroundColor = [UIColor whiteColor];
    _listLibaoTableView.rowHeight = 110;
    _listLibaoTableView.refreshDelegate = self;
    
    
    
//    [self.listLibaoTableViewWrap addSubview:_listLibaoTableView];
    // 默认隐藏，在获取数据后显示
    _listLibaoTableView.hidden = YES;
    // 去掉多余的tablecell
//    [Utile setExtraCellLineHidden:_listLibaoTableView];

    _myLibaoTableView.delegate = self;
    _myLibaoTableView.dataSource = self;
    _myLibaoTableView.backgroundColor = [UIColor whiteColor];
    _myLibaoTableView.rowHeight = 110;
    [Utile setExtraCellLineHidden:_myLibaoTableView];

    // 读取本地存储的我的礼包的数据，如果存在，则显示礼包tableView
    if([[[liBaoViewModel shareLibaoViewModel] getTableListLibaoDataOfType:@"my"] count] == 0){
        _myLibaoTableView.hidden = YES;
        _labelPlaceHoldForMy.hidden = NO;
    }else{
        _myLibaoTableView.hidden = NO;
        _labelPlaceHoldForMy.hidden = YES;
    }
    
//@"http://wx.www.7k7k.com/test/libao/list.html"
//    @"http://dev.dedecms.7k7k.com/json/fahao/giftlist/pg/1.html"
    
    if([[SwitchTableView shareSwitchTableViewData] isConnectionAvailable]){
        progressHud = [[MBProgressHUD alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 98, self.view.frame.size.width, self.view.frame.size.height - 98)];
        progressHud.labelText = @"加载中.....";
        progressHud.mode = MBProgressHUDModeIndeterminate;
        progressHud.minSize = CGSizeMake(100, 100);
        [self.view addSubview:progressHud];
        [progressHud show:YES];//开始显示
        
        [self loadData];
    }

    // 友盟统计-礼包-展示量
    umengLogGiftListShow++;


}

- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)navButtonPressed:(UIButton *)sender {

    if(sender.tag == 0){
//        NSLog(@"curr preesed button is 礼包");
        
        [self.listLibaoButton setSelected:YES];
        [self.myLibaoButton setSelected:NO];
        
        
        
        [UIView animateWithDuration:0.2f animations:^{
            self.slideLineView.frame = CGRectMake(sender.frame.origin.x, 31, 80, 4);
        } completion:^(BOOL finished) {
            [_scroller setContentOffset:CGPointMake(0, 0) animated:YES];
        }];
        
    }else{
//        NSLog(@"curr preesed button is 我的礼包");
        
        
        [self.listLibaoButton setSelected:NO];
        [self.myLibaoButton setSelected:YES];
        
        
        [UIView animateWithDuration:0.2f animations:^{
            self.slideLineView.frame = CGRectMake(sender.frame.origin.x, 31, 80, 4);
        } completion:^(BOOL finished) {
            [_scroller setContentOffset:CGPointMake(320, 0) animated:YES];
        }];
    }
    
}



#pragma mark UIScrollView delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(_scroller.contentOffset.x == 0){
        // 切换到 礼包列表
        [UIView animateWithDuration:0.2f animations:^{
            self.slideLineView.frame = CGRectMake(_listLibaoButton.frame.origin.x, 31, 80, 4);
        } completion:^(BOOL finished) {
            [_listLibaoButton setSelected:YES];
            [_myLibaoButton setSelected:NO];
        }];
    }else{
        // 切换到 我的礼包
        [UIView animateWithDuration:0.2f animations:^{
            self.slideLineView.frame = CGRectMake(_myLibaoButton.frame.origin.x, 31, 80, 4);
        } completion:^(BOOL finished) {
            [_listLibaoButton setSelected:NO];
            [_myLibaoButton setSelected:YES];
        }];
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
	// 0==> 礼包 1==> 我的礼包 3==> 真实的scrollView
    if (scrollView.tag == 0) {
        [_listLibaoTableView.refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    }

}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
    if (scrollView.tag == 0) {
        [_listLibaoTableView.refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];

        //上拉加载更多
        //实现原理: scrollView.contentSize.height - scrollView.contentOffset.y = scrollView.height
        float sub = scrollView.contentSize.height - scrollView.contentOffset.y;
        if (scrollView.contentSize.height < scrollView.bounds.size.height) {
            if (scrollView.contentOffset.y > 30) {
                [_listLibaoTableView loadMoreAction];
            }
        } else
        {
            if (scrollView.bounds.size.height - sub > 30) {
                [_listLibaoTableView loadMoreAction];
            }
        }
    }
	
    
    
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView.tag == 0){
        // 礼包
        return [[[liBaoViewModel shareLibaoViewModel] getTableListLibaoDataOfType:@"list"] count];
    }else{
        // 我的礼包
        return [[[liBaoViewModel shareLibaoViewModel] getTableListLibaoDataOfType:@"my"] count];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 85.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    libaoTableCell * cell = [tableView dequeueReusableCellWithIdentifier:@"libaoCell"];
    
    if(cell == nil){
        cell = [[libaoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"libaoCell"];
        

    }
    

    
    if(tableView.tag == 0){
        // 礼包
        
        
        // 判断当前是否存在缓存数据
        if([[liBaoViewModel shareLibaoViewModel] checkDataWithType:@"list"]){
            // 获取对应行的数据
            NSDictionary * data = [[[liBaoViewModel shareLibaoViewModel] getTableListLibaoDataOfType:@"list"] objectAtIndex:indexPath.row];

            [cell renderCellWithData:data andType:@"list"];
            
            [cell.libaoActionButton addTarget:self action:@selector(handlePressEventForButtonInList:) forControlEvents:UIControlEventTouchUpInside];
                        
        }else{
            return cell;
        }

        
    }else{
        // 我的礼包
        [cell.libaoActionButton setTitle:@"复制兑换码" forState:UIControlStateNormal];
        
        // 判断当前是否存在缓存数据
        if([[liBaoViewModel shareLibaoViewModel] checkDataWithType:@"my"]){
            // 获取对应行的数据
            NSDictionary * data = [[[liBaoViewModel shareLibaoViewModel] getTableListLibaoDataOfType:@"my"] objectAtIndex:indexPath.row];
            
            [cell renderCellWithData:data andType:@"my"];
            
            
            // 点击复制按钮，复制礼包码到剪贴板
            [cell.libaoActionButton addTarget:self action:@selector(handlePressEventForButtonInMy:) forControlEvents:UIControlEventTouchUpInside];
        }else{
            return cell;
        }
        
    }
    
    return cell;
}


- (void)handlePressEventForButtonInList:(UIButton *)sender
{

    NSDictionary * data = [[liBaoViewModel shareLibaoViewModel] getDataWithGiftId:[NSString stringWithFormat:@"%ld",(long)sender.tag] type:@"list"];
    

    detailView = [[liBaoDetailViewController alloc] initWithNibName:@"liBaoDetailViewController" bundle:nil];
    
    [self pushDetailViewWithData:data type:@"list"];


}

- (void)handlePressEventForButtonInMy:(UIButton *)sender
{
    // 防止多次频繁点击导致的崩溃
    if([sender.titleLabel.text isEqualToString:@"已复制"]){
        return;
    }
    
    
    NSDictionary * data = [[liBaoViewModel shareLibaoViewModel] getDataWithGiftId:[NSString stringWithFormat:@"%ld",(long)sender.tag] type:@"my"];
    
    NSString * giftCode = [data objectForKey:@"libaoKey"];
    
    [UIPasteboard generalPasteboard].string = giftCode;
    [sender setTitle:@"已复制" forState:UIControlStateNormal];
}

#pragma mark tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailView = [[liBaoDetailViewController alloc] initWithNibName:@"liBaoDetailViewController" bundle:nil];
    
    NSString * type;
    // 处理”我的礼包“，cell点击的时候，跳转到礼包详情页
    if (tableView.tag == 1) {
        type = @"my";
    }else{
        type = @"list";
    }
    
    NSDictionary * data = [[[liBaoViewModel shareLibaoViewModel] getTableListLibaoDataOfType:type] objectAtIndex:indexPath.row];
    
    [self pushDetailViewWithData:data type:type];
}


/**
 * @brief 推出detailView
 */
- (void) pushDetailViewWithData:(NSDictionary *)data type:(NSString *)type
{
    detailView.gameName = [data objectForKey:@"gameName"];
    detailView.gameIconUrl = [data objectForKey:@"gameIcon"];
    detailView.giftId = [data objectForKey:@"giftId"];
    detailView.giftName = [data objectForKey:@"libaoDescription"];
    detailView.restNum = [data objectForKey:@"libaoResidue"];
    detailView.totalNum = [data objectForKey:@"libaoTotal"];
    if([type isEqualToString:@"list"]){
        detailView.giftState = [data objectForKey:@"buttonState"];
    }else{
        detailView.giftState = @"1";
    }
    
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailView animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}


#pragma mark BaseTableViewDelegate
//下拉事件
- (void)pullDown:(BaseTableView *)tableView
{
    NSLog(@"下拉事件");
    isPullDown = YES;
    // 下拉刷新，当前页回到初始值 1
    currentPage = 1;
    [self loadData];
}
//上拉事件
- (void)pullUp:(BaseTableView *)tableView
{
    NSLog(@"上拉事件");
    isPullDown = NO;
    [self loadData];
}

-(void)loadData
{
    //ASIHTTPRequest * requestForInfo;
    // 从静态接口里面获取礼包的礼包名，游戏名，图标，五分钟更新一次的库存，giftId
    //requestForInfo = [DataService requestWithURL:[NSString stringWithFormat:@"http://www.7k7k.com/m-json/fahao/giftlist/pg/%d.html",currentPage] finishBlock:^(id result) {
   [DataService requestWithURL:[NSString stringWithFormat:@"http://www.7k7k.com/m-json/fahao/giftlist/pg/%d.html",currentPage] finishBlock:^(id result) {     
        res = [[liBaoViewModel shareLibaoViewModel] mappingRemoteListDataToLocal:result];
        
        if ([res count] < pageSize) {
            // 返回的数量小于pageSize的时候，表明再次下拉没有更多的了
            _listLibaoTableView.isMore = NO;
        }
        
        NSLog(@"MAPPING : %@",res);
        
        if (isPullDown) {
            // 下拉刷新，先清空所有的数据
            [[[liBaoViewModel shareLibaoViewModel] getTableListLibaoDataOfType:@"list"] removeAllObjects];
        }
        
        // 先更新一次，用静态数据，给用户一种快速响应了的感觉
        // 然后再继续获取较慢的动态接口，刷新内容
        [[liBaoViewModel shareLibaoViewModel] setTableListLibaoDataOfType:@"list" withArray:res];
        _listLibaoTableView.hidden = NO;
        [_listLibaoTableView reloadData];
        
        
        // 获取当前list页的所有giftId
        NSArray * arr = [[liBaoViewModel shareLibaoViewModel] getIdListWithType:@"list" orArray:res];
        
        // 用@","拼接数组为字符串
        NSString * param = [arr componentsJoinedByString:@","];
        //时间戳的值
        NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
        NSString * urlToGetRealData = [NSString stringWithFormat:@"http://api.m.7k7k.com/libao/fahao/getGifts.php?ids=%@&t=%@",param,timeSp];

        NSLog(@"urlToGetRealData: %@",urlToGetRealData);
        
        
        ASIHTTPRequest * request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlToGetRealData]];
        request.delegate  = self;
        
        [request startAsynchronous];
        

    }];

}








-(void)requestFinished:(ASIHTTPRequest *)request
{
    
    // Use when fetching text data
    
//    NSString *responseString = [request responseString];
    
    NSData *responseData = request.responseData;
    id result = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    [progressHud removeFromSuperview];
    
    if ([[NSString stringWithFormat:@"%@",[result objectForKey:@"status"]] isEqualToString:@"1"]) {
        
        NSArray * realNum = [result objectForKey:@"data"];
        
        // 当前页加一
        currentPage++;
        
        
        // 用真实数据 更新之前的静态数据
        [[liBaoViewModel shareLibaoViewModel]
         updateListWithRealData:realNum
         List:res];
        
        // 再次刷新tableView
        _listLibaoTableView.hidden = NO;
        [_listLibaoTableView reloadData];
        
        // 表明loading结束
        [_listLibaoTableView doneLoadingTableViewData];
    }
    
}



-(void)requestFailed:(ASIHTTPRequest *)request
{
    
//    NSError *error = [request error];
    [progressHud removeFromSuperview];
//    NSLog(@"哎呀！请求失败:%@", weakRequestForData.error);
    /*
    NSString * tmpstring = [NSString stringWithFormat:@"%@%@", AppNickname,@"，网络不给力呀!"];
    UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:nil message:tmpstring delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertview show];
     */
    [self.view showLoadingMeg:@"加载失败，网络异常" time:1];
}

@end
