//
//  NT_GuidesView.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_GuidesView.h"
#import "NT_GuidesCell.h"
#import "XiangQingViewController.h"
#import "UIView+Additions.h"
#import "GuidesVideoModel.h"
#import "Utile.h"
#import "AppDelegate_Def.h"
#import "NT_MacroDefine.h"
#import "ContentViewController.h"

@implementation NT_GuidesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.guidesArray = [NSArray array];
        //        UILabel * l = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        //        [self addSubview:l];
        int guidesTableView;
        if (isIphone5Screen) {
            guidesTableView = 380;
        }else{
            guidesTableView = 290;
        }
        
        _guidesTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, guidesTableView) style:UITableViewStylePlain];
        _guidesTableView.opaque = YES;
        _guidesTableView.backgroundColor = [UIColor clearColor];
        //        _guidesTableView.scrollEnabled = NO;
        _guidesTableView.alpha = 1.0;
        _guidesTableView.delegate = self;
        _guidesTableView.dataSource = self;
        _guidesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self addSubview:_guidesTableView];
        [Utile setExtraCellLineHidden:_guidesTableView];
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
    return [self.guidesArray count];
    //    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"guidesCell";
    NT_GuidesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[NT_GuidesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    GuidesVideoModel * model = [self.guidesArray objectAtIndex:indexPath.row];
    if ([self.strType isEqualToString:@"tag"]){
        
        self.isTemp = NO;
        cell.guidesTitleLabel.text = model.name;
        cell.countLabel.text = [NSString stringWithFormat:@"共%@篇",model.countStr];
        if (model.image != nil) {
            cell.isTemp = YES;
            [cell.guidesImageView setImageURL:[NSURL URLWithString:model.image]];
        }else{
            cell.isTemp = NO;
        }
        
    }else if(![self.strType isEqualToString:@"tag"]){
        
        self.isTemp = YES;
        cell.guidesTitleLabel.text = model.Videotitle;
        cell.countLabel.text = model.pubdate;
        
        if (model.image != nil) {
            cell.isTemp = YES;
            
            [cell.guidesImageView setImageURL:[NSURL URLWithString:model.image]];
        }else{
            cell.isTemp = NO;
        }
    }
    
    [cell refreshGuidesInfo:nil];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuidesVideoModel * model = [self.guidesArray objectAtIndex:indexPath.row];
    
    if (self.isTemp == YES) {
        ContentViewController * contenVC = [[ContentViewController alloc] init];
        contenVC.webUrl = model.link;
        contenVC.titleText = @"攻略资料";
        self.viewController.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:contenVC animated:YES];
    }else{
        XiangQingViewController * XQVC = [[XiangQingViewController alloc] init];
        XQVC.strID = model.strId;
        XQVC.title = model.name;
        self.viewController.hidesBottomBarWhenPushed = YES;
        [self.viewController.navigationController pushViewController:XQVC animated:YES];
        //    self.viewController.hidesBottomBarWhenPushed = NO;
    }
}


@end
