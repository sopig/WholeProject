//
//  ContentCell.h
//  NetDemo
//
//  Created by 海锋 周 on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface CommentsCell : UITableViewCell
{
    //作者
    UILabel *txtAnchor;
    //内容
    UILabel *txtContent;
    //楼层
    UILabel *txtfloor;
    //背景
    UIImageView *centerimageView;
    //底部的画笔
    UIImageView *footView;
}

@property(nonatomic,retain) UILabel *txtAnchor;
@property(nonatomic,retain) UILabel *txtContent; 
@property(nonatomic,retain) UILabel *txtfloor;
@property(nonatomic,retain) UIImageView *footView;
@property(nonatomic,retain) UIImageView *centerimageView;
-(void) resizeTheHeight;
@end
