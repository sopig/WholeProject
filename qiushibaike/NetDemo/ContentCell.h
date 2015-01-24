//
//  ContentCell.h
//  NetDemo
//
//  Created by 海锋 周 on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageButton.h"
#import "PhotoViewer.h"
@interface ContentCell : UITableViewCell<EGOImageButtonDelegate>
{
     //糗事图片
    EGOImageButton *imgPhoto;
    //糗事图片的小图url
    NSString *imgUrl;
    //糗事图片的大图url
    NSString *imgMidUrl;
    //糗事标签
    UILabel *txtTag;
    //糗事作者
    UILabel *txtAnchor;
    //糗事内容
    UILabel *txtContent;
    //作者头像
    UIImageView *headPhoto;
    //标签图像
    UIImageView *TagPhoto;
    //背景图像
    UIImageView *centerimageView;
    //底部花边
    UIImageView *footView;
    //顶按钮
    UIButton *goodbtn;   
    //踩按钮
    UIButton *badbtn;   
    //评论按钮  
    UIButton *commentsbtn;        
}
@property(nonatomic,retain) EGOImageButton *imgPhoto;
@property(nonatomic,retain) UIImageView *headPhoto;
@property(nonatomic,retain) UIImageView *TagPhoto;
@property(nonatomic,retain) UILabel *txtTag;
@property(nonatomic,retain) UILabel *txtAnchor;
@property(nonatomic,retain) UILabel *txtContent; 
@property(nonatomic,retain) UIImageView *footView;
@property(nonatomic,retain) UIImageView *centerimageView;
@property(nonatomic,retain) NSString *imgUrl;
@property(nonatomic,retain) NSString *imgMidUrl;
@property (nonatomic,retain) UIButton *goodbtn;    
@property (nonatomic,retain) UIButton *badbtn; 
@property (nonatomic,retain) UIButton *commentsbtn; 
-(void) resizeTheHeight;
@end
