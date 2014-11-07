//
//  XiangQingViewController.m
//  libao
//
//  Created by 小远子 on 14-3-4.
//  Copyright (c) 2014年 wangxing. All rights reserved.
//

#import "XiangQingViewController.h"
#import "AppDelegate_Def.h"
#import "DataService.h"
#import "Utile.h"

#import "GuidesVideoModel.h"

#define url @"http://api.naitang.com/mobile/v1/k7mobile/arclistbytag/28_"
#define urlTail @"_1_10.html"

@interface XiangQingViewController ()
{
        CGPoint gestureBeginPoint;
        CGPoint gestureEndPoint;
}
@end

@implementation XiangQingViewController
@synthesize ziLiaoTableView;
@synthesize arrayData;
@synthesize requestNum;
@synthesize isPull;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        requestNum = 1;
        isPull = YES;
        arrayData = [NSMutableArray array];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //返回按钮
    UIButton * returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn setImage:[UIImage imageNamed:@"top-back.png"] forState:UIControlStateNormal];
    [returnBtn setImage:[UIImage imageNamed:@"top-back-hover.png"] forState:UIControlStateHighlighted];
    returnBtn.frame = CGRectMake(0, 0, 44, 44);
    [returnBtn addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem * returnBar = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];

    if (isIOS7)
    {
        //设置ios7导航栏两边间距，和ios6以下两边间距一致
        UIBarButtonItem *spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        spaceBar.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:spaceBar,returnBar, nil];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = returnBar;
    }

}

- (void)returnAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.navigationItem.title = self.title;
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = self.title;
    titleLable.textAlignment = TEXT_ALIGN_CENTER;
    [titleLable sizeToFit];
    self.navigationItem.titleView = titleLable;

    
    self.view.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    NSLog(@"%@",self.strID);
    [self loadData:[NSString stringWithFormat:@"%@%@%@",url,self.strID,urlTail]];
//    [self loadData:[NSString stringWithFormat:@"%@%@%@",url,@"0",urlTail]];
    
    CGRect ziLiaoTableViewFrame;
    
    if (IOS7) {
        
        /**
         ios7 新特性
         */
        UILabel * l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.view addSubview:l];
        /**
         
         */
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(contentReturnAction:)];
        [self.view addGestureRecognizer:pan];
        
        
        ziLiaoTableViewFrame = CGRectMake(self.view.frame.origin.x, 64, self.view.frame.size.width, self.view.frame.size.height - 24);
    }else{
        
        ziLiaoTableViewFrame = CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height - 0);
    }
    
    ziLiaoTableView = [[ZiLiaoTableView alloc] initWithFrame:ziLiaoTableViewFrame style:UITableViewStylePlain];
    ziLiaoTableView.refreshDelegate = self;
    ziLiaoTableView.titleText = @"攻略资料";
    ziLiaoTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:ziLiaoTableView];
//    [Utile setExtraCellLineHidden:ziLiaoTableView];

}

- (void)pullDown:(BaseTableView *)tableView
{
    isPull = YES;
    requestNum = 1;
    NSString *urlStr = nil;
    urlStr = [NSString stringWithFormat:@"%@%@%@",url,self.strID,urlTail];
    urlStr = [urlStr substringToIndex:(urlStr.length - 9)];
    NSString *htmlStr = @"_10.html";
    urlStr = [urlStr stringByAppendingFormat:@"%d%@", requestNum,htmlStr];
    [self loadData:urlStr];
}

- (void)pullUp:(BaseTableView *)tableView
{
    isPull = NO;
    NSString *urlStr = nil;
    urlStr = [NSString stringWithFormat:@"%@%@%@",url,self.strID,urlTail];
    urlStr = [urlStr substringToIndex:(urlStr.length - 9)];
    NSString *htmlStr = @"_10.html";
    urlStr = [urlStr stringByAppendingFormat:@"%d%@", requestNum,htmlStr];
    [self loadData:urlStr];
}



- (void)loadData:(NSString *)urlString
{
    NSLog(@"%@",urlString);
    NSMutableArray * XQarray = [NSMutableArray array];
    [DataService requestWithURL:urlString finishBlock:^(id result) {
        NSArray *listevents = [result objectForKey:@"data"];
        
        for (NSDictionary * dic in listevents){
            GuidesVideoModel * model = [[GuidesVideoModel alloc] initWithDictionary:dic];
            [XQarray addObject:model];
        }
        if (isPull)
        {
            [arrayData removeAllObjects];
        }
        [arrayData addObjectsFromArray:XQarray];
        ziLiaoTableView.data = arrayData;
        ziLiaoTableView.gameName = self.title;
        requestNum++;
        [ziLiaoTableView reloadData];
        
        
        if (listevents.count < 10) {
            ziLiaoTableView.isMore = NO;
            ziLiaoTableView.moreButton.hidden = YES;
            ziLiaoTableView.moreButton.enabled = NO;
        } else {
            ziLiaoTableView.isMore = YES;
            ziLiaoTableView.moreButton.hidden = NO;
            ziLiaoTableView.moreButton.enabled = YES;
        } if (ziLiaoTableView.requestType == Fans) {
            [ziLiaoTableView doneLoadingTableViewData];
        }
        
    }];
}

- (void)contentReturnAction:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        gestureBeginPoint = [gestureRecognizer locationInView:self.view];
    }
    else if (gestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        gestureEndPoint = [gestureRecognizer locationInView:self.view];
        if ((gestureEndPoint.x - gestureBeginPoint.x)> 0)
        {
            [self.navigationController popViewControllerAnimated:YES];
            gestureBeginPoint = CGPointZero;
            gestureEndPoint = CGPointZero;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
