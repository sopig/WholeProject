//
//  OtherContentViewController.m
//  DDMenuController
//
//  Created by 王明远 on 13-12-9.
//
//

#import "OtherContentViewController.h"
#import "ContentViewController.h"
#import "LevelModel.h"
#import "AppDelegate_Def.h"
#import "NTAppDelegate.h"
#import "DataService.h"
#import "Reachability.h"
//#import "UIViewController+MMDrawerController.h"
//#import "WebIsCollectedDBManager.h"
//#import "Entity.h"
//#import <ShareSDK/ShareSDK.h>
#import "NT_WifiBrowseImage.h"

@interface OtherContentViewController ()
{
    CGPoint gestureBeginPoint;
    CGPoint gestureEndPoint;
}
@end

@implementation OtherContentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.ContentArr = [NSMutableArray array];
        
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:242/255.0 blue:237/255.0 alpha:1.0];
    
    [self initButtonLable];
    
    
    
    NSString * str = self.webUrl;
    
    //从指定的字符串开始到尾部
    NSString * strURL = [str substringFromIndex:38];

    [self loadData:strURL];
    
    
    [self initPanGesture];
    
    [self initViews];
    
    [self initCollectBtn];
    
    [self initShareBtn];
    
}

- (void)initButtonLable{
    if (IOS7) {
        UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        [customLab setTextColor:[UIColor whiteColor]];
        customLab.textAlignment = NSTextAlignmentCenter;
        [customLab setText:_titleText];
        [customLab setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
        self.navigationItem.titleView = customLab;
    } else
    {
        self.title = self.titleText;
    }
    
    UIButton * returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn setImage:[UIImage imageNamed:@"返回.png"] forState:UIControlStateNormal];
    returnBtn.frame = CGRectMake(10, 0, 25, 25);
    [returnBtn addTarget:self action:@selector(returnAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * returnBar = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItem = returnBar;
    
    UILabel * l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:l];
    
}

- (void)initCollectBtn
{
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(self.view.frame.size.width - 35, 0, 20, 20);
    [rightBtn setImage:[UIImage imageNamed:@"btn-50-more2"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * returnBar = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = returnBar;
    
    
    _topView = [[UIView alloc]init];
    if (IOS7) {
        _topView.frame = CGRectMake(self.view.frame.size.width - 110, 64, 100, 80);
    }else
    {
        _topView.frame = CGRectMake(self.view.frame.size.width - 110, 0, 100, 80);
        
    }
    
    _topView.backgroundColor = [UIColor colorWithRed:245/255.0 green:242/255.0 blue:237/255.0 alpha:1.0];
    _topView.hidden = YES;
    CGPathRef shadow = CGPathCreateWithRect(CGRectInset(_topView.bounds, 2, 2.5), NULL);
    [_topView.layer setShadowPath:shadow];
    [_topView.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [_topView.layer setShadowOpacity:1];
    [_topView.layer setShadowRadius:2];
    [_topView.layer setShadowOffset:CGSizeMake(0, .5)];
    _topView.layer.masksToBounds = NO;
    [self.view addSubview:_topView];
    
    //释放
    CGPathRelease(shadow);
    
    
    _rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 60, 40)];
    _rightLabel.text = @"收藏";
    _rightLabel.backgroundColor = [UIColor clearColor];
    _rightLabel.userInteractionEnabled = YES;
    _rightLabel.font = [UIFont systemFontOfSize:12.0];
    [_topView addSubview:_rightLabel];
    
    _leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
    _leftImgView.image = [UIImage imageNamed:@"place-hold-img-youxijietu.png"];
    _leftImgView.contentMode = UIViewContentModeScaleToFill;
    _leftImgView.userInteractionEnabled = YES;
    [_topView addSubview:_leftImgView];
    
    
    collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.backgroundColor = [UIColor clearColor];
    collectBtn.showsTouchWhenHighlighted = YES;
    collectBtn.frame = CGRectMake(0, 0, 100, 40);
    [collectBtn addTarget:self action:@selector(collectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:collectBtn];
    
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, _topView.frame.size.width, .3)];
    lineView.backgroundColor = [UIColor grayColor];
    [_topView addSubview:lineView];
    
}


- (void)initShareBtn
{
    UILabel *shareLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 41, 60, 40)];
    shareLabel.text = @"分享";
    shareLabel.backgroundColor = [UIColor clearColor];
    shareLabel.userInteractionEnabled = YES;
    shareLabel.font = [UIFont systemFontOfSize:12.0];
    [_topView addSubview:shareLabel];
    
    UIImageView *shareImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 51, 20, 20)];
    shareImgView.image = [UIImage imageNamed:@"btn-content-30-share.png"];
    shareImgView.userInteractionEnabled = YES;
    [_topView addSubview:shareImgView];
    
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.backgroundColor = [UIColor clearColor];
    shareBtn.showsTouchWhenHighlighted = YES;
    shareBtn.frame = CGRectMake(0, 41, 100, 40);
    [shareBtn addTarget:self action:@selector(shareButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview:shareBtn];
}


/**
 * 点击webView的时候隐藏右上角下拉弹窗
 */
- (void)onWebViewTapCloseDropDown
{
    _topView.hidden = YES;
}

- (void)shareButtonAction:(UIButton *)btn
{
    if (_topView.hidden == NO) {
        _topView.hidden = YES;
    } else
    {
        _topView.hidden = NO;
    }
    
    id forActionSheet;
    
    if(iPad || iPad4){
        //创建弹出菜单容器
//        id<ISSContainer> container = [ShareSDK container];
//        [container setIPadContainerWithView:_topView arrowDirect:UIPopoverArrowDirectionUp];
//        forActionSheet = container;
        
    }else{
        forActionSheet = nil;
    }
    
    [_jsBridge send:@"getContAndFirstImage" responseCallback:^(id responseData) {
        /*
        NSString * title = [responseData objectForKey:@"title"];
        //NSString * image = [responseData objectForKey:@"image"];
        NSString * content = [responseData objectForKey:@"content"];
        NSString * shareContent = @"《";
        
        shareContent = [shareContent stringByAppendingString:title];
        shareContent = [shareContent stringByAppendingString:@"》"];
        shareContent = [shareContent stringByAppendingString:content];

        id<ISSContent> publishContent = [ShareSDK content:shareContent
                                           defaultContent:@"好应用，东花园出品"
                                                    image:[ShareSDK imageWithUrl:image]
                                                    title:title
                                                      url:@"http://www.7kapp.cn/"
                                              description:title
                                                mediaType:SSPublishContentMediaTypeNews];
        
        
        [ShareSDK showShareActionSheet:forActionSheet
                             shareList:nil
                               content:publishContent
                         statusBarTips:YES
                           authOptions:nil
                          shareOptions:nil
                                result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                    if (state == SSResponseStateSuccess)
                                    {
                                        NSLog(@"分享成功");
                                    }
                                    else if (state == SSResponseStateFail)
                                    {
                                        NSString * errorMsg = [NSString stringWithFormat:@"错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]];
                                        
                                        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"分享失败" message:errorMsg delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil];
                                        
                                        [alert show];
                                    }
                                }];
 */
    }];
    
    
    
    
}


- (void)rightAction
{
    if (_topView.hidden == NO) {
        _topView.hidden = YES;
    } else
    {
        _topView.hidden = NO;
    }
}


- (void)initViews
{
    
#pragma 分享
    
    if (IOS7) {
        if (iPhone5){
            self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x , self.view.frame.origin.y+64, self.view.frame.size.width, self.view.frame.size.height-64)];
        }else
        {
            self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+64, self.view.frame.size.width, self.view.frame.size.height-64)];
        }
    } else
    {
        self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, 0, self.view.frame.size.width, self.view.frame.size.height - 44)];
        
    }
    [_webView.layer setMasksToBounds:YES];
    [self.view addSubview:_webView];
    
    self.webView.backgroundColor = [UIColor colorWithRed:245/255.0 green:242/255.0 blue:237/255.0 alpha:1.0];
    
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onWebViewTapCloseDropDown)];
    tap.numberOfTapsRequired = 1;
    tap.delegate = self;
    
    [_webView addGestureRecognizer:tap];
}

- (void)initPanGesture
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(contentReturnAction:)];
    [self.view addGestureRecognizer:pan];
}

- (void)initMBProgressHUD
{
    progressHUD = [[MBProgressHUD alloc] initWithWindow:self.appDelegate.window];
    [self.appDelegate.window addSubview:progressHUD];
    progressHUD.frame = self.view.bounds;
    progressHUD.labelText = @"加载中.....";
    progressHUD.mode = MBProgressHUDModeIndeterminate;
    progressHUD.minSize = CGSizeMake(100, 100);
    [progressHUD show:YES];//开始显示
}
/*
- (void)collectButtonAction:(UIButton *)button
{
    if ([_rightLabel.text isEqualToString:@"收藏"]) {
        _rightLabel.text = @"取消收藏";
        _leftImgView.image = [UIImage imageNamed:@"btn-30-favminu.png"];
    } else
    {
        _rightLabel.text = @"收藏";
        _leftImgView.image = [UIImage imageNamed:@"btn-30-favadd.png"];
    }
    
    button.selected = !button.selected;
    _levelModel.isCollected = button.selected;
    
    
    if (_levelModel.isCollected) {
        Entity *collectWeb = [WebIsCollectedDBManager createWeb];
        collectWeb.url = self.webUrl;
        collectWeb.titile = _levelModel.titleText;
        collectWeb.titleText = self.titleText;
        
        [WebIsCollectedDBManager insertWeb:collectWeb];
        NSString * tmpstring = [NSString stringWithFormat:@"%@%@", AppNickname,@"，收藏成功了!"];
        [self showHUD:tmpstring withHiddenDelay:1.0];
        _topView.hidden = YES;
        
    } else
    {
        NSArray *webArr = [WebIsCollectedDBManager findUserByWebID:self.webUrl];
        Entity *collectWeb = [webArr lastObject];
        
        [WebIsCollectedDBManager deleteWeb:collectWeb];
        NSString * tmpstring = [NSString stringWithFormat:@"%@%@", AppNickname,@"，取消收藏了!"];
        [self showHUD:tmpstring withHiddenDelay:1.0];
        _topView.hidden = YES;
        
    }
}*/
- (BOOL)isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.7kapp.cn"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
    }
    return isExistenceNetwork;
}

- (void)progressHUDHidden
{
    [progressHUD removeFromSuperview];
    
}


- (void)loadData:(NSString *)urlString{
    if ([self isConnectionAvailable]) {
        [self initMBProgressHUD];
    }
    [DataService requestWithURL:urlString finishBlock:^(id result)  {
        NSArray * listevents = [result objectForKey:@"main"];
        for (NSDictionary * dic in listevents){
            self.levelModel = [[LevelModel alloc] initWithDictionary:dic];
            [self.ContentArr addObject:_levelModel];
        }
        
//        NSArray *webArray = [WebIsCollectedDBManager findUserByWebID:self.webUrl];
//        Entity *collectData = [webArray lastObject];
//        if (collectData != nil) {
//            _levelModel.isCollected = YES;
//        }
        if (result) {
            [self progressHUDHidden];
        }
        collectBtn.selected = _levelModel.isCollected;
        if (collectBtn.selected) {
            _rightLabel.text = @"取消收藏";
            _leftImgView.image = [UIImage imageNamed:@"btn-30-favminu"];
        }
        
        
        // 开启js和object-c交互的调试
//        [WebViewJavascriptBridge enableLogging];
        
        // init jsBridge with the webview
        self.jsBridge = [WebViewJavascriptBridge bridgeForWebView:_webView handler:^(id data, WVJBResponseCallback responseCallback) {
        }];
        
        
        // 初始化图片播放器
        self.mediaFocusController = [[EGImageBrowser alloc] init];
        self.mediaFocusController.delegate = self;
        
        
        // js传递过来，需要进行全屏展示的图片的地址
        [_jsBridge registerHandler:@"requestListAndIndexOfImg" handler:^(id data, WVJBResponseCallback responseCallback) {
            
            // convert string to url
            NSURL * url = [NSURL URLWithString:[[data objectForKey:@"src"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            
            [_mediaFocusController showImageWithURL:url];
        }];
        
        // js传递过来的外链地址需要通过浏览器打开的网址
        [_jsBridge registerHandler:@"openUrlByBrowser" handler:^(id data, WVJBResponseCallback responseCallback) {
            
            NSURL * url = [NSURL URLWithString:[[data objectForKey:@"url"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            [[UIApplication sharedApplication] openURL:url];
            
        }];
        
        // js传递过来的内链地址需要通过OtherContentViewController打开
        [_jsBridge registerHandler:@"openArticleWithUrl" handler:^(id data, WVJBResponseCallback responseCallback) {
            
            NSString * url = [data objectForKey:@"url"];
            NSString * title = [data objectForKey:@"title"];
            
            ContentViewController * other = [[ContentViewController alloc]init];
            other.webUrl = url;
            other.titleText = title;
            [self.navigationController pushViewController:other animated:YES];
            
        }];
        
        // add a `<h1>` tag for the html content
//        NSString * articleTitle = [NSString stringWithFormat:@"<h1>%@</h1>", _levelModel.titleText];
//        _levelModel.bodyStr = [articleTitle stringByAppendingString: _levelModel.bodyStr];
        
        NSString * netStatus = @"";
        NSString * placeHoldImgSrc = @"";
        
        //设置里，wifi加载图片，获取wifi的状态和图片路径
        NT_WifiBrowseImage *wifiImage = [[NT_WifiBrowseImage alloc] init];
        NSDictionary *dic = [wifiImage getWifiStatusAndUrlString];
        
        if (dic)
        {
            netStatus = [dic objectForKey:KNetStatus];
            placeHoldImgSrc = [dic objectForKey:KPlaceHoldImgSrc];
        }
        
        /*
        // 检测当前是否WIFI网络环境
        BOOL isConnectedProperly =[[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==ReachableViaWiFi;
        //是否是2G/3G网络
        BOOL isWWAN = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==ReachableViaWWAN;
        //无网络
        BOOL notReach = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable;
        NSString * netStatus;
        NSString * placeHoldImgSrc;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        //若关闭"只在wifi下加载图片"，则3G、wifi都可以加载图片
        if ([[userDefaults objectForKey:@"BigPicLoad"] isEqualToString:@"close"])
        {
            //3g或wifif连接
            if (!notReach)
            {
                netStatus = @"true";
                placeHoldImgSrc = @"vertical-default.png";
            }
        }
        else
        {
            //打开只在wifi下加载图片
            //若使用的是3G，就不加载图片
            if (isWWAN)
            {
                netStatus = @"false";
                placeHoldImgSrc = @"vertical-default.png";
            }
            else if (isConnectedProperly)
            {
                //若使用的是wifi，则加载图片
                netStatus = @"true";
                placeHoldImgSrc = @"vertical-default.png";
            }
            
        }
         */
        /*
        // 检测当前是否WIFI网络环境
        BOOL isConnectedProperly =[[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==ReachableViaWiFi;
        NSString * netStatus;
        NSString * placeHoldImgSrc;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        if(isConnectedProperly){
            netStatus = @"true";
            placeHoldImgSrc = @"loading.jpg";
            
            
        }else{
            netStatus = @"false";
            placeHoldImgSrc = @"click-2-load.jpg";
            if ([[userDefaults objectForKey:@"BigPicLoad"] isEqualToString:@"close"]) {
                netStatus = @"true";
                placeHoldImgSrc = @"loading.jpg";
            } else{
                netStatus = @"false";
                placeHoldImgSrc = @"click-2-load.jpg";
            }
            
        }
        */
        // 传递页面内容，WIFI网络环境，占位图片地址，到模板页
        [_jsBridge callHandler:@"getHtmlContent" data:@{@"content":_levelModel.bodyStr,@"articleTitle":_levelModel.titleText,@"netStatus":netStatus,@"src":placeHoldImgSrc}];
        
        
        
        // get the model which is a html file for the webView
        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
        NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
        
        // 获取当前应用的根目录
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        
        // 通过baseURL的方式加载的HTML
        // 可以在HTML内通过相对目录的方式加载js,css,img等文件
        [_webView loadHTMLString:htmlCont baseURL:baseURL];
        
        
    }];
    
    // 友盟统计：文章查看数量加1
//    umengLogLoadedArticleData++;
    
}

/**
 * @brief 在图片全屏展示之后，通知webView：webView里面的图片可以再次被点击
 */
- (void)EGImageBrowser_ImageDidAppear
{
    
    [_jsBridge send:@"enableImgClick"];
}

- (void)returnAction{
    [self.navigationController popViewControllerAnimated:YES];
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
- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
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
    hud.yOffset = self.view.frame.size.height/2 - 100;
    
    [hud showAnimated:YES whileExecutingBlock:^{
        sleep(delay);
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}


@end
