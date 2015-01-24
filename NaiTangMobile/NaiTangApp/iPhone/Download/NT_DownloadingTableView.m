//
//  NT_DownloadingTableView.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-9.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_DownloadingTableView.h"
#import "NT_HeaderCell.h"
#import "NT_DownloadingCell.h"
#import "NT_SpeedShowWindow.h"
#import "NT_DownloadManager.h"

@interface NT_DownloadingTableView ()
{
    BOOL _isScrolling;
    BOOL _isNeedRefresh;
}

@end

@implementation NT_DownloadingTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.opaque = YES;
        self.alpha = 1.0;
        self.backgroundColor = [UIColor clearColor];
        self.delegate = self;
        self.dataSource = self;
        _isNeedRefresh = NO;
        _isScrolling = NO;
        [NT_DownloadManager sharedNT_DownLoadManager].delegate = self;
        
        
    }
    return self;
}

#pragma mark -- 
#pragma mark -- UITableView Data Source Methods And Delegate Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[NT_DownloadManager sharedNT_DownLoadManager].downLoadingArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger currentRow = indexPath.row-1;
    if (currentRow<0) {
        currentRow=0;
    }
    
    static NSString *cellID = @"cell";
    NT_DownloadingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = [[NT_DownloadingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.downloadStautsButton addTarget:self action:@selector(downloadStautsButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    //刷新游戏下载中信息
    NT_DownloadModel *model = [[NT_DownloadManager sharedNT_DownLoadManager].downLoadingArray objectAtIndex:currentRow];
    cell.model = model;
    [cell refreshDataWith:model];
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

#pragma mark --
#pragma mark NT_DownloadingCell Delegate Methods
//获取按钮的状态值
- (void)downloadStautsButtonPressed:(UIButton *)btn
{
    NT_DownloadingCell *cell = nil;
    if (isIOS7)
    {
        cell = (NT_DownloadingCell *)btn.superview.superview.superview;
    }
    else
    {
        cell = (NT_DownloadingCell *)btn.superview.superview;
    }
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    
    NT_DownloadModel *model = cell.model;
    
    if ([btn.titleLabel.text isEqualToString:@"删除"])
    {
        
    }
    else
    {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 耗时的操作
            if (model.loadType == LOADING || model.loadType == DOWNFAILEDWITHUNCONNECT)
            {
                //若任务是下载时，暂停下载任务
                model.loadType = PAUSE;
                [[NT_DownloadManager sharedNT_DownLoadManager] pauseDownLoadWithModel:model indexPath:indexPath];
                [[NT_DownloadManager sharedNT_DownLoadManager] saveArchiver];
                
            }
            else if (model.loadType == PAUSE || model.loadType == WAITEDOWNLOAD)
            {
                //若任务时暂停的，则开始下载任务
                model.loadType = LOADING;
                [[NT_DownloadManager sharedNT_DownLoadManager] startDownLoadWithModel:model indexPath:indexPath];
                [[NT_DownloadManager sharedNT_DownLoadManager] saveArchiver];
            }
            else if (model.loadType == WAITEDOWNLOAD)
            {
                //等待下载，不做处理
                model.loadType = WAITEDOWNLOAD;;
            }
            else if (model.loadType == DOWNFAILED)
            {
                //若任务是失败的，则重新下载
                model.loadType = LOADING;
                [[NT_DownloadManager sharedNT_DownLoadManager] pauseDownLoadWithModel:model indexPath:indexPath];
                [[NT_DownloadManager sharedNT_DownLoadManager] saveArchiver];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                if (indexPath)
                {
                    [self beginUpdates];
                    [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    [self endUpdates];
                }
                
            });
        });

    }
    
    /*
    if (model.loadType == LOADING || model.loadType == DOWNFAILEDWITHUNCONNECT)
    {
        btn.tag = PAUSE;
        [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        /\*
        [btn setTitle:@"暂停" forState:UIControlStateNormal];
        [btn setTitleColor:Text_Color forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn-white.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn-white-hover.png"] forState:UIControlStateHighlighted];
         *\/

        //若任务是下载时，暂停下载任务
        model.loadType = PAUSE;
        [[NT_DownloadManager sharedNT_DownLoadManager] pauseDownLoadWithModel:model indexPath:indexPath];
        [[NT_DownloadManager sharedNT_DownLoadManager] saveArchiver];
        
    }
    else if (model.loadType == PAUSE || model.loadType == WAITEDOWNLOAD)
    {
        btn.tag = LOADING;
        [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        /\*
        [btn setTitle:@"继续" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn-blue.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn-blue-hover.png"] forState:UIControlStateHighlighted];
         *\/
        
        //若任务时暂停的，则开始下载任务
        model.loadType = LOADING;
        [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [[NT_DownloadManager sharedNT_DownLoadManager] startDownLoadWithModel:model indexPath:indexPath];
        [[NT_DownloadManager sharedNT_DownLoadManager] saveArchiver];
    }
    else if (model.loadType == WAITEDOWNLOAD)
    {
        btn.tag = WAITEDOWNLOAD;
        [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        /\*
        [btn setTitle:@"等待" forState:UIControlStateNormal];
        [btn setTitleColor:Text_Color forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn-white.png"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btn-white-hover.png"] forState:UIControlStateHighlighted];
         *\/
        
        //等待下载，不做处理
        model.loadType = WAITEDOWNLOAD;;
    }
    else if (model.loadType == DOWNFAILED)
    {
        btn.tag = LOADING;
        [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        //若任务是失败的，则重新下载
        model.loadType = LOADING;
        [[NT_DownloadManager sharedNT_DownLoadManager] pauseDownLoadWithModel:model indexPath:indexPath];
        [[NT_DownloadManager sharedNT_DownLoadManager] saveArchiver];
    }
*/
}

#pragma mark --
#pragma mark NT_HearderViewDelegate Delegate Methods
- (void)editButtonDelegate:(UIButton *)btn
{
    
}

- (void)allStartButtonDelegate:(UIButton *)btn
{
    //全部开始按钮按下
}

#pragma mark --
#pragma mark NT_DownLoadManagerDelegate Delegate Methods

//刷新当前下载进度条显示
- (void)refreshViewInDownLoadManager:(NT_DownloadManager *)downLoadManager indexPath:(NSIndexPath *)indexPath
{
    double totalSpeed = 0;
    int downCount = 0;
    for (NT_DownloadModel *model in [NT_DownloadManager sharedNT_DownLoadManager].downLoadingArray)
    {
        if (model.loadType == LOADING || model.loadType == DOWNFAILEDWITHUNCONNECT)
        {
            totalSpeed += model.downSpeed;
            downCount ++;
        }
    }
    [NT_SpeedShowWindow  showSpeed:totalSpeed];
    if (downCount == 0)
    {
        [NT_SpeedShowWindow hideSpeedView];
    }
    if (!_isScrolling)
    {
        
        if (indexPath)
        {
            [self reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        else
        {
            [self reloadData];
        }
    }
    else
    {
        _isNeedRefresh = YES;
    }

}

@end
