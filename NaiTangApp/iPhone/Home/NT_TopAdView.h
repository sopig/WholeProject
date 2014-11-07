//
//  NT_TopAdView.h
//  NaiTangApp
//
//  Created by 张正超 on 14-4-10.
//  Copyright (c) 2014年 张正超. All rights reserved.
//
//  主页-广告图片，无文字显示

#import <UIKit/UIKit.h>
#import "EGOImageView.h"

@interface NT_TopAdView : UIView <SKStoreProductViewControllerDelegate,UIScrollViewDelegate>
{
    EGOImageView *_imgView;
}
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray * imgArr;

@property (nonatomic , strong) SwitchTableView * switchTableView;


//EGOImageView delegate methods
- (void)willMoveToSuperview:(UIView *)newSuperview;
- (void)setImageURL:(NSString *)imageURL;
- (void)setImageURL:(NSString *)imageURL strTemp:(NSString *)temp;

@end
