//
//  liBaoDetailViewController.m
//  libao
//
//  Created by wangxing on 14-3-4.
//  Copyright (c) 2014年 wangxing. All rights reserved.
//

#import "liBaoDetailViewController.h"
#import "liBaoViewModel.h"
#import "DataService.h"
#import "AppDelegate_Def.h"
#import "NT_AppDetailViewController.h"
// shareSDK
//#import <ShareSDK/ShareSDK.h>

@interface liBaoDetailViewController ()
{

    NSString * giftKey;
//    NSString * appStoreId;
    // 表明当前的礼包状态 YES==>正在领取  NO==>已领取/未领取
    BOOL giftStatus;
    BOOL isLoadIcon;
    BOOL isLoadGiftDataFinish;
    // 下载用的id 奶糖的
    NSString * gameId;
    SKStoreProductViewController *storeProductVC;
}
@end

@implementation liBaoDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        giftStatus = NO;
        isLoadIcon = NO;
        isLoadGiftDataFinish = NO;
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
        self.uiViewBottomLine.frame = CGRectMake(0, 0, 320, 1);
    if (iPhone4) {
        if (IOS6) {
//            self.uiViewNav.frame = CGRectMake(0, 0, 320, 44);
//            self.scrollView.frame = CGRectMake(0, 44, 320, 352);
            self.uiViewBottom.frame = CGRectMake(0, 354, 320, 62);
            self.uiScrollViewWrap.frame = CGRectMake(0, 0, 320, 352);
            self.scrollView.frame = CGRectMake(0, 0, 320, 352);
        }else{
//            self.uiViewNav.frame = CGRectMake(0, 0, 320, 64);
//            self.scrollView.frame = CGRectMake(0, 64, 320, 352);
            self.uiViewBottom.frame = CGRectMake(0, 418, 320, 62);
        }
   
    }else{
        if(IOS6){
            
        }else{
            self.uiViewBottom.frame = CGRectMake(0, 506, 320, 62);
            self.uiScrollViewWrap.frame = CGRectMake(0, 0, 320, 506);
            self.scrollView.frame = CGRectMake(0, 0, 320, 506);
        }
    }
    
    UIEdgeInsets inset = UIEdgeInsetsMake(8, 8, 8, 8);
    UIImage * btnGreen = [UIImage imageNamed:@"btn-green-stretchable.png"];
    UIImage * btnGreenHover = [UIImage imageNamed:@"btn-green-hover-stretchable.png"];
    UIImage * btnBlue = [UIImage imageNamed:@"btn-blue-stretchable.png"];
    UIImage * btnBlueHover = [UIImage imageNamed:@"btn-blue-hover-stretchable.png"];
    UIImage * btnGreenStretchable = [btnGreen resizableImageWithCapInsets:inset];
    UIImage * btnGreenHoverStretchable = [btnGreenHover resizableImageWithCapInsets:inset];
    UIImage * btnBlueStretchable = [btnBlue resizableImageWithCapInsets:inset];
    UIImage * btnBlueHoverStretchable = [btnBlueHover resizableImageWithCapInsets:inset];
    [_btnTopGet setBackgroundImage:btnGreenStretchable forState:UIControlStateNormal];
    [_btnTopGet setBackgroundImage:btnGreenHoverStretchable forState:UIControlStateHighlighted];
    [_btnBottomGet setBackgroundImage:btnGreenStretchable forState:UIControlStateNormal];
    [_btnBottomGet setBackgroundImage:btnGreenHoverStretchable forState:UIControlStateHighlighted];
    [_btnDownloadGame setBackgroundImage:btnBlueStretchable forState:UIControlStateNormal];
    [_btnDownloadGame setBackgroundImage:btnBlueHoverStretchable forState:UIControlStateHighlighted];
    [_btnCopyKey setBackgroundImage:btnBlueStretchable forState:UIControlStateNormal];
    [_btnCopyKey setBackgroundImage:btnBlueHoverStretchable forState:UIControlStateHighlighted];
    
    

    
    // 计算scrollView的contentsize
    _scrollView.contentSize = CGSizeMake(320, self.uiViewGameInfoWrap.frame.size.height+self.webViewGameDescription.frame.size.height);
    
    // 如果外界传递了iconUrl过来，则不必等待接口返回之后再加载图片
    // 可以预先加载，同时表明图片已加载，防止接口返回之后再次加载
    if(self.gameIconUrl != nil){
        [self setImageURL:self.gameIconUrl];
        isLoadIcon  = YES;
    }

    [self renderGetBtnStyle];
}

- (void)viewDidLoad
{
//    NSLog(@"########### liBaoDetailViewController viewDidLoad");
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imageViewGameIcon = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"default-icon.png"]];
    self.imageViewGameIcon.frame = CGRectMake(10, 10, 65, 65);
    self.imageViewGameIcon.layer.cornerRadius = 15.0;
    self.imageViewGameIcon.layer.borderWidth = 0;
    self.imageViewGameIcon.layer.masksToBounds = YES;
    self.imageViewGameIcon.contentMode = UIViewContentModeScaleAspectFill;
    self.imageViewGameIcon.backgroundColor = [UIColor clearColor];
    [self.uiViewGameInfoWrap addSubview:self.imageViewGameIcon];
    
    self.webViewGameDescription.scrollView.bounces = NO;
    self.webViewGameDescription.delegate = self;
    [self.webViewGameDescription setScalesPageToFit:NO];
    
    UIButton * returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [returnBtn setImage:[UIImage imageNamed:@"top-back.png"] forState:UIControlStateNormal];
    [returnBtn setImage:[UIImage imageNamed:@"top-back-hover.png"] forState:UIControlStateHighlighted];
    returnBtn.frame = CGRectMake(0, 0, 44, 44);
    [returnBtn addTarget:self action:@selector(navLeftBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * returnBar = [[UIBarButtonItem alloc] initWithCustomView:returnBtn];
    self.navigationItem.leftBarButtonItem = returnBar;
    
    
    UIButton * shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"btn-share.png"] forState:UIControlStateNormal];
    shareBtn.frame = CGRectMake(self.view.frame.size.width - 70, 0, 50, 20);
    [shareBtn addTarget:self action:@selector(navRightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * shareBar = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItem = shareBar;
    // 设定nav
//    UIBarButtonItem * leftBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-nav-back.png"] style:UIBarButtonItemStyleDone target:self action:@selector(navLeftBtnPressed)];
//    UIBarButtonItem * rightBar = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn-share.png"] style:UIBarButtonItemStylePlain target:self action:@selector(navRightBtnPressed)];
    
//    [self.navigationItem setLeftBarButtonItem:leftBar animated:YES];
//    [self.navigationItem setRightBarButtonItem:rightBar animated:YES];

    self.labelGameName.text = self.gameName ? self.gameName : @"";
    self.labelGiftName.text = self.giftName ? self.giftName : @"";
    
    
    
    // 如果调用者没有传递库存信息，则调用接口获取最新的数据显示
    if (self.restNum == nil) {
        [DataService requestWithURL:[NSString stringWithFormat:@"http://api.m.7k7k.com/libao/fahao/getGifts.php?ids=%@",self.giftId] finishBlock:^(id result) {
            
            if ([[NSString stringWithFormat:@"%@",[result objectForKey:@"status"]] isEqualToString:@"1"]) {
                NSDictionary * num = [[result objectForKey:@"data"] objectAtIndex:0];
                
                // 更新库存和总数
                _restNum = [num objectForKey:@"rest"];
                _totalNum = [num objectForKey:@"total"];
                
                
                [self renderRestAndTotal];
//                self.labelGiftInfo.attributedText = [self makeStringForRest];
                
                
                
                // 库存数量为空
                // 改变按钮颜色为灰色
                // 不可点击按钮
                
                NSArray * myLibaoIdList = [[liBaoViewModel shareLibaoViewModel] getIdListWithType:@"my" orArray:[[NSMutableArray alloc] initWithCapacity:0]];
                
                if ([myLibaoIdList containsObject:self.giftId]) {
                    _giftState = @"1";
                }else{
                    if ([num objectForKey:@"rest"] == 0) {
                        _giftState = @"2";
                    }else{
                        _giftState = @"0";
                    }
                }
                
                [self renderGetBtnStyle];
                
            }
        }];
    }else{
        [self renderRestAndTotal];
//        self.labelGiftInfo.attributedText = [self makeStringForRest];
    }
    
    
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.font = [UIFont boldSystemFontOfSize:20];
    titleLable.textColor = [UIColor whiteColor];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.text = @"礼包详情";
    titleLable.textAlignment = TEXT_ALIGN_CENTER;
    [titleLable sizeToFit];
    self.navigationItem.titleView = titleLable;


    // 获取数据
    [self getLiBaoDetailWithGiftId:self.giftId];
    
    
    storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    
    // 友盟统计-礼包-礼包详情-展示量
    umengLogGiftDetailShow++;
    
//    NSLog(@"scroll view's frame, height: %f, width: %f, x: %f, y: %f",_uiScrollViewWrap.frame.size.height,_uiScrollViewWrap.frame.size.width,_uiScrollViewWrap.frame.origin.x,_uiScrollViewWrap.frame.origin.y);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getKey:(id)sender {
    
    // 已领取 则按钮点击无响应
    if ([self.btnTopGet.titleLabel.text isEqualToString:@"已领取"]) {
        return;
    }
    
    // 防止连续点击导致的连续请求
    if (giftStatus == YES) {
        return;
    }
    
    // 记录状态表明不可点击
    if (![_giftState isEqualToString:@"0"]) {
        return;
    }
    
    giftStatus = YES;
    
    NSString * url = [NSString stringWithFormat:@"http://api.m.7k7k.com/libao/fahao/getCode.php?giftId=%@",_giftId];
    
    // 友盟统计-礼包-礼包详情-领取
    umengLogGiftDetailGet++;
    
    
    [DataService requestWithURL:url finishBlock:^(id result) {
        
        giftStatus = NO;
        
        if ([[result objectForKey:@"status"] intValue] == 1) {
            // 领取礼包成功
//            NSLog(@"领取成功，礼包码是：%@",[result objectForKey:@"code"]);
            
            ////////////////////
            // UI 改变
            ////////////////////
            
            self.labelLibaoCode.text = [result objectForKey:@"code"];
            // 更新领取按钮的状态
            _giftState = @"1";
            [self renderGetBtnStyle];
            // 当前页，剩余数量减一
            _restNum = [NSString stringWithFormat:@"%d", [_restNum intValue]-1];
            [self renderRestAndTotal];
//            self.labelGiftInfo.attributedText = [self makeStringForRest];
            
            ////////////////////
            // 更新list数据
            ////////////////////

            id obj3;
            obj3 = [[liBaoViewModel shareLibaoViewModel] getDataWithGiftId:_giftId type:@"list"];
            
            // 如果在当前列表中找到对应的数据项，就需要更新List
            if (obj3 != nil) {
                
                NSMutableDictionary * obj  = obj3;
                
                int residue = [[obj objectForKey:@"libaoResidue"] intValue] -1;
                // 更新剩余数量
                [obj setObject:[NSString stringWithFormat:@"%d",residue] forKey:@"libaoResidue"];
                // 更新按钮状态为 1 ==> 已领取
                [obj setObject:@"1" forKey:@"buttonState"];
                // 更新按钮文本为已领取
                [obj setObject:@"已领取" forKey:@"buttonWord"];
                
                
            }
            

            
            ////////////////////
            // 更新my数据
            ////////////////////
            
            NSMutableArray * myData = [[liBaoViewModel shareLibaoViewModel] getTableListLibaoDataOfType:@"my"];
            [myData addObject:@{
                                @"gameName":self.gameName,
                                @"giftId":_giftId,
                                @"appId":_appId,
                                @"gameIcon":self.gameIconUrl,
                                @"libaoDescription":self.giftName,
                                @"libaoKey":[result objectForKey:@"code"]
                                }];
            
            ////////////////////
            // 更新plist
            ////////////////////
            
            [liBaoViewModel setPlistLibaoDataOfType:@"my" withArray:myData];
            
            giftKey = [result objectForKey:@"code"];
            
            ////////////////////
            // 动画展示礼包码和复制按钮
            ////////////////////
            
            
            [UIView animateWithDuration:0.5f animations:^{
                
                // webView向下移动uiViewGetSuccess的高度，使得uiViewGetSuccess可见
                CGRect frame = self.webViewGameDescription.frame;
                self.webViewGameDescription.frame = CGRectMake(frame.origin.x, frame.origin.y+self.uiViewGetSuccess.frame.size.height+10, frame.size.width, frame.size.height);
                
            } completion:^(BOOL finished) {
                
                // 更新scrollView的contentSize
                CGSize size = _scrollView.contentSize;
                _scrollView.contentSize = CGSizeMake(size.width,size.height+self.uiViewGetSuccess.frame.size.height+10);
                
            }];
            
            
            // 友盟统计-礼包-礼包详情-领取成功
            umengLogGiftDetailGetSuccess++;
            
        }else{
            // 没的领了
            
            ////////////////////
            // UI改变
            ////////////////////
            
            _restNum = @"0";
            [self renderRestAndTotal];
//            self.labelGiftInfo.attributedText = [self makeStringForRest];
            
            // 重新渲染领取按钮的样式
            _giftState = @"2";
            [self renderGetBtnStyle];
            
            
            
            ////////////////////
            // 更新list
            ////////////////////
            
            id obj3;
            obj3 = [[liBaoViewModel shareLibaoViewModel] getDataWithGiftId:_giftId type:@"list"];
            
            // 如果在当前列表中找到对应的数据项，就需要更新List
            if (obj3 != nil) {
                NSMutableDictionary * obj  = obj3;
                [obj  setObject:@"0" forKey:@"libaoResidue"];
                [obj  setObject:@"2" forKey:@"buttonState"];
            }
            
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"来晚了！" message:@"礼包已经被领光了！！" delegate:self cancelButtonTitle:@"好吧" otherButtonTitles:nil];
            
            [alert show];
            
//            NSLog(@"没的领了");
        }
    }];
}

- (IBAction)copyKey:(id)sender {
    // 防止多次频繁点击导致的崩溃
    if([self.btnCopyKey.titleLabel.text isEqualToString:@"复制成功"]){
        return;
    }
    
    [UIPasteboard generalPasteboard].string = giftKey;
    [self.btnCopyKey setTitle:@"复制成功" forState:UIControlStateNormal];
}

- (IBAction)downloadGame:(id)sender {
    //    [self.delegate presentToItunes:_appsDetail.apple_id itunesButton:btn];
    
    if(gameId == nil){
        return;
    }
    else
    {
        //这里是游戏id  gameId
        NT_AppDetailViewController *detailController = [[NT_AppDetailViewController alloc] init];
        detailController.hidesBottomBarWhenPushed = YES;
        detailController.appID = [gameId integerValue];
        //[detailController getData:[gameId integerValue]];
        [self.navigationController pushViewController:detailController animated:YES];
        self.hidesBottomBarWhenPushed = YES;
    }
    /*
    if (isLoadGiftDataFinish == NO) {
        return;
    }
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
        
        [self openAppWithIdentifier:self.appId];
        
    }else{
        
        [self outerOpenAppWithIdentifier:self.appId goAppStore:sender];
        
    }
     */
}

//itunes下载
- (void)openAppWithIdentifier:(NSString *)appId {
    
    //    __block typeof(self) this = self;
    //    __block SKStoreProductViewController * storeProductVC = [[SKStoreProductViewController alloc] init];
    //    storeProductVC.delegate = this;
    //
    //    NSDictionary * dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    //    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
    //        if (result) {
    //            [this presentViewController:storeProductVC animated:YES completion:nil];
    //        }
    //        NSLog(@"%@",error);
    //    }];
    
    
    
    
    
    
//    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenLoading:)];
    
    [self presentViewController:storeProductVC animated:YES completion:nil];
    
    //    NSString *str = [NSString stringWithFormat:@"http://itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",appId];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8",appId]]];
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
            viewController.navigationController.view.top = 20;
            viewController.view.height = [NTAppDelegate shareNTAppDelegate].window.height - 20;
            /*
             [NTAppDelegate shareNTAppDelegate].mainController.navigationController.view.top = 20;
             [NTAppDelegate shareNTAppDelegate].mainController.navigationController.view.height = [NTAppDelegate shareNTAppDelegate].window.height - 20;
             */
        }
    }];
}



- (void)getLiBaoDetailWithGiftId:(NSString *)gift_id
{
    NSString * url = [NSString stringWithFormat:@"http://www.7k7k.com/m-json/fahao/giftbody/pg/%@.html",gift_id];
    [DataService requestWithURL:url finishBlock:^(id result) {
        NSDictionary * data = [[result objectForKey:@"main"] objectAtIndex:0];
        
        isLoadGiftDataFinish = YES;
        
        self.labelGameName.text = [data objectForKey:@"gameName"];
        self.labelSupportedTime.text = [data objectForKey:@"useTime"];
        self.labelSupportedPlatform.text = [data objectForKey:@"useVersion"];
        
        
        
        self.appId = [data objectForKey:@"appId"];
        self.gameName = [data objectForKey:@"gameName"];
        self.giftName = [data objectForKey:@"giftName"];
        self.gameIconUrl = [data objectForKey:@"icon"];
        gameId = [data objectForKey:@"gameId"];
        
        
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
            NSDictionary *dict = [NSDictionary dictionaryWithObject:self.appId forKey:SKStoreProductParameterITunesItemIdentifier];
            [storeProductVC loadProductWithParameters:dict completionBlock:nil];

        }
        
        
        // 加载图片，如果需要
        if(isLoadIcon == NO){
            self.gameIconUrl = [data objectForKey:@"icon"];
            [self setImageURL:self.gameIconUrl];
        }
        
        
        // 获取当前应用的根目录
        NSString *path = [[NSBundle mainBundle] bundlePath];
        NSURL *baseURL = [NSURL fileURLWithPath:path];
        
        // 通过baseURL的方式加载的HTML
        // 可以在HTML内通过相对目录的方式加载js,css,img等文件
        [self.webViewGameDescription loadHTMLString:[data objectForKey:@"content"] baseURL:baseURL];

        
//        NSLog(@"######### the result is %@",result);

    }];
}

#pragma mark UIWebView delegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"web view did finish load");
    
    // 更新webView的尺寸，使得其和webView里面的内容的高度一致
    CGRect frame = webView.frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    frame.size.height = frame.size.height+30;
    webView.frame = frame;

//    NSString *output = [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].offsetHeight;"];
//    NSLog(@"height: %@", output);
//
    
//    CGRect frame = webView.frame;
//    
//    frame.size.height = 1;
//    
//    webView.frame = frame;
//    
//    [webView sizeToFit];
    
    NSLog(@"webView's height is: %f",webView.frame.size.height);
    
    // 更新scrollView的contentSize
    _scrollView.contentSize = CGSizeMake(320, self.uiViewGameInfoWrap.frame.size.height+webView.frame.size.height);
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    // superView不存在的时候，取消正在下载的图片
    if (!newSuperview) {
        [self.imageViewGameIcon cancelImageLoad];
    }
}
- (void)setImageURL:(NSString *)imageURL
{
    NSLog(@"%@",imageURL);
    self.imageViewGameIcon.imageURL = [NSURL URLWithString:imageURL];
}

- (void)setImageURL:(NSString *)imageURL strTemp:(NSString *)temp
{
    [self.imageViewGameIcon imageUrl:[NSURL URLWithString:imageURL] tempSTR:temp];
}

/**
 * @brief 把领取按钮变成灰色
 */
- (void)renderGetBtnToGray
{
    UIEdgeInsets inset = UIEdgeInsetsMake(8, 8, 8, 8);
    UIImage * btnGray = [UIImage imageNamed:@"btn-gray-stretchable.png"];
    UIImage * btnGrayHover = [UIImage imageNamed:@"btn-gray-hover-stretchable.png"];
    UIImage * btnGrayStretchable = [btnGray resizableImageWithCapInsets:inset];
    UIImage * btnGrayHoverStretchable = [btnGrayHover resizableImageWithCapInsets:inset];
    [_btnTopGet setBackgroundImage:btnGrayStretchable forState:UIControlStateNormal];
    [_btnTopGet setBackgroundImage:btnGrayHoverStretchable forState:UIControlStateHighlighted];
    [_btnBottomGet setBackgroundImage:btnGrayStretchable forState:UIControlStateNormal];
    [_btnBottomGet setBackgroundImage:btnGrayHoverStretchable forState:UIControlStateHighlighted];
}

/**
 * @brief 返回按钮被点击
 */
- (void)navLeftBtnPressed
{
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 * @brief 分享按钮被点击
 */
- (void)navRightBtnPressed
{/*
    id forActionSheet;
    
    if(iPad || iPad4){
        //创建弹出菜单容器
        id<ISSContainer> container = [ShareSDK container];
        [container setIPadContainerWithView:self.uiScrollViewWrap arrowDirect:UIPopoverArrowDirectionUp];
        
        forActionSheet = container;
        
    }else{
        forActionSheet = nil;
    }
    
    id<ISSContent> publishContent = [ShareSDK content:[NSString stringWithFormat:@"7K7K游戏正在发放“%@-%@”，快来下载APP领取。https://itunes.apple.com/cn/app/id838133287?mt=8",self.gameName,self.giftName]
                                       defaultContent:@"好应用，东花园出品"
                                                image:[ShareSDK imageWithUrl:self.gameIconUrl]
                                                title:@"7K7K游戏礼包"
                                                  url:@"http://www.7kapp.cn/"
                                          description:@"7K7K游戏礼包"
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
                            }
     ];*/
}


/**
 * @brief 生成渲染库存数量的字符串
 */
/*
- (NSMutableAttributedString *)makeStringForRest
{
    // 渲染库存数和总数
    NSString * originInfo = [NSString stringWithFormat:@"库存：%@/%@",_restNum,_totalNum];
    NSRange range = NSMakeRange(3,originInfo.length - 3);
    UIColor * blue = [UIColor colorWithRed:30.0f/250.0 green:181.0f/250.0 blue:247.0f/250.0 alpha:1];
    
    NSMutableAttributedString * info = [[NSMutableAttributedString alloc] initWithString:originInfo];
    [info addAttribute:NSForegroundColorAttributeName value:blue range:range];
    
    return info;
}
*/
// 渲染库存数和总数
- (void)renderRestAndTotal{
    
    self.labelGiftRest.text = [NSString stringWithFormat:@"%@", _restNum];
    [self.labelGiftRest sizeToFit];
    self.labelGiftTotal.text = [NSString stringWithFormat:@"/%@", _totalNum];
    [self.labelGiftTotal sizeToFit];
    
    CGRect restFrame = self.labelGiftRest.frame;
    CGRect totalFrame = self.labelGiftTotal.frame;
    totalFrame.origin.x = restFrame.origin.x + restFrame.size.width;
    self.labelGiftTotal.frame = totalFrame;
}

/**
 * @brief 渲染领取按钮的样式
 */
- (void)renderGetBtnStyle
{
    
    if (_giftState) {
        
        if ([_giftState isEqualToString:@"1"]) {
            // 已领取
            
            [self.btnTopGet setTitle:@"已领取" forState:UIControlStateNormal];
            [self.btnBottomGet setTitle:@"已领取" forState:UIControlStateNormal];
            [self renderGetBtnToGray];
        }else if([_giftState isEqualToString:@"2"]){
            // 库存为0
            
            [self renderGetBtnToGray];
        }
    }else{
        // 判断是否在“myList”中
        NSMutableArray * emptyArr = [[NSMutableArray alloc] initWithCapacity:0];
        if([[[liBaoViewModel shareLibaoViewModel] getIdListWithType:@"my" orArray:emptyArr] containsObject:_giftId]){
            [self.btnTopGet setTitle:@"已领取" forState:UIControlStateNormal];
            [self.btnBottomGet setTitle:@"已领取" forState:UIControlStateNormal];
            [self renderGetBtnToGray];
            _giftState = @"1";
        }
    }
}

@end
