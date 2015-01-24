//
//  CommentsViewController.m
//  NetDemo
//
//  Created by 海锋 周 on 12-6-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommentsViewController.h"
#import "LoginViewController.h"
#import "QiuShi.h"

#define FShareBtn       101
#define FBackBtn        102
#define FAddComments    103

@interface CommentsViewController () <ASIHTTPRequestDelegate,
UITableViewDataSource,
UITableViewDelegate
>
-(void) GetErr:(ASIHTTPRequest *)request;
-(void) GetResult:(ASIHTTPRequest *)request;
-(void) BtnClicked:(id)sender;
- (void)loadData;
@property (nonatomic) BOOL refreshing;
@end

@implementation CommentsViewController
@synthesize refreshing = _refreshing;
@synthesize asiRequest,list;
@synthesize qs;
@synthesize tableView,commentView;
- (void)dealloc{
    
    [tableView release];
    [commentView release];
    [asiRequest release];
    [qs release];
    [super dealloc];
}

- (void)loadView
{
    // If you create your views manually, you MUST override this method and use it to create your views.
    // If you use Interface Builder to create your views, then you must NOT override this method.
    [super loadView];
  
}

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"main_background.png"]]];
    list = [[NSMutableArray alloc]init];
    
    //添加headbar 
    UIImage *headimage = [UIImage imageNamed:@"head_background.png"];
    UIImageView *headView = [[UIImageView alloc]initWithImage:headimage];
    [headView setFrame:CGRectMake(0, 0, 320, 44)];
    [self.view addSubview:headView];
    [headView release];
    [headimage release];
    
    //返回按钮
    UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbtn setFrame:CGRectMake(10,6,32,32)];
    [backbtn setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
     [backbtn setTag:FBackBtn];
    [self.view addSubview:backbtn];
    
    //分享按钮
    UIButton *sharebtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [sharebtn setFrame:CGRectMake(280,6,32,32)];
    [sharebtn setImage:[UIImage imageNamed:@"icon_share.png"] forState:UIControlStateNormal];
    [sharebtn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [sharebtn setTag:FShareBtn];
    [self.view addSubview:sharebtn];
    
    //糗事列表
    tableView = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0, kDeviceWidth, [self getTheHeight]-60)];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    [commentView addSubview:tableView];
    
    //评论列表
    commentView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44, kDeviceWidth, KDeviceHeight-60)];
    commentView.backgroundColor = [UIColor clearColor];
    commentView.separatorStyle = UITableViewCellSeparatorStyleNone;
    commentView.dataSource = self;
    commentView.delegate = self;
    commentView.scrollEnabled = YES;
    [self.view addSubview:commentView];
    commentView.tableHeaderView = tableView;
    asiRequest = nil;
    
    //添加footimage 
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
    UIImage *footbg= [UIImage imageNamed:@"block_center_background.png"];
    UIImageView *footbgView = [[UIImageView alloc]initWithImage:footbg];
    [footbgView setFrame:CGRectMake(0, 0, 320, 25)];
    [footView addSubview:footbgView];
    [footbgView release];
    [footbg release];
    
    UIImage *footimage = [UIImage imageNamed:@"block_foot_background.png"];
    UIImageView *footimageView = [[UIImageView alloc]initWithImage:footimage];
    [footimageView setFrame:CGRectMake(0, 25, 320, 15)];
    [footView addSubview:footimageView];
    //添加评论
    UIButton *addcomments = [UIButton buttonWithType:UIButtonTypeCustom];
    [addcomments setFrame:CGRectMake(20,2,280,28)];
    [addcomments setBackgroundImage:[[UIImage imageNamed:@"button_vote.png"]stretchableImageWithLeftCapWidth:5 topCapHeight:5] forState:UIControlStateNormal];
    [addcomments setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [addcomments.titleLabel setFont: [UIFont fontWithName:@"Arial" size:14]];
    [addcomments setTitle:@"点击发表评论" forState:UIControlStateNormal];
    [addcomments addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [addcomments setTag:FAddComments];
    [footView addSubview:addcomments];
    
    commentView.tableFooterView = footView;
    [commentView addSubview:footView];
   
    [footimageView release];
    [footimage release];
    [footView release];

    //添加UILabel
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 6, 180, 32)];
    [label setBackgroundColor:[UIColor clearColor]];
    [label setFont: [UIFont fontWithName:@"Arial" size:18]];
    [label setTextColor:[UIColor whiteColor]];
    [label setText:[NSString stringWithFormat:@"糗事#%@",qs.qiushiID]];
    [self.view addSubview:label];
    [label release];
    [self loadData];
}

-(void) BtnClicked:(id)sender
{

    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case FBackBtn:  //返回首页
        {
            //指定动画的持续时间
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationDuration:1];  
            [UIView setAnimationCurve:UIViewAnimationCurveLinear];
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view.superview cache:YES];  
            [UIView commitAnimations];
            [self.view removeFromSuperview];
        }
            break;
        case FAddComments://添加评论
        {
            
        }
            break;
        case FShareBtn://分享到..
        {
            SHSShareViewController *shareView = [[SHSShareViewController alloc]initWithRootViewController:self];
            [shareView.view setFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight)];
            [self.view addSubview:shareView.view];
            shareView.sharedtitle = @"糗事百科-生活百态尽在Qiushibaike...";
            shareView.sharedText = qs.content; 
            shareView.sharedURL =@"http://www.qiushibaike.com";
            shareView.sharedImageURL = qs.imageURL;
            [shareView showShareKitView];
        }
            break;
        default:
            break;
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
    [list removeAllObjects];
    NSURL *url = [NSURL URLWithString:CommentsURLString(qs.qiushiID)];
    asiRequest = [ASIHTTPRequest requestWithURL:url];
    [asiRequest setDelegate:self];
    [asiRequest setDidFinishSelector:@selector(GetResult:)];
    [asiRequest setDidFailSelector:@selector(GetErr:)];
    [asiRequest startAsynchronous];
    
    
}

-(void) GetErr:(ASIHTTPRequest *)request
{
    
}

-(void) GetResult:(ASIHTTPRequest *)request
{
    NSData *data =[request responseData];
    NSDictionary *dictionary = [[CJSONDeserializer deserializer] deserializeAsDictionary:data error:nil];
    if ([dictionary objectForKey:@"items"]) {
		NSArray *array = [NSArray arrayWithArray:[dictionary objectForKey:@"items"]];
        for (NSDictionary *qiushi in array) {
            Comments *cm = [[[Comments alloc]initWithDictionary:qiushi]autorelease];
            [list addObject:cm];
        }
    }    
    [commentView reloadData];
}
#pragma mark - TableView*

- (NSInteger)tableView:(UITableView *)tableview numberOfRowsInSection:(NSInteger)section{
    if (tableview == tableView) {
        return 1;
    }else {
        return [list count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableview == tableView) {
  
        static NSString *identifier = @"_QiShiCELL";
        ContentCell *cell =(ContentCell *) [tableview dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil){
            //设置cell 样式
            cell = [[[ContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.txtContent.NumberOfLines = 0;
        }
    
        //设置内容
        cell.txtContent.text = qs.content;
        //设置图片
        if (qs.imageURL!=nil && qs.imageURL!= @"") {
            cell.imgUrl = qs.imageURL;
            cell.imgMidUrl = qs.imageMidURL;
          //  cell.imgPhoto.hidden = NO;
        }else
        {
            cell.imgUrl = @"";
             cell.imgMidUrl = @"";
          //  cell.imgPhoto.hidden = YES;
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
        [cell.goodbtn setEnabled:NO];
        [cell.badbtn setTitle:[NSString stringWithFormat:@"%d",qs.downCount] forState:UIControlStateNormal];
        [cell.badbtn setEnabled:NO];
        [cell.commentsbtn setTitle:[NSString stringWithFormat:@"%d",qs.commentsCount] forState:UIControlStateNormal];
        [cell.commentsbtn setEnabled:NO];
        //自适应函数
        [cell resizeTheHeight];
        return cell;
    }else {
            static NSString *identifier1 = @"_CommentCell";
            CommentsCell *cell =(CommentsCell *) [tableview dequeueReusableCellWithIdentifier:identifier1];
            if (cell == nil){
                //设置cell 样式
                cell = [[[CommentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1] autorelease];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor = [UIColor clearColor];
                cell.contentView.backgroundColor = [UIColor clearColor];
                cell.txtContent.NumberOfLines = 0;
            }
            Comments *cm = [list objectAtIndex:indexPath.row];
            //设置内容
            cell.txtContent.text = cm.content;
            cell.txtfloor.text = [NSString stringWithFormat:@"%d",cm.floor];
            //设置用户名
            if (cm.anchor!=nil && cm.anchor!= @"") 
            {
                cell.txtAnchor.text = cm.anchor;
            }else
            {
                cell.txtAnchor.text = @"匿名";
            }
            //自适应函数
            [cell resizeTheHeight];
            return cell;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableview heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == tableview) {
        CGFloat height = [self getTheHeight];
        [tableView setFrame:CGRectMake(0, 0, kDeviceWidth, height)];
        return  height;
    }else {
        return [self getTheCellHeight:indexPath.row];
    }
  
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

}


-(CGFloat) getTheHeight
{
    CGFloat contentWidth = 280;  
    // 设置字体
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];  
    // 显示的内容 
    NSString *content = qs.content;
    // 计算出长宽
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 220) lineBreakMode:UILineBreakModeTailTruncation]; 
    CGFloat height;
    if (qs.imageURL==nil) {
        height = size.height+214;
    }else
    {
        height = size.height+294;
    }
    // 返回需要的高度  
    return height; 
}

-(CGFloat) getTheCellHeight:(int) row
{
     CGFloat contentWidth = 280;  
    // 设置字体
    UIFont *font = [UIFont fontWithName:@"Arial" size:14];  
    
    Comments *cm = [self.list objectAtIndex:row];
    // 显示的内容 
    NSString *content = cm.content;
    // 计算出长宽
    CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth, 220) lineBreakMode:UILineBreakModeTailTruncation]; 
    CGFloat height = size.height+30;
    // 返回需要的高度  
    return height; 
}
@end