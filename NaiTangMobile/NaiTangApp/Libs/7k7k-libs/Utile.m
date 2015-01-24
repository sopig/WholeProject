//
//  Utile.m
//  TheKindergarten
//
//  Created by SuperAdmin on 13-10-29.
//  Copyright (c) 2013年 IOS那些事. All rights reserved.
//

#import "Utile.h"

@implementation Utile

//隐藏tableviewCell多余的分割线
+(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
}



@end
