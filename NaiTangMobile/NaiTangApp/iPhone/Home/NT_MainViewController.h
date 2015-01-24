//
//  NT_MainViewController.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NT_BaseViewController.h"
#import "NT_MainView.h"
#import "NT_CategoryView.h"
#import <StoreKit/SKStoreProductViewController.h>

@interface NT_MainViewController : NT_BaseViewController <UIScrollViewDelegate,NTMainViewDelegate,SKStoreProductViewControllerDelegate>
{
    NT_MainView *_mainView;//热门
    NT_MainView *_topClassical;//必备
    NT_MainView *_onlineGame;//网游
    NT_CategoryView *_goldTableView;//无限金币
}
@property (strong,nonatomic) UIScrollView *mainScrollView;
@property (strong,nonatomic) NSArray *mainArray;
@property (strong,nonatomic) NT_AppDetailInfo *appDetailInfo;

//选项卡-下一栏
- (void)_slideIndex:(int)page;
@end
