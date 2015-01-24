//
//  ZiLiaoTableView.m
//  GAMENEWS
//
//  Created by 小远子 on 14-3-5.
//  Copyright (c) 2014年 Hua Wang. All rights reserved.
//

#import "ZiLiaoTableView.h"
#import "DataCell.h"
#import "UIView+Additions.h"
#import "GuidesVideoModel.h"
#import "ContentViewController.h"

@implementation ZiLiaoTableView

- (id)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
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
    return [self.data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    DataCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[DataCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    GuidesVideoModel * model = [self.data objectAtIndex:indexPath.row];
    if (model.image == nil) {
        cell.isTemp = NO;
    }else{
        cell.isTemp = YES;
        [cell.imgView setImageURL:[NSURL URLWithString:model.image]];
    }
    cell.titleText.text = model.Videotitle;
    cell.briefLabel.text = model.pubdate;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GuidesVideoModel * model = [self.data objectAtIndex:indexPath.row];
    ContentViewController * contenVC = [[ContentViewController alloc] init];
    contenVC.webUrl = model.link;
    contenVC.titleText = self.gameName;
    [self.viewController.navigationController pushViewController:contenVC animated:YES];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
