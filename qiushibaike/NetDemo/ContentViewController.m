//
//  ContentViewController.m
//  NetDemo
//
//  Created by  on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ContentViewController.h"
#import "PullingRefreshTableView.h"
#import "CommentsViewController.h"
#import "CJSONDeserializer.h"
#import "QiuShi.h"

@interface ContentViewController () <
PullingRefreshTableViewDelegate,ASIHTTPRequestDelegate,
UITableViewDataSource,
UITableViewDelegate
>
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
@property (retain,nonatomic) PullingRefreshTableView *tableView;
@property (retain,nonatomic) NSMutableArray *list;
@property (nonatomic) BOOL refreshing;
@property (assign,nonatomic) NSInteger page;
@end

@implementation ContentViewController
@synthesize tableView = _tableView;
@synthesize list = _list;
@synthesize refreshing = _refreshing;
@synthesize page = _page;
@synthesize asiRequest;
@synthesize Qiutype,QiuTime;



- (void)dealloc{
    [_list release];
    _list = nil;
    [self.tableView release];
    [super dealloc];
}

- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
    [super loadView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor clearColor]];
    _list = [[NSMutableArray alloc] init ];
    
    CGRect bounds = self.view.bounds;
    bounds.size.height -= 44.f*2;
    self.tableView = [[PullingRefreshTableView alloc] initWithFrame:bounds pullingDelegate:self];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    asiRequest = nil;
    
    if (self.page == 0) {
       [self.tableView launchRefreshing];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Your actions

- (void)loadData{
    
    self.page++;
    NSURL *url;
    switch (QiuTime) {
        case QiuShiTimeRandom:
            url = [NSURL URLWithString:LastestURLString(10,self.page)];
            break;
        case QiuShiTimeDay:
            url = [NSURL URLWithString:DayURLString(10,self.page)];
            break;
        case QiuShiTimeWeek:
            url = [NSURL URLWithString:WeakURlString(10,self.page)];
            break;
        case QiuShiTimeMonth:
            url = [NSURL URLWithString:MonthURLString(10,self.page)];
            break;
        default:
            break;
    }
    
    switch (Qiutype) {
        case QiuShiTypeTop:
            url = [NSURL URLWithString:SuggestURLString(10,self.page)];
            break;
        case QiuShiTypeNew:
            url = [NSURL URLWithString:LastestURLString(10,self.page)];
            break;
        case QiuShiTypePhoto:
            url = [NSURL URLWithString:ImageURLString(10,self.page)];
            break;
        default:
            break;
    }
    
    asiRequest = [ASIHTTPRequest requestWithURL:url];
    [asiRequest setDelegate:self];
    [asiRequest setDidFinishSelector:@selector(GetResult:)];
    [asiRequest setDidFailSelector:@selector(GetErr:)];
    [asiRequest startAsynchronous];
    
}

-(void) GetErr:(ASIHTTPRequest *)request
{
    self.refreshing = NO;
    [self.tableView tableViewDidFinishedLoading];
    [tooles MsgBox:@"连接网络失败，请检查是否开启移动数据"];
     
}

-(void) GetResult:(ASIHTTPRequest *)request
{
    if (self.refreshing) {
        self.page = 1;
        self.refreshing = NO;
        [self.list removeAllObjects];
    }
    NSData *data =[request responseData];
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:data error:nil];
    if ([dictionary objectForKey:@"items"]) {
		NSArray *array = [NSArray arrayWithArray:[dictionary objectForKey:@"items"]];
        for (NSDictionary *qiushi in array) {
            QiuShi *qs = [[[QiuShi alloc]initWithDictionary:qiushi]autorelease];
             [self.list addObject:qs];
        }
		
    }    
   
    if (self.page >=20) {
        [self.tableView tableViewDidFinishedLoadingWithMessage:@"下面没有了.."];
        self.tableView.reachedTheEnd  = YES;
    } else {        
        [self.tableView tableViewDidFinishedLoading];
        self.tableView.reachedTheEnd  = NO;
        [self.tableView reloadData];
    }
  
}
#pragma mark - TableView*

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Contentidentifier = @"_ContentCELL";
    ContentCell *cell = [tableView dequeueReusableCellWithIdentifier:Contentidentifier];
    if (cell == nil){
        //设置cell 样式
        cell = [[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Contentidentifier] ;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        [cell.txtContent setNumberOfLines:12];
    }
  
    QiuShi *qs = [self.list objectAtIndex:[indexPath row]];
    //设置内容
    cell.txtContent.text = qs.content;
    //设置图片
    if (qs.imageURL!=nil && qs.imageURL!= @"") {
         cell.imgUrl = qs.imageURL;
         cell.imgMidUrl = qs.imageMidURL;
       // cell.imgPhoto.hidden = NO;
    }else
    {
        cell.imgUrl = @"";
         cell.imgMidUrl = @"";
       // cell.imgPhoto.hidden = YES;
    }
    //设置用户名
    if (qs.anchor!=nil && qs.anchor!= @"") 
     {
         cell.txtAnchor.text = qs.anchor;
     }else
     {
         cell.txtAnchor.text = @"匿名";
     }
    //设置标签
    if (qs.tag!=nil && qs.tag!= @"") 
    {
        cell.txtTag.text = qs.tag;
    }else
    {
        cell.txtTag.text = @"";
    }
    //设置up ，down and commits
    [cell.goodbtn setTitle:[NSString stringWithFormat:@"%d",qs.upCount] forState:UIControlStateNormal];
    [cell.badbtn setTitle:[NSString stringWithFormat:@"%d",qs.downCount] forState:UIControlStateNormal];
    [cell.commentsbtn setTitle:[NSString stringWithFormat:@"%d",qs.commentsCount] forState:UIControlStateNormal];
    //自适应函数
    [cell resizeTheHeight];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getTheHeight:indexPath.row];
}

#pragma mark - PullingRefreshTableViewDelegate
- (void)pullingTableViewDidStartRefreshing:(PullingRefreshTableView *)tableView{
    self.refreshing = YES;
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];
}


- (void)pullingTableViewDidStartLoading:(PullingRefreshTableView *)tableView{
    [self performSelector:@selector(loadData) withObject:nil afterDelay:1.f];    
}

#pragma mark - Scroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.tableView tableViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.tableView tableViewDidEndDragging:scrollView];
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentsViewController *demoView=[[CommentsViewController alloc]initWithNibName:@"CommentsViewController" bundle:nil];
    demoView.qs = [self.list objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.view.superview addSubview:demoView.view];
    [UIView beginAnimations:nil context:nil];
    //指定动画的持续时间
    [UIView setAnimationDuration:1];  
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view.superview cache:YES];  
      
    [UIView commitAnimations];
}

#pragma mark - LoadPage
-(void) LoadPageOfQiushiType:(QiuShiType) type Time:(QiuShiTime) time
{
    self.Qiutype = type;
    self.QiuTime = time;
    self.page =0;
    [self.tableView launchRefreshing];

}


-(CGFloat) getTheHeight:(NSInteger)row
{
    CGFloat contentWidth = 280;  
    // 设置字体
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];  

    QiuShi *qs =[self.list objectAtIndex:row];  
    // 显示的内容 
    NSString *content = qs.content;
    // 计算出长宽
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 220) lineBreakMode:UILineBreakModeTailTruncation]; 
    CGFloat height;
    if (qs.imageURL==nil) {
       height = size.height+140;
    }else
    {
       height = size.height+220;
    }
    // 返回需要的高度  
    return height; 
}
@end