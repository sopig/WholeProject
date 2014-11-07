//
//  NT_VideoView.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_VideoView.h"
#import "NT_VideoCell.h"
#import "UIView+Additions.h"
#import "ContentViewController.h"
#import "GuidesVideoModel.h"
#import "Utile.h"
#import "SwitchTableView.h"
#import "AppDelegate_Def.h"
#import "NT_MacroDefine.h"


@implementation NT_VideoView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.VideoViewArr = [NSMutableArray array];
        
        int  tableHigh;
        if (isIphone5Screen) {
            tableHigh = 380;
        }else{
            tableHigh = 290;
        }
        
        // Initialization code
        _videoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, tableHigh) style:UITableViewStylePlain];
        _videoTableView.backgroundColor = [UIColor clearColor];
        _videoTableView.opaque = YES;
        _videoTableView.alpha = 1.0;
        _videoTableView.delegate = self;
        _videoTableView.dataSource = self;
        _videoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_videoTableView];
        [Utile setExtraCellLineHidden:_videoTableView];
    }
    return self;
}

#pragma mark --
#pragma  mark -- UITableView Data Source Methods
/**
 * @brief 设定cell的背景色
 * 专门用这个方法来设定cell的背景色
 * 是因为在IOS6里面，cell的背景色是无法被直接设定的
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor whiteColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.VideoViewArr count];
    //    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"guidesCell";
    NT_VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NT_VideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SwitchTableView * switchTab = [SwitchTableView shareSwitchTableViewData];
    GuidesVideoModel * model = [self.VideoViewArr objectAtIndex:indexPath.row];
    if (model.image != nil) {
        cell.isTemp = YES;
        if ([switchTab isConnectionAvailable]) {
            [cell setImageURL:model.image];
        }else{
            [cell setImageURL:model.image strTemp:@"oo"];
        }
    }else{
        cell.isTemp = NO;
    }
    
    cell.videoTitleLabel.text = model.Videotitle;
    cell.descriptionLabel.text = model.description;
    cell.dateLabel.text = model.pubdate;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuidesVideoModel * model = [self.VideoViewArr objectAtIndex:indexPath.row];
    ContentViewController * contenVC = [[ContentViewController alloc] init];
    contenVC.webUrl = model.link;
    contenVC.titleText = self.gameName;
    self.viewController.hidesBottomBarWhenPushed = YES;
    [self.viewController.navigationController pushViewController:contenVC animated:YES];
}

@end
