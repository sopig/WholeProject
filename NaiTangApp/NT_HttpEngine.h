//
//  NT_HttpEngine.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  接口-请求url

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"

typedef enum {
    SortTypeLatest = 1,
    SortTypeHotest = 2,
    SortTypeScore = 3,
}SortType;


#define NETNOTWORKING @"NotReachable"
#define NETWORKVIAWIFI @"ReachableViaWiFi"
#define NETWORKVIA3G @"ReachableViaWWAN"


@interface NT_HttpEngine : MKNetworkEngine
{
    //判断网络是否连接
	Reachability* internetReach;
}
+ (NT_HttpEngine *)sharedNT_HttpEngine;
- (BOOL)isJailbroken;
- (BOOL)checkIsWifi;
@property (nonatomic,strong) NSArray *focusDataArray;
@property (nonatomic,strong) NSArray *linkDataArray;

- (NSString *)getCurrentNet;

//修复闪退
- (MKNetworkEngine *)getRepairedOnCompletionHandler:(MKNKResponseBlock)response  errorHandler:(MKNKResponseErrorBlock)error;

//首页标题
- (MKNetworkOperation *)getFocusOnCompletionHandler:(MKNKResponseBlock) response
                                       errorHandler:(MKNKResponseErrorBlock) error;

//最新推荐
- (MKNetworkOperation *)getRecForPage:(int)page
                  OnCompletionHandler:(MKNKResponseBlock) response
                         errorHandler:(MKNKResponseErrorBlock) error;

//主页-最新推荐-四个分类块(ipad)
- (MKNetworkOperation *)getFocusPadOnCompletionHandler:(MKNKResponseBlock) response
                                          errorHandler:(MKNKResponseErrorBlock) error;

//时下热门
- (MKNetworkOperation *)getCurrrentHotFor:(int)page
                       OnCompletionHander:(MKNKResponseBlock) response
                             errorHandler:(MKNKResponseErrorBlock) error;

//游戏专题
- (MKNetworkOperation *)getGameSpecialOnCompletionHander:(MKNKResponseBlock) response
                                            errorHandler:(MKNKResponseErrorBlock) error;
// 游戏专题列表
- (MKNetworkOperation *)getTopicDetailWithId:(NSString *)infoId OnCompletionHander:(MKNKResponseBlock) response errorHandler:(MKNKResponseErrorBlock) error;

//首页-活动专题游戏列表
- (MKNetworkOperation *)getGameActiveSpecialOnCompletionHander:(MKNKResponseBlock) response
                                                  errorHandler:(MKNKResponseErrorBlock) error;

//游戏下载页面，应用详情
- (MKNetworkOperation *)getAppDetailInfoFor:(int)appID
                         OnCompletionHander:(MKNKResponseBlock) response
                               errorHandler:(MKNKResponseErrorBlock) error;

// 根据包名 获取游戏详情页面
- (MKNetworkOperation *)getAppDetailInfoByPackage:(NSString *)package OnCompletionHander:(MKNKResponseBlock) response errorHandler:(MKNKResponseErrorBlock) error;

//开发商专题
- (MKNetworkOperation *)getDeveloperInfo:(int)developerID
                      OnCompletionHander:(MKNKResponseBlock) response
                            errorHandler:(MKNKResponseErrorBlock) error;

//开发商旗下应用
- (MKNetworkOperation *)getDeveloperID:(int)deceloperID
                            andAppPage:(int)page
                    OnCompletionHander:(MKNKResponseBlock) response
                          errorHandler:(MKNKResponseErrorBlock) error;

// pad排行榜必玩
- (MKNetworkOperation *)getNecessarilyAppInfoOnCompletionHander:(MKNKResponseBlock) response errorHandler:(MKNKResponseErrorBlock) error;

//推荐应用
- (MKNetworkOperation *)getRecommentAppInfoForPage:(int)page
                                OnCompletionHander:(MKNKResponseBlock) response errorHandler:(MKNKResponseErrorBlock) error;

//新装机必备
- (MKNetworkOperation *)getMainNecessaryForPage:(int)page pageSize:(int)pageSize OnCompletionHandler:(MKNKResponseBlock)response errorHandler:(MKNKResponseErrorBlock)error;
//新整合的-分类
- (MKNetworkOperation *)getCategoryInfoCompletionHandler:(MKNKResponseBlock) response
                                            errorHandler:(MKNKResponseErrorBlock) error;
//新整合分类-通用列表详情
- (MKNetworkOperation *)getCategoryDetailInfoWithLinkType:(NSInteger)linkType
                                                   linkID:(NSInteger)linkID
                                                 sortType:(SortType)type
                                                     page:(int)page
                                       OnCompletionHander:(MKNKResponseBlock) response
                                             errorHandler:(MKNKResponseErrorBlock) error;
//新版详情-资讯
- (MKNetworkOperation *)getDetailInfoWithGameID:(NSInteger)gameID categoryID:(int)categoryID page:(int)page pageSize:(int)pageSize CompletionHandler:(MKNKResponseBlock) response
                                   errorHandler:(MKNKResponseErrorBlock) error;
//新版游戏详情-大家还喜欢
- (MKNetworkOperation *)getDetailOtherGameWithCategoryID:(int)categoryID page:(int)page pageSize:(int)pageSize completionHandler:(MKNKResponseBlock) response
                                            errorHandler:(MKNKResponseErrorBlock) error;
//游戏分类
- (MKNetworkOperation *)getGameCategoryCompletionHandler:(MKNKResponseBlock) response
                                            errorHandler:(MKNKResponseErrorBlock) error;
//用途分类
- (MKNetworkOperation *)getAppCategoryCompletionHandler:(MKNKResponseBlock) response
                                           errorHandler:(MKNKResponseErrorBlock) error;
//网游分类
- (MKNetworkOperation *)getOnlineGameCategoryCompletionHandler:(MKNKResponseBlock) response
                                                  errorHandler:(MKNKResponseErrorBlock) error;
//网游-网游分类-列表详情
- (MKNetworkOperation *)getOnlineGameListWithId:(int)categoryId
                                   categoryType:(NSString *)categoryType
                                       sortType:(SortType)type
                                           page:(int)page
                             OnCompletionHander:(MKNKResponseBlock) response
                                   errorHandler:(MKNKResponseErrorBlock) error;
// pad 分类用途
- (MKNetworkOperation *)getCategoryUserInfoOnCompletionHander:(MKNKResponseBlock) response errorHandler:(MKNKResponseErrorBlock) error;

//分类-用途列表
- (MKNetworkOperation *)getCategoryUserListWithId:(int)categoryId
                                         sortType:(SortType)type
                                             page:(int)page
                               OnCompletionHander:(MKNKResponseBlock) response
                                     errorHandler:(MKNKResponseErrorBlock) error;

//分类-通用列表
- (MKNetworkOperation *)getCategoryListWithId:(int)categoryId
                                 categoryType:(NSString *)categoryType
                                     sortType:(SortType)type
                                         page:(int)page
                           OnCompletionHander:(MKNKResponseBlock) response
                                 errorHandler:(MKNKResponseErrorBlock) error;
//分类-热门推荐
- (MKNetworkOperation *)getAppRecommendCategoryCompletionHandler:(MKNKResponseBlock) response
                                                    errorHandler:(MKNKResponseErrorBlock) error;

//5.1 网游-最新推荐
- (MKNetworkOperation *)getOnlineGameLastestForPage:(int)page
                                OnCompletionHandler:(MKNKResponseBlock) response
                                       errorHandler:(MKNKResponseErrorBlock) error;
// 网络游戏最新推荐焦点
- (MKNetworkOperation *)getOnlineGameNewFocusCompletionHandler:(MKNKResponseBlock) response
                                                  errorHandler:(MKNKResponseErrorBlock) error;
//游戏列表
- (MKNetworkOperation *)getOnlineGameHotForPage:(int)page
                            OnCompletionHandler:(MKNKResponseBlock) response
                                   errorHandler:(MKNKResponseErrorBlock) error;
// 搜索提示
- (MKNetworkOperation *)getSearchNoticeWithKeyWord:(NSString *)keyWord CompletionHandler:(MKNKResponseBlock) response
                                      errorHandler:(MKNKResponseErrorBlock) error;
//排行榜-上升最快
- (MKNetworkOperation *)getTopUpForPage:(int)page
                    OnCompletionHandler:(MKNKResponseBlock) response
                           errorHandler:(MKNKResponseErrorBlock) error;
//排行榜-近期最热
- (MKNetworkOperation *)getTopHotForPage:(int)page
                     OnCompletionHandler:(MKNKResponseBlock) response
                            errorHandler:(MKNKResponseErrorBlock) error;
//排行榜-经典必备
- (MKNetworkOperation *)getTopNecessaryForPage:(int)page
                           OnCompletionHandler:(MKNKResponseBlock) response
                                  errorHandler:(MKNKResponseErrorBlock) error;

//请求url内容
- (MKNetworkOperation *)getContentForUrlString:(NSString *)urlString
                                      response:(MKNKResponseBlock)response
                                         error:(MKNKResponseErrorBlock)error;

// 搜索首页
- (MKNetworkOperation *)getSearchDataCompletionHandler:(MKNKResponseBlock) response errorHandler:(MKNKResponseErrorBlock) error;

// 搜索结果
- (MKNetworkOperation *)getSearchResultWithKeyWord:(NSString *)keyWord page:(int)page CompletionHandler:(MKNKResponseBlock) response
                                      errorHandler:(MKNKResponseErrorBlock) error;
//  邮箱密码注册
- (MKNetworkOperation *)registerWithEmail:(NSString *)email
                                 password:(NSString *)password
                      onCompletionHandler:(MKNKResponseBlock) response
                             errorHandler:(MKNKResponseErrorBlock) error;
//  邮箱密码登录
- (MKNetworkOperation *)loginWithEmail:(NSString *)email
                              password:(NSString *)password
                   onCompletionHandler:(MKNKResponseBlock) response
                          errorHandler:(MKNKResponseErrorBlock) error;
// 找回密码
- (MKNetworkOperation *)findBackPassWordWithEmail:(NSString *)email onCompletionHandler:(MKNKResponseBlock) response
                                     errorHandler:(MKNKResponseErrorBlock) error;
// 修改密码
- (MKNetworkOperation *)changePassWordWithUid:(NSString *)uid oldPwd:(NSString *)oldPwd newPwd:(NSString *)newPwd onCompletionHandler:(MKNKResponseBlock) response
                                 errorHandler:(MKNKResponseErrorBlock) error;
// 登出
- (MKNetworkOperation *)logOutCompletionHandler:(MKNKResponseBlock) response
                                   errorHandler:(MKNKResponseErrorBlock) error;

// 获取评论列表
- (MKNetworkOperation *)getCommentsListByAppDetailInfoFor:(int)appID CompletionHandler:(MKNKResponseBlock) response
                                             errorHandler:(MKNKResponseErrorBlock) error;
// 发布评论
- (MKNetworkOperation *)CommentWithGameId:(NSString *)game_id
                                      pid:(NSString *)pid message:(NSString *)message userId:(NSString *)userId
                      onCompletionHandler:(MKNKResponseBlock) response
                             errorHandler:(MKNKResponseErrorBlock) error;
// 修改用户信息
- (MKNetworkOperation *)setUserInfotWithUid:(int)uid
                                   nickName:(NSString *)nickname sex:(NSString *)sex phone:(NSString *)phone
                        onCompletionHandler:(MKNKResponseBlock) response
                               errorHandler:(MKNKResponseErrorBlock) error;

// 上传头像
- (MKNetworkOperation *)setUserImgWithUid:(int)uid
                             headphotoImg:(UIImage *)photoImg
                      onCompletionHandler:(MKNKResponseBlock) response
                             errorHandler:(MKNKResponseErrorBlock) error;

// 获取头像接口
- (MKNetworkOperation *)getUserImgWithUid:(int)uid
                      onCompletionHandler:(MKNKResponseBlock) response
                             errorHandler:(MKNKResponseErrorBlock) error;

// 获取常见问题列表
- (MKNetworkOperation *)getComQuestionCompletionHandler:(MKNKResponseBlock) response
                                           errorHandler:(MKNKResponseErrorBlock) error;
// 获取意见反馈列表
- (MKNetworkOperation *)getAdviceFeedBackCompletionHandler:(MKNKResponseBlock) response
                                              errorHandler:(MKNKResponseErrorBlock) error;
// 提交意见反馈
- (MKNetworkOperation *)postAdviceFeedBackWithType:(NSString *)type
                                             email:(NSString *)email game_name:(NSString *)game_name content:(NSString *)content
                               onCompletionHandler:(MKNKResponseBlock) response
                                      errorHandler:(MKNKResponseErrorBlock) error;
// 消息中心
- (MKNetworkOperation *)getMessageCenterInfoListByUserUid:(int)uid CompletionHandler:(MKNKResponseBlock) response
                                             errorHandler:(MKNKResponseErrorBlock) error;
// 检查版本更新
- (MKNetworkOperation *)checkIsNeedUpdateVersionCompletionHandler:(MKNKResponseBlock) response
                                                     errorHandler:(MKNKResponseErrorBlock) error;
// 获取可更新列表
- (MKNetworkOperation *)getEnableUpdateListByIdentifer:(NSString *)identiferStr
                                   onCompletionHandler:(MKNKResponseBlock) response
                                          errorHandler:(MKNKResponseErrorBlock) error;

// 获取关于奶糖里的其他应用
- (MKNetworkOperation *)getAboutNTOtherGamesCompletionHandler:(MKNKResponseBlock) response
                                                 errorHandler:(MKNKResponseErrorBlock) error;
@end

@interface MKNetworkOperation(null)
- (id)responseJSONRemoveNull;
@end


