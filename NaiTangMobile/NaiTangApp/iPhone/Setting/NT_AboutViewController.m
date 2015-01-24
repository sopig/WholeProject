//
//  NT_AboutViewController.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-29.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_AboutViewController.h"
#import "NT_WebViewController.h"
#import "NT_MacroDefine.h"

@interface NT_AboutViewController ()

@end

@implementation NT_AboutViewController

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
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = @"关于我们";
    titleLable.textAlignment = TEXT_ALIGN_CENTER;
    [titleLable sizeToFit];
    self.navigationItem.titleView = titleLable;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //返回按钮
    UIButton *leftBt = [UIButton buttonWithFrame:CGRectMake(0, 0, 44, 44) image:[UIImage imageNamed:@"top-back.png"] target:self action:@selector(gotoBack)];
    [leftBt setImage:[UIImage imageNamed:@"top-back-hover.png"] forState:UIControlStateHighlighted];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:leftBt];
    
    if (isIOS7)
    {
        //设置ios7导航栏两边间距，和ios6以下两边间距一致
        UIBarButtonItem *spaceBar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
        spaceBar.width = -10;
        self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:spaceBar,backItem, nil];
    }
    else
    {
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
    if (isIOS7)
    {
        self.aboutView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    }
    else
    {
        self.aboutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    }
    [self.view addSubview:self.aboutView];
    
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-137)/2, 56, 137, 137)];
    logoImageView.image = [UIImage imageNamed:@"about-logo.png"];
    [self.aboutView addSubview:logoImageView];
    
    UILabel *logoLabel = [[UILabel alloc] initWithFrame:CGRectMake(logoImageView.left+15, logoImageView.bottom + 12, 124, 30)];
    logoLabel.textColor = Text_Color_Setting_Gray;
    logoLabel.font = [UIFont systemFontOfSize:24];
    logoLabel.text = @"奶糖游戏";
    [self.aboutView addSubview:logoLabel];
    
    //版本
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    CGSize size = CGSizeMake(SCREEN_WIDTH - 60, 18);
    CGSize maxSize = [appVersion sizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:size lineBreakMode:LINE_BREAK_WORD_WRAP];
    
    self.versionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.versionButton.frame = CGRectMake(logoLabel.right-20, logoLabel.top , maxSize.width, 18);
    [self.versionButton setBackgroundImage:[UIImage imageNamed:@"version.png"] forState:UIControlStateNormal];
    [self.versionButton setBackgroundImage:[UIImage imageNamed:@"version.png"] forState:UIControlStateHighlighted];
    [self.versionButton setTitle:appVersion forState:UIControlStateNormal];
    [self.versionButton setTitleColor:[UIColor colorWithHex:@"#ffffff"] forState:UIControlStateNormal];
    [self.versionButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [self.aboutView addSubview:self.versionButton];
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(logoLabel.left+8, logoLabel.bottom, 200, 20)];
    infoLabel.textColor = Text_Color_Setting_Light_Gray;
    infoLabel.font = [UIFont systemFontOfSize:12];
    infoLabel.text = @"不越狱，免费装";
    [self.aboutView addSubview:infoLabel];
    
    UILabel *wapLabel = [[UILabel alloc] initWithFrame:CGRectMake(87, infoLabel.bottom+15, 40, 20)];
    wapLabel.text = @"官网:";
    wapLabel.font = [UIFont systemFontOfSize:12];
    wapLabel.textColor = Text_Color_Setting_Light_Gray;
    [self.aboutView addSubview:wapLabel];
    
    UILabel *wapLink = [[UILabel alloc] initWithFrame:CGRectMake(wapLabel.right, wapLabel.top, 200, wapLabel.height)];
    wapLink.textColor = [UIColor colorWithHex:@"#60b5fd"];
    wapLink.font = [UIFont systemFontOfSize:12];
    wapLink.text = @"http://www.naitang.com";
    wapLink.userInteractionEnabled = YES;
    UITapGestureRecognizer *wapLinkTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wapButtonPressed:)];
    [wapLink addGestureRecognizer:wapLinkTap];
    [self.aboutView addSubview:wapLink];
    
    
    UILabel *weiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(87, wapLabel.bottom+5, 40, 20)];
    weiboLabel.text = @"微博:";
    weiboLabel.font = [UIFont systemFontOfSize:12];
    weiboLabel.textColor = Text_Color_Setting_Light_Gray;
    [self.aboutView addSubview:weiboLabel];
    
    UILabel *weiboLink = [[UILabel alloc] initWithFrame:CGRectMake(weiboLabel.right, weiboLabel.top, 200, weiboLabel.height)];
    weiboLink.textColor = [UIColor colorWithHex:@"#60b5fd"];
    weiboLink.font = [UIFont systemFontOfSize:12];
    weiboLink.text = @"http://weibo.com/naitanggame";
    weiboLink.userInteractionEnabled = YES;
    UITapGestureRecognizer *weiboLinkTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(wapButtonPressed:)];
    [weiboLink addGestureRecognizer:weiboLinkTap];
    [self.aboutView addSubview:weiboLink];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(102, self.aboutView.bottom-40, 200, 20)];
    bottomLabel.textColor = Text_Color_Setting_Light_Gray;
    bottomLabel.text = @"7K7K.com旗下产品";
    bottomLabel.font = [UIFont systemFontOfSize:12];
    [self.aboutView addSubview:bottomLabel];
    /*
    self.weiboButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.weiboButton.frame = CGRectMake(45, infoLabel.bottom + 55, 230, 40);
    [self.weiboButton setBackgroundImage:[[UIImage imageNamed:@"btn-about.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    [self.weiboButton setBackgroundImage:[UIImage imageNamed:@"btn-selected.png"] forState:UIControlStateHighlighted];
    [self.weiboButton setTitle:@"奶糖游戏官方微博" forState:UIControlStateNormal];
    [self.weiboButton setTitleColor:[UIColor colorWithHex:@"#505a5f"] forState:UIControlStateNormal];
    [self.weiboButton addTarget:self action:@selector(weiboButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.aboutView addSubview:self.weiboButton];
    
    self.wapButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.wapButton.frame = CGRectMake(45, self.weiboButton.bottom + 20, 230, 40);
    [self.wapButton setBackgroundImage:[[UIImage imageNamed:@"btn-about.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
     [self.wapButton setBackgroundImage:[UIImage imageNamed:@"btn-selected.png"] forState:UIControlStateHighlighted];
    [self.wapButton setTitle:@"奶糖游戏官方网站" forState:UIControlStateNormal];
    [self.wapButton setTitleColor:[UIColor colorWithHex:@"#505a5f"] forState:UIControlStateNormal];
    [self.wapButton addTarget:self action:@selector(wapButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.aboutView addSubview:self.wapButton];
     */
}

//微博
- (void)weiboButtonPressed:(id)sender
{
    NT_WebViewController *webController = [[NT_WebViewController alloc] init];
    webController.webTitle = @"微博";
    [self.navigationController pushViewController:webController animated:YES];
}

//官网
- (void)wapButtonPressed:(id)sender
{
    NT_WebViewController *webController = [[NT_WebViewController alloc] init];
    webController.webTitle = @"官网";
    [self.navigationController pushViewController:webController animated:YES];

}

- (void)gotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clear
{
    self.versionButton = nil;
    self.weiboButton = nil;
    self.wapButton = nil;
    self.aboutView = nil;
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
