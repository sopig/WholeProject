#import "NT_AdView.h"
#import "NT_HttpEngine.h"
#import "NT_AdInfo.h"
#import "NT_AppDetailInfo.h"
#import "NT_AppDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "AdModel.h"
#import "ContentViewController.h"
#import "DataService.h"

@implementation NT_AdView
@synthesize switchTableView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.dataArray = [NSMutableArray array];
        self.imgArr = [NSArray arrayWithObjects:@"iad0.jpg",@"iad1.jpg",@"iad2.jpg", nil];
        
        switchTableView = [SwitchTableView shareSwitchTableViewData];
        [self initXLCycleScrollView];
         [self structAdData];
        
        if([switchTableView isConnectionAvailable] == YES) {
            [self performSelector:@selector(requestAdData) withObject:nil afterDelay:3.0];
        }
        /*
        
        _backImageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _backImageview.image = [[UIImage imageNamed:@"white-bg.png"] stretchableImageWithLeftCapWidth:4 topCapHeight:4];
        _backImageview.userInteractionEnabled = YES;
        _backImageview.backgroundColor = [UIColor whiteColor];
        [self addSubview:_backImageview];
        
        NSArray *focusDataArray = [NT_HttpEngine sharedNT_HttpEngine].focusDataArray;
        if (focusDataArray.count) {
            [self reloadContent];
        }
        else
        {
            [self refreshData];
        }
        
         */
    }
    return self;
}

- (void)structAdData
{
    //加载轮播图片
    NSData * slideImageURLSData = [[NSUserDefaults standardUserDefaults] objectForKey:@"slideImageURLS"];
    if (slideImageURLSData) {
        self.dataArray = [NSMutableArray array];
        NSArray * events = [NSKeyedUnarchiver unarchiveObjectWithData:slideImageURLSData];
        for (NSDictionary * dic in events){
            [self.dataArray addObject:[[AdModel alloc] initWithDictionary:dic]];
        }
    }
}

-(void)requestAdData
{
    [DataService requestWithURL:@"http://www.7k7k.com/m-json/appad/3_1.html" finishBlock:^(id result) {
        NSArray * events = [[result objectForKey:@"data"] objectForKey:@"list"];
        self.dataArray = [NSMutableArray array];
        for (NSDictionary * dic in events){
            [self.dataArray addObject:[[AdModel alloc] initWithDictionary:dic]];
            
        }
        if (self.dataArray.count == 3) {
            [[NSUserDefaults standardUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:events] forKey:@"slideImageURLS"];
        }
        [self initXLCycleScrollView];
    }];
}


- (void)refreshData
{
    [[NT_HttpEngine sharedNT_HttpEngine] getFocusOnCompletionHandler:^(MKNetworkOperation *completedOperation) {
        [self reloadContent];
    } errorHandler:nil];
}

- (void)reloadContent
{
    NSArray *focusDataArray = [NT_HttpEngine sharedNT_HttpEngine].focusDataArray;
    self.dataArray = [focusDataArray mutableCopy];
    //循环播放广告
    [self initXLCycleScrollView];
}

- (void)initXLCycleScrollView
{
    //循环广告视图
    _scrollView = [[XLCycleScrollView alloc] initWithFrame:CGRectMake(0 ,0, SCREEN_WIDTH, 100)];
    _scrollView.userInteractionEnabled = YES;
    _scrollView.backgroundColor = [UIColor clearColor];
    _scrollView.delegate = self;
    _scrollView.datasource = self;
    [self addSubview:_scrollView];
    //[_backImageview addSubview:_scrollView];
}

#pragma mark --
#pragma mark -- XLCycleScrollViewDatasource

- (NSInteger)numberOfPages
{
    //return self.dataArray.count;
    return 3;
}

- (UIView *)pageAtIndex:(NSInteger)index
{
    if (self.dataArray.count == 3)
    {
        AdModel *model = [self.dataArray objectAtIndex:index];
        _imgView = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.height)];
//        _imgView.placeholderImage = [UIImage imageNamed:@"land-default.png"];
        _imgView.userInteractionEnabled = YES;
        [_imgView setImageURL:[NSURL URLWithString:model.img]];
        
        
        /**
         阴影
         */
        //UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, _imgView.frame.size.height - 40, self.frame.size.width,_imgView.frame.size.height - 30)];
        UIView * v = [[UIView alloc] initWithFrame:CGRectMake(0, _imgView.frame.size.height - 24, self.frame.size.width,24)];
        v.backgroundColor = [UIColor blackColor];
        v.userInteractionEnabled = YES;
        v.alpha = 0.5;
        [_imgView addSubview:v];
        /**
         类型
         */
        //self.titleType = [[UILabel alloc] initWithFrame:CGRectMake(0, _imgView.frame.size.height - 40,self.frame.size.width - 260, 40)];
        self.titleType = [[UILabel alloc] initWithFrame:CGRectMake(6, _imgView.frame.size.height - 21,36, 18)];
        self.titleType.backgroundColor = [UIColor colorWithRed:1/255.0 green:203/255.0 blue:0/255.0 alpha:1.0];
        self.titleType.text = model.title;
        self.titleType.textAlignment = TEXT_ALIGN_CENTER;
        self.titleType.textColor = [UIColor whiteColor];
        self.titleType.font = [UIFont boldSystemFontOfSize:14];
        [_imgView addSubview:self.titleType];
        /**
         标题
         */
        self.textLable = [[UILabel alloc] initWithFrame:CGRectMake(self.titleType.frame.size.width+10, self.titleType.frame.origin.y, 200, self.titleType.frame.size.height)];
        self.textLable.backgroundColor = [UIColor clearColor];
        self.textLable.text = model.desc;
        self.textLable.textColor = [UIColor whiteColor];
        self.textLable.textAlignment = TEXT_ALIGN_LEFT;
        self.textLable.font = [UIFont boldSystemFontOfSize:14];
        [_imgView addSubview:self.textLable];
        
        return _imgView;

    }
    else
    {
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.scrollView.height)];
        imgV.userInteractionEnabled = YES;
        imgV.image = [UIImage imageNamed:self.imgArr[index]];
        return imgV;
    }
    /*
    if (self.dataArray.count>0)
    {
        NT_AdDetailInfo *focus = [NT_AdDetailInfo infoDetialFromDic:self.dataArray[index]];
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.scrollView.height)];
        imgV.userInteractionEnabled = YES;
        [imgV setImageWithURL:[NSURL URLWithString:focus.pic] placeholderImage:[UIImage imageNamed:@"default-icon.png"]];
        return imgV;
    }
    return nil;
     */
}

#pragma mark -- XLCycleScrollViewDelegate
- (void)didClickPage:(XLCycleScrollView *)csView atIndex:(NSInteger)index
{
    if (self.dataArray.count == 0)
    {
        return;
    }
    AdModel *model =  [self.dataArray objectAtIndex:index];
    if ([model.type isEqualToString:@"1"])
    {
        ContentViewController * contentVC = [[ContentViewController alloc] init];
        contentVC.webUrl = model.url;
        contentVC.titleText = model.title;
        [self.viewController.navigationController pushViewController:contentVC animated:YES];
    }else if ([model.type isEqualToString:@"2"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
    }else{
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0) {
            [self openAppWithIdentifier:model.url];
        }else
        {
            [self outerOpenAppWithIdentifier:model.url];
        }
    }
    
    /*
    if ([self.dataArray[index][@"linkType"] intValue] == 1) {
        NT_AppDetailInfo *info = [[NT_AppDetailInfo alloc] init];
        info.appId = self.dataArray[index][@"linkId"];
        
        NT_AppDetailViewController *detailController = [[NT_AppDetailViewController alloc] init];
        detailController.infosDetail = info;
        if (self.delegate&&[self.delegate respondsToSelector:@selector(toDetailViewControllerDelegate:)])
        {
            detailController.hidesBottomBarWhenPushed = YES;
            [self.delegate toDetailViewControllerDelegate:detailController];
            detailController.hidesBottomBarWhenPushed = NO;
        }
        
    }else{
     
         YSCategoryDetailViewController *controller = [[YSCategoryDetailViewController alloc] init];
         controller.categoryId = [dataArray[index][@"linkId"] intValue];
         controller.categoryName = dataArray[index][@"title"];
         controller.categoryType = @"YSCategoryUserView";
         [[AppDelegate shareAppDelegate].menuController.navigationController pushViewController:controller animated:YES];
     
    }
    */
}

- (void)openAppWithIdentifier:(NSString *)appId {
    SKStoreProductViewController * storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    
    NSDictionary * dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
        if (result) {
            [self.viewController.navigationController presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
}

//
// app外打开appstore（适用于<ios6.0）
//
- (void)outerOpenAppWithIdentifier:(NSString *)appId {
    NSString * urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8", appId];
    NSURL * url = [NSURL URLWithString:urlStr];
    [[UIApplication sharedApplication] openURL:url];
}
- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController {
    [viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview)
    {
        [_imgView cancelImageLoad];
    }
}
- (void)setImageURL:(NSString *)imageURL
{
    _imgView.imageURL = [NSURL URLWithString:imageURL];
}
//无网络请求调用
- (void)setImageURL:(NSString *)imageURL strTemp:(NSString *)temp
{
    NSURL * url = [NSURL URLWithString:imageURL];
    [_imgView imageUrl:url tempSTR:temp];
}



- (void)dealloc
{
    self.scrollView = nil;
    self.dataArray = nil;
    self.imageArray = nil;
}

@end