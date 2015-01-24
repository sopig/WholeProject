//
//  NT_RankingViewController.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NT_BaseViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface NT_RankingViewController : NT_BaseViewController <EGORefreshTableHeaderDelegate,UIScrollViewDelegate,NTMainViewDelegate>

@property (nonatomic,strong)  UIScrollView *scrollView;

@end
