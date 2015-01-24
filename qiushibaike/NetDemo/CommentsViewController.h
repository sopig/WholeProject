//
//  CommentsViewController.h
//  NetDemo
//
//  Created by 海锋 周 on 12-6-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentCell.h"
#import "CommentsCell.h"
#import "ASIHttpHeaders.h"
#import "QiuShi.h"
#import "Comments.h"
#import "SHSShareViewController.h"
@interface CommentsViewController : UIViewController
{
    //糗事内容的TableView
    UITableView *tableView;
    //评论的TableView
    UITableView *commentView;
    //http请求
    ASIHTTPRequest *asiRequest;
    //糗事的对象
    QiuShi *qs;
    //记录评论的数组
    NSMutableArray *list;
}
@property (nonatomic,retain) UITableView *commentView;
@property (nonatomic,retain) UITableView *tableView;
@property (nonatomic,retain) NSMutableArray *list;
@property (nonatomic,retain) ASIHTTPRequest *asiRequest;
@property (nonatomic,retain) QiuShi *qs;
-(CGFloat) getTheHeight;
-(CGFloat) getTheCellHeight:(int) row;
@end

