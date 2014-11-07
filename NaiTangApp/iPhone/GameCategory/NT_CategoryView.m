//
//  NT_CategoryView.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_CategoryView.h"
#import "NT_MacroDefine.h"
#import "DataService.h"

@implementation NT_CategoryView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame linkId:(int)linkId linkType:(int)linkType isOnline:(BOOL)isOnline sortType:(SortType)sortType
{
    self.linkType = linkType;
    self.sortType = sortType;
    self.isOnlineGame = isOnline;
    self.linkId = linkId;
    self = [super initWithFrame:frame type:AppListTypeDevAppsList];
    if (self) {
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame categoryType:(NSString *)categoryType categoryId:(int)categoryId sortType:(SortType)sortType isOnlineGame:(BOOL)isOnline
{
    self.categoryId = categoryId;
    self.sortType = sortType;
    self.categoryType = categoryType;
    self.isOnlineGame = isOnline;
    self = [super initWithFrame:frame type:AppListTypeDevAppsList];
    if (self) {
        // Initialization code
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame categoryType:(NSString *)categoryType  categoryId:(int)categoryId isOnlineGame:(BOOL)isOnline
{
    return [self initWithFrame:frame categoryType:categoryType categoryId:categoryId sortType:SortTypeLatest isOnlineGame:isOnline];
}

- (void)getDataForPage:(int)page
{
    _isLoading = YES;
    /*
    MKNKResponseBlock respones = ^(MKNetworkOperation *completedOperation) {
        _isLoading = NO;
        [self stopLoadingMore];
        [self hideLoading];
        [self getDataFinishedWithDic:[completedOperation responseJSONRemoveNull] forPage:page];
        [self doneLoadingTableViewData];
    };
    MKNKResponseErrorBlock error = ^(MKNetworkOperation *completedOperation, NSError *error) {
        [self stopLoadingMore];
        _isLoading = NO;
        [self doneLoadingTableViewData];
        [self showLoadingMeg:@"网络异常" time:1];
    };
    */
    
    NSString *url = @"http://apitest.naitang.com/";
    //网游分类
    NSString *urlString = nil;
    if (self.isOnlineGame)
    {
        /*
        if (isIpad) {
            urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/netcat/gamelist_2_2_%d_%d_%d.html",self.categoryId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/netcat/gamelist_2_1_%d_%d_%d.html",self.categoryId,self.sortType,page];
        }
        else
        {
            urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/netcat/gamelist_1_1_%d_%d_%d.html",self.categoryId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/netcat/gamelist_1_1_%d_%d_%d.html",self.categoryId,self.sortType,page];
        }
*/
        //网游分类
        //[[NT_HttpEngine sharedNT_HttpEngine] getOnlineGameListWithId:self.categoryId categoryType:self.categoryType sortType:self.sortType page:page OnCompletionHander:respones errorHandler:error];
    }
    else
    {
        //分类列表
        if (self.linkType)
        {
            //分类-游戏类别-列表详情
            switch (self.linkType)
            {
                case 1:
                {
                    //categoryType = @"Game"; 1 游戏 Game
                    if (isIpad) {
                        urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/info/detail_2_2_%d.html",self.linkId] : [NSString stringWithFormat:@"mobile/v1/info/detail_2_1_%d.html",self.linkId];
                    }
                    else
                    {
                        urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/info/detail_1_1_%d.html",self.linkId] : [NSString stringWithFormat:@"mobile/v1/info/detail_1_1_%d.html",self.linkId];
                    }
                }
                    break;
                case 2:
                {
                    //categoryType = @"Album"; 2 合辑 Album
                    if (isIpad) {
                        urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/album/gamelist_2_2_%d_%d_%d.html",self.linkId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/album/gamelist_2_1_%d_%d_%d.html",self.linkId,self.sortType,page];
                    }
                    else
                    {
                        urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/album/gamelist_1_1_%d_%d_%d.html",self.linkId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/album/gamelist_1_1_%d_%d_%d.html",self.linkId,self.sortType,page];
                    }
                }
                    break;
                case 3:
                {
                    //categoryType = @"Special"; 3 专题 Special
                    if (isIpad) {
                        urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"special/id_2_2_%d.html",self.linkId] : [NSString stringWithFormat:@"special/id_2_1_%d.html",self.linkId];
                    }
                    else
                    {
                        urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"special/id_1_1_%d.html",self.linkId] : [NSString stringWithFormat:@"special/id_1_1_%d.html",self.linkId];
                    }
                }
                    break;
                case 4:
                {
                    //categoryType = @"Tag"; 4 标签 Tag
                    if (isIpad) {
                        urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/tag/gamelist_2_2_%d_%d_%d.html",self.linkId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/tag/gamelist_2_1_%d_%d_%d.html",self.linkId,self.sortType,page];
                    }
                    else
                    {
                        urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/tag/gamelist_1_1_%d_%d_%d.html",self.linkId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/tag/gamelist_1_1_%d_%d_%d.html",self.linkId,self.sortType,page];
                    }
                }
                    break;
                case 5:
                {
                    //categoryType = @"Category"; 5 分类 Category
                    if (isIpad) {
                        urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/category/list_2_2_%d_%d_%d.html",self.linkId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/category/list_2_1_%d_%d_%d.html",self.linkId,self.sortType,page];
                    }
                    else
                    {
                        urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/category/list_1_1_%d_%d_%d.html",self.linkId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/category/list_1_1_%d_%d_%d.html",self.linkId,self.sortType,page];
                    }
                    
                }
                    break;
                default:
                    break;
            }

            //[[NT_HttpEngine sharedNT_HttpEngine] getCategoryDetailInfoWithLinkType:self.linkType linkID:self.linkId sortType:self.sortType page:page OnCompletionHander:respones errorHandler:error];
        }
        else
        {
            //无限金币版
            //分类-游戏类别-列表详情
            if ([self.categoryType isEqualToString:@"BaseCategoryTableView"] || [self.categoryType isEqualToString:@"CategoryBaseTableView"])
            {
                if (isIpad) {
                    urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/category/list_2_2_%d_%d_%d.html",self.categoryId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/category/list_2_1_%d_%d_%d.html",self.categoryId,self.sortType,page];
                }
                else
                {
                    urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/category/list_1_1_%d_%d_%d.html",self.categoryId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/category/list_1_1_%d_%d_%d.html",self.categoryId,self.sortType,page];
                }
                
            }//分类-热门合集-列表详情
            else if ([self.categoryType isEqualToString:@"YSCategoryUserView"] || [self.categoryType isEqualToString:@"CategoryUseTableView"])
            {
                if (isIpad) {
                    urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/album/gamelist_2_2_%d_%d_%d.html",self.categoryId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/album/gamelist_2_1_%d_%d_%d.html",self.categoryId,self.sortType,page];
                }
                else
                {
                    urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/album/gamelist_1_1_%d_%d_%d.html",self.categoryId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/album/gamelist_1_1_%d_%d_%d.html",self.categoryId,self.sortType,page];
                }
                
            }//分类-热门推荐-列表详情
            else if ([self.categoryType isEqualToString:@"YSCategoryAppView"] || [self.categoryType isEqualToString:@"CategoryPadAppView"])
            {
                if (isIpad) {
                    urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/tag/gamelist_2_2_%d_%d_%d.html",self.categoryId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/tag/gamelist_2_1_%d_%d_%d.html",self.categoryId,self.sortType,page];
                }
                else
                {
                    urlString = [[UIDevice currentDevice] isJailbroken] ? [NSString stringWithFormat:@"mobile/v1/tag/gamelist_1_1_%d_%d_%d.html",self.categoryId,self.sortType,page] : [NSString stringWithFormat:@"mobile/v1/tag/gamelist_1_1_%d_%d_%d.html",self.categoryId,self.sortType,page];
                }
                
            }

            /*
            [[NT_HttpEngine sharedNT_HttpEngine] getCategoryListWithId:self.categoryId categoryType:self.categoryType
                                                              sortType:self.sortType
                                                                  page:page
                                                    OnCompletionHander:respones
                                                          errorHandler:error];
             */
        }
        
        urlString = [NSString stringWithFormat:@"%@%@",url,urlString];
        NSLog(@"%@",urlString);
        
        [DataService requestWithURL:urlString finishBlock:^(id result) {
            NSDictionary *dic = (NSDictionary *)result;
            _isLoading = NO;
            [self stopLoadingMore];
            [self hideLoading];
            [self getDataFinishedWithDic:dic forPage:page];
            [self doneLoadingTableViewData];

        } errorBlock:^(id result) {
            [self stopLoadingMore];
            _isLoading = NO;
            [self doneLoadingTableViewData];
            [self showLoadingMeg:@"网络异常" time:1];
        }];
        /*
        [DataService requestWithURL:urlString finishBlock:^(id result) {
            NSDictionary *dic = (NSDictionary *)result;
            _isLoading = NO;
            [self stopLoadingMore];
            [self hideLoading];
            [self getDataFinishedWithDic:dic forPage:page];
            [self doneLoadingTableViewData];
        }];
         */
    }
}

- (void)openAppWithIdentifier:(NSString *)appId {
    SKStoreProductViewController *storeProductVC = [[SKStoreProductViewController alloc] init];
    storeProductVC.delegate = self;
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:appId forKey:SKStoreProductParameterITunesItemIdentifier];
    [self showLoadingMeg:@"加载中.."];
    [self setLoadingUserInterfaceEnable:YES];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenLoading:)];
    [self addGestureRecognizer:tapGesture];
    [storeProductVC loadProductWithParameters:dict completionBlock:^(BOOL result, NSError *error) {
        if (tapGesture) {
            [self removeGestureRecognizer:tapGesture];
        }
        [self hideLoading];
        if (result) {
            [self.target presentViewController:storeProductVC animated:YES completion:nil];
        }
    }];
    //    NSString *str = [NSString stringWithFormat:@"http://itms-apps://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=%@",appId];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/us/app/id%@?mt=8",appId]]];
}

- (void)hiddenLoading:(UITapGestureRecognizer *)tap
{
    if (tap) {
        [self removeGestureRecognizer:tap];
    }
    [self hideLoading];
}

- (void)dealloc
{
    self.categoryId = 0;
    self.sortType = 0;
    self.target = nil;
    self.categoryType = nil;
}

@end
