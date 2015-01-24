//
//  liBaoDetailViewController.h
//  libao
//
//  Created by wangxing on 14-3-4.
//  Copyright (c) 2014年 wangxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface liBaoDetailViewController : UIViewController<UIAlertViewDelegate,UIWebViewDelegate,SKStoreProductViewControllerDelegate>

////////////////
// need before viewDidLoad
////////////////

@property (strong, nonatomic) NSString * giftId;

////////////////
// optional
////////////////
@property (strong, nonatomic) NSString * giftName;
@property (strong, nonatomic) NSString * gameName;
@property (strong, nonatomic) NSString * restNum;
@property (strong, nonatomic) NSString * totalNum;

// 表明当前礼包的状态 0==> 可以领取 1==> 已领取 2==> 没有库存(没领取过) 
@property (strong, nonatomic) NSString * giftState;

// 游戏图片的网络地址
@property (strong, nonatomic) NSString * gameIconUrl;

// 存储库存label的显示内容的
@property (strong, nonatomic) NSMutableAttributedString * contentForInfoLabel;

@property (strong, nonatomic) NSString * appId;

@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIButton *btnTopGet;
@property (strong, nonatomic) IBOutlet UIButton *btnBottomGet;
@property (strong, nonatomic) IBOutlet UIButton *btnCopyKey;
@property (strong, nonatomic) IBOutlet UIButton *btnDownloadGame;
@property (strong, nonatomic) EGOImageView *imageViewGameIcon;
@property (strong, nonatomic) IBOutlet UIWebView *webViewGameDescription;
@property (strong, nonatomic) IBOutlet UIView *uiScrollViewWrap;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *uiViewBottom;
//@property (strong, nonatomic) IBOutlet UIView *uiViewNav;
@property (strong, nonatomic) IBOutlet UIView *uiViewGameInfoWrap;
@property (strong, nonatomic) IBOutlet UIView *uiViewBottomLine;
@property (strong, nonatomic) IBOutlet UIView *uiViewGetSuccess;
@property (strong, nonatomic) IBOutlet UILabel *labelGameName;
@property (strong, nonatomic) IBOutlet UILabel *labelSupportedPlatform;
@property (strong, nonatomic) IBOutlet UILabel *labelSupportedArea;
@property (strong, nonatomic) IBOutlet UILabel *labelSupportedTime;
@property (strong, nonatomic) IBOutlet UILabel *labelLibaoCode;
@property (strong, nonatomic) IBOutlet UILabel *labelGiftName;

// 库存：
@property (strong, nonatomic) IBOutlet UILabel *labelGiftInfo;

// 剩余数量
@property (strong, nonatomic) IBOutlet UILabel *labelGiftRest;

// 总数
@property (strong, nonatomic) IBOutlet UILabel *labelGiftTotal;



- (void)getLiBaoDetailWithGiftId:(NSString *)gift_id;


// 点击上面或者下面的领取礼包的按钮
- (IBAction)getKey:(id)sender;

// 点击复制按钮
- (IBAction)copyKey:(id)sender;

// 点击下载游戏
- (IBAction)downloadGame:(id)sender;

- (void)willMoveToSuperview:(UIView *)newSuperview;
- (void)setImageURL:(NSString *)imageURL;

//无网络请求调用
- (void)setImageURL:(NSString *)imageURL strTemp:(NSString *)temp;


@end
