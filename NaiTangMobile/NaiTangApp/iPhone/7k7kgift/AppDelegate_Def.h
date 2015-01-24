//
//  AppDelegate_Def.h
//
//



//
//判断设备类型
//
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

//
//设备型号像素
//
#define IPHONE5_PIXEL 1136

#define IPHONE4_PIXEL 960


//
//设备型号物理高度
//
#define IPHONE5_HEIGHT 568

#define IPHONE4_HEIGHT 480


#define ReloadCollectionTableView "ReloadCollectionTableView"
#define PresentContentView "PresentContentView"
#define ProgressHUDHidden @"ProgressHUDHidden"

#define HiddenStatusBar "HiddenStatusBar"

#define fontColor [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]


//
//系统
//
#define IOS7 [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

#define IOS6 [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0

#define IPAD_WIDTH 768
#define IPAD_HEGHT 1024



#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPad4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)

//#define iPad ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#define CenterVuewControllerURL @"http://w.7kapp.cn/zshtml/yxzs/bwlb2zs/gkgl/"
//森林
#define MovieListUrl    @"http://w.7kapp.cn/zshtml/yxzs/gsz2/gkgl/sl/sp/list_88_1.html"
//废品厂
#define JunkyardListUrl @"http://w.7kapp.cn/zshtml/yxzs/gsz2/gkgl/fpc/sp/list_95_1.html"
//沙漠
#define DesertListUrl @"http://w.7kapp.cn/zshtml/yxzs/gsz2/gkgl/sm/sp/list_97_1.html"
//地下城
#define UndergroundCityListUrl @"http://w.7kapp.cn/zshtml/yxzs/gsz2/gkgl/dxc/sp/list_99_1.html"
//城市花园
#define CityGardenListUrl @"http://w.7kapp.cn/zshtml/yxzs/gsz2/gkgl/csgy/sp/list_101_1.html"


/** APP下载地址
 */
#define AppUrl @"https://itunes.apple.com/cn/app/id838133287?mt=8"

/** APP版本
 */
#define AppVersion @"v1.0"

/** 昵称
 */
#define AppNickname @"7k7k玩家"

/** APP名称
*/
#define AppName @"7k7k游戏"

//NAV背景颜色
#define NAV_UICOLOR [[UIColor alloc]initWithRed:42/255.0 green:164/255.0 blue:242/255.0 alpha:1.0]

/**
 * 定义友盟统计需要的全局变量
 *
**/


#define UMENG_STATISTICAL_APPKEY @"52ff32c356240b0447164b9a"

// 文章加载 次数
int umengLogLoadedArticleData;

// 进入文章的按钮的点击次数
int umengLogTapBtnToOpenArticle;

// 点击按钮展开左侧栏 次数
int umengLogTapBtnToOpenLeft;

// 左滑展开左侧栏 次数
int umengLogGestureOpenLeft;

// 点击按钮展开右侧栏 次数
int umengLogTapBtnToOpenRight;

// 右滑展开右侧栏 次数
int umengLogGestureOpenRight;

// 点击按钮打开列表页 次数
int umengLogTapBtnToOpenList;

// 加载列表页数据 次数
int umengLogLoadedListData; 

// 视频打开次数
int umengLogMovieLoaded;

// 取消收藏
int umengLogCancelCollection_event;

// 收藏
int umengLogcollection_event;

// 退出程序
int onApplicationTerminate;

// 分享
int share_event;

//分享失败
int shareFailure_event;

#pragma mark --Recommend

//推荐-展示量
int umengLogRecListShow;

// 推荐-游戏推荐点击量
int umengLogRecGameRecClick;

// 推荐-评测-展示量
int umengLogRecTestListShow;

// 推荐-评测-内容点击量
int umengLogRecTestContClick;

// 推荐-视频-展示量
int umengLogRecVideoListShow;

// 推荐-视频-内容点击量
int umengLogRecVideoContClick;

// 推荐-攻略-展示量
int umengLogRecGuideListShow;

// 推荐-攻略-内容点击量
int umengLogRecGuideContClick;

// 推荐-问答-展示量
int umengLogRecQuesListShow;

// 推荐-问答-内容点击量
int umengLogRecQuesContClick;

// 推荐-限时免费-展示量
int umengLogRecXsmfListShow;

// 推荐-限时免费-内容点击量
int umengLogRecXsmfContClick;

// 推荐-装机必备-展示量
int umengLogRecZjbbListShow;

// 推荐-装机必备-内容点击量
int umengLogRecZjbbContClick;

// 推荐-网络游戏-展示量
int umengLogRecWlyxListShow;

// 推荐-网络游戏-内容点击量
int umengLogRecWlyxContClick;

// 推荐-排行榜-展示量
int umengLogRecRankListShow;

// 推荐-排行榜-内容点击量
int umengLogRecRankContClick;

#pragma mark --Search

// 搜索-展示量
int umengLogSearchShow;

// 搜索-检索量
int umengLogSearchUse;

// 搜索-结果点击量
int umengLogSearchResultClick;

#pragma mark --FindGame

// 找游戏-展示量
int umengLogFindGameShow;

// 找游戏-全部分类-展示量
int umengLogFindGameAll_Show;

// 找游戏-全部分类-下载按钮点击
int umengLogFindGameAll_DownloadClick;

#pragma mark --Gift

// 礼包-展示量
int umengLogGiftListShow;

// 礼包-礼包详情-展示量
int umengLogGiftDetailShow;

// 礼包-礼包详情-领取
int umengLogGiftDetailGet;

// 礼包-礼包详情-领取成功
int umengLogGiftDetailGetSuccess;

