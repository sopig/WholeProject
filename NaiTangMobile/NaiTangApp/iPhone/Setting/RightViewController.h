//
//  RightViewController.h
//  PartnerProject7kShare
//
//  Created by 王明远 on 13-12-16.
//  Copyright (c) 2013年 王明远. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailActorsView.h"
//#import "RESwitch.h"
#import "ASIHTTPRequest.h"
#import "NT_SwitchButton.h"

@class CollectionView;
@interface RightViewController : UIViewController<UITableViewDataSource,UITableViewDelegate, UIAlertViewDelegate, ASIHTTPRequestDelegate>
{
    UIWindow *_windowView;
    DetailActorsView *_coverView;
    CollectionView *_collectionView;
    
    
    long long sum;
    NSIndexPath *allIndexPath;
    UILabel *_label;
    CGFloat superWidth;
    CGFloat superHeight;
    UIButton *_picLoadBtn;
//    UISwitch *_swicth;
    UIButton *_exchangeBtn;
    
    UIImageView *_onImgView;
    UIImageView *_offImgView;
    
    
//    RESwitch *_defaultSwitch;
    UISwitch * switchWiFi;
    NT_SwitchButton * switchNoWiFi;
    NT_SwitchButton *switchWifiDownload;
    
    UILabel *_commandLabel;
}
@property (nonatomic, strong) UITableView * rightTable;

@property (nonatomic, strong) NSMutableArray * cellArray;
@property (nonatomic, strong) NSMutableArray *tagImgArr;
@property (nonatomic, assign) int index;
@property (nonatomic, strong) NSMutableArray *listArr;

//无最新版本时，不弹出框显示更新信息
@property (nonatomic,assign)BOOL isNoShowUpdate;

//奶糖版本更新提示
- (void)updateNaitangVersion;

@end
