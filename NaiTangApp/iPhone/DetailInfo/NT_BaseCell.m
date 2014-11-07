//
//  NT_BaseCell.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_BaseCell.h"
#import "UIButton+WebCache.h"
#import "NT_BaseAppDetailInfo.h"
#import "NT_BaseView.h"
#import "NT_DownloadModel.h"
#import "NT_WifiBrowseImage.h"

@implementation NT_BaseCell

@synthesize baseView = _baseView;
@synthesize control = _control;
@synthesize noLimitGoldImageView = _noLimitGoldImageView;
@synthesize blackBackView = _blackBackView;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.opaque = YES;
        self.alpha = 1.0;
        self.contentView.backgroundColor=[UIColor whiteColor];
        
        _baseView = [[NT_BaseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        [_baseView setDetailBaseView];
        [self.contentView addSubview:_baseView];
        
        /*
        _baseView = [[NT_BaseView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 122)];
        [_baseView setDetailBaseView];
       [self.contentView addSubview:_baseView];
        
        self.giftView = [[UIView alloc] initWithFrame:CGRectMake(12, _baseView.appIcon.bottom+10, SCREEN_WIDTH-12, 25)];
        _giftView.backgroundColor = [UIColor colorWithHex:@"#faf7e3"];
        [self.contentView addSubview:_giftView];
        
        _giftView.hidden = YES;
        
        self.labelGiftName = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 100, 15)];
        _labelGiftName.font = [UIFont systemFontOfSize:12];
        _labelGiftName.text = @"金银铜礼包";
        _labelGiftName.backgroundColor = [UIColor clearColor];
        _labelGiftName.textColor = [UIColor colorWithHex:@"#ff4e36"];
        [_giftView addSubview:_labelGiftName];
        
        self.goLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 5,180, 15)];
        _goLabel.text = @"发放中，快去领取吧！";
        _goLabel.textColor = [UIColor colorWithHex:@"#505a5f"];
        _goLabel.backgroundColor = [UIColor clearColor];
        _goLabel.font = [UIFont systemFontOfSize:12];
        [_giftView addSubview:_goLabel];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_goLabel.right-10, 5, 10, 16)];
        arrowImageView.image = [UIImage imageNamed:@"arrow-right.png"];
        [_giftView addSubview:arrowImageView];
        
        _control = [[UIControl alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 35)];
        [self.contentView addSubview:_control];
         */
    }
    return self;
}

//是否显示礼包
- (void)isShowGiftView:(BOOL)isGift
{
    if (isGift)
    {
        self.giftView = [[UIView alloc] initWithFrame:CGRectMake(12, _baseView.appIcon.bottom+10, SCREEN_WIDTH-12, 25)];
        _giftView.backgroundColor = [UIColor colorWithHex:@"#faf7e3"];
        [self.contentView addSubview:_giftView];
        
        _giftView.hidden = YES;
        
        self.labelGiftName = [[UILabel alloc] initWithFrame:CGRectMake(12, 5, 100, 15)];
        _labelGiftName.font = [UIFont systemFontOfSize:12];
        _labelGiftName.text = @"金银铜礼包";
        _labelGiftName.backgroundColor = [UIColor clearColor];
        _labelGiftName.textColor = [UIColor colorWithHex:@"#ff4e36"];
        [_giftView addSubview:_labelGiftName];
        
        self.goLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 5,180, 15)];
        _goLabel.text = @"发放中，快去领取吧！";
        _goLabel.textColor = [UIColor colorWithHex:@"#505a5f"];
        _goLabel.backgroundColor = [UIColor clearColor];
        _goLabel.font = [UIFont systemFontOfSize:12];
        [_giftView addSubview:_goLabel];
        
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_goLabel.right-10, 5, 10, 16)];
        arrowImageView.image = [UIImage imageNamed:@"arrow-right.png"];
        [_giftView addSubview:arrowImageView];
        
        _control = [[UIControl alloc] initWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 35)];
        [self.contentView addSubview:_control];
    }
}

//基本高度
+ (int)normalHeight
{
    //return 122;
    return 90;
}

//无限金币 纯净版 纯净正版 弹出框时的高度
+ (int)heightWhenShowDownloadInfoForAppInfo:(NT_BaseAppDetailInfo *)info
{
    for (NT_DownloadAddInfo *downloadInfo in info.gameInfo.downloadArray) {
        if (downloadInfo.downloadType == ([[UIDevice currentDevice] isJailbroken]?DownloadTypeNolimitGold:NOBreakDownloadTypeNolimitGold)) {
            //return 175;
            return 155;
        }
    }
    //return 155;
    return [self normalHeight] + 75;
}

//获取游戏基本信息
- (void)refreshWithAppInfo:(NT_BaseAppDetailInfo *)info openDownload:(BOOL)open isShowGift:(BOOL)isGift
{
    if (info)
    {
        //游戏图片 名称 大小 评分
        NT_GameInfo *gameInfo = info.gameInfo;
        NT_BaseView *backImage = self.baseView;
        
        //  设置-打开或关闭wifi下浏览图片通用方法
        [backImage.appIcon imageUrl:[NSURL URLWithString:gameInfo.round_pic] tempSTR:@"false"];
        /*
        NT_WifiBrowseImage *wifiImage = [[NT_WifiBrowseImage alloc] init];
        [wifiImage wifiBrowseImage:backImage.appIcon urlString:gameInfo.round_pic];
         */
        /*
        // 检测当前是否WIFI网络环境
        BOOL isConnectedProperly =[[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==ReachableViaWiFi;
        //是否是2G/3G网络
        BOOL isWWAN = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==ReachableViaWWAN;
        //无网络
        BOOL notReach = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable;
        NSString * netStatus;
        //    NSString * placeHoldImgSrc;
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        
        
        //若关闭"只在wifi下加载图片"，则3G、wifi都可以加载图片
        if ([[userDefaults objectForKey:@"BigPicLoad"] isEqualToString:@"close"])
        {
            //3g或wifif连接
            if (!notReach)
            {
                netStatus = @"true";
                //            placeHoldImgSrc = detailInfo.round_pic;
                [backImage.appIcon setImageURL:[NSURL URLWithString:gameInfo.round_pic]];
            }
        }
        else
        {
            //打开只在wifi下加载图片
            //若使用的是3G，就不加载图片
            if (isWWAN)
            {
                netStatus = @"false";
                //            placeHoldImgSrc = detailInfo.round_pic;
                [backImage.appIcon imageUrl:[NSURL URLWithString:gameInfo.round_pic] tempSTR:netStatus];
            }
            else if (isConnectedProperly)
            {
                //若使用的是wifi，则加载图片
                netStatus = @"true";
                //            placeHoldImgSrc = detailInfo.round_pic;
                [backImage.appIcon setImageURL:[NSURL URLWithString:gameInfo.round_pic]];
            }
            
        }
         */
        backImage.appName.text = gameInfo.game_name;
        backImage.scoreLabel.text = [NSString stringWithFormat:@"评分%@",gameInfo.score];
        //backImage.appSize.text = [NSString stringWithFormat:@"%@",gameInfo.size];
        backImage.appType.text = [NSString stringWithFormat:@"%@  |  %@",gameInfo.categoryName,gameInfo.size];
        
        //是否是无限金币版
        if ([gameInfo.is_much_money intValue] == 0) {
            backImage.goldSign.hidden= YES;
        }
        else
        {
            backImage.goldSign.hidden = NO;
        }
        
        //若是无限金币版，则打开金币弹出框
        if (open)
        {
            if (!self.blackBackView)
            {
                if (isGift)
                {
                    //背景图
                    self.blackBackView = [UIImageView imageViewWithFrame:CGRectMake(0, self.baseView.bottom - 40 , 320, 75) andImage:nil];
                }
                else
                {
                    //背景图
                    self.blackBackView = [UIImageView imageViewWithFrame:CGRectMake(0, self.baseView.bottom , 320, 75) andImage:nil];
                }
                
                self.blackBackView.clipsToBounds = YES;
                UIImageView *bgImageView = [UIImageView imageViewWithFrame:self.blackBackView.bounds andImage:[UIImage imageNamed:@"detail-rectangle.png"]];
                [self.blackBackView addSubview:bgImageView];
                self.blackBackView.userInteractionEnabled = YES;
                [self.contentView addSubview:self.blackBackView];
                
                //加载无限金币弹出框视图
                [self loadViewForUnlimitGoldWithDownloadArray:gameInfo.downloadArray];
            }
        }
    }
    
}

//加载无限金币弹出框视图
- (void)loadViewForUnlimitGoldWithDownloadArray:(NSArray *)downloadArray
{
    self.blackBackView.height = 55;
    UIView *_backImage = self.blackBackView;
    int count = downloadArray.count;
    if (count < 2) {
        return;
    }
    count = MIN(2, count);
    
    float startX = 5;
    float eachWidth = (_backImage.width - startX * 2) / count;
    for (int i = 0; i < count; i++) {
        NT_DownloadAddInfo *info = downloadArray[i];
        NSString *bgImageName = @"";
        NSString *bgImageName_hl = @"";
        switch (info.downloadType) {
            case DownloadTypeAppStore:
                bgImageName = @"btn-green.png";
                bgImageName_hl = @"btn-green-hover.png";
                break;
            case DownloadTypeNormalIpa:
                bgImageName = @"btn-green.png";
                bgImageName_hl = @"btn-green-hover.png";
                break;
            case DownloadTypeNolimitGold:
                bgImageName = @"btn-orange.png";
                bgImageName_hl = @"btn-orange-hover.png";
                break;
            case NOBreakDownloadTypeNolimitGold:
                bgImageName = @"btn-orange.png";
                bgImageName_hl = @"btn-orange-hover.png";
                break;
            default:
                break;
        }
        UIButton *button = [UIButton buttonWithFrame:CGRectMake(0, 16, 140, 25) title:info.version_name bgImage:[UIImage imageNamed:bgImageName] titleColor:[UIColor whiteColor] target:self action:@selector(gotoDownLoad:)];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        button.tag = i;
        [button setBackgroundImage:[UIImage imageNamed:bgImageName_hl] forState:UIControlStateHighlighted];
        [_backImage addSubview:button];
        button.right = _backImage.width - (eachWidth/2 - button.width/2) - eachWidth * i - startX;
        
        if (info.downloadType == ([[UIDevice currentDevice] isJailbroken]?DownloadTypeNolimitGold:NOBreakDownloadTypeNolimitGold)) {
            UIImageView *explanation = [[UIImageView alloc] initWithFrame:CGRectMake(10, 46, _backImage.width - 20, 24)];
            explanation.backgroundColor = [UIColor blackColor];
            [_backImage addSubview:explanation];
            
            UIImageView *arrowImageView = [UIImageView imageViewWithFrame:CGRectMake(button.center.x - 5, explanation.top - 5, 10, 5) andImage:[UIImage imageNamed:@"arrow.png"]];
            [_backImage addSubview:arrowImageView];
            
            UILabel *text = [[UILabel alloc] initWithFrame:CGRectInset(explanation.bounds, 5, 2)];
            text.backgroundColor = [UIColor clearColor];
            text.text = [info.archives_name length] ? info.archives_name : @"全通关存档，顶级武器至尊剑......";
            text.textColor = [UIColor whiteColor];
            text.font = [UIFont systemFontOfSize:10];
            text.adjustsFontSizeToFitWidth = YES;
            text.minimumFontSize = 10;
            [explanation addSubview:text];
            self.blackBackView.height = 75;
        }
    }
}

//下载
- (void)gotoDownLoad:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(appDetailCell:installIndex:)]) {
        [self.delegate appDetailCell:self installIndex:btn.tag];
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
