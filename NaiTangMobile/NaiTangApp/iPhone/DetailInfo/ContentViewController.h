//
//  ContentViewController.h
//  DDMenuController
//
//  Created by 王明远 on 13-12-9.
//
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "WebViewJavascriptBridge.h"
#import "EGImageBrowser.h"

@class SwitchTableView;

@class LevelModel;
@interface ContentViewController : UIViewController<UIGestureRecognizerDelegate,EGImageBrowserDelegate,WebViewJavascriptBridgeDelegate>
{
    MBProgressHUD *progressHUD;
    UIButton *collectBtn;
    UIView *_topView;
    UILabel *_rightLabel;
    UIImageView *_leftImgView;
    
}

@property (nonatomic, strong) SwitchTableView * switchTableView;

@property (nonatomic, strong) UIWebView * webView;
@property (nonatomic, strong) NSString * webUrl;
@property (nonatomic, strong) NSMutableArray * ContentArr;
@property (nonatomic, strong) LevelModel * levelModel;
@property (nonatomic, strong) NSString * titleText;
@property (nonatomic, strong) NSString *detailText;

// 用来展示webView中的图片
@property (strong, nonatomic) EGImageBrowser * mediaFocusController;

// 用来实现javaScript和object-c的交互
@property (strong, nonatomic) WebViewJavascriptBridge * jsBridge;

@end
