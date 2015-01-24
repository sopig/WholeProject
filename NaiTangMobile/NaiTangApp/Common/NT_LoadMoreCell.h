//
//  NT_LoadMoreCell.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NT_LoadMoreCell : UITableViewCell
{
    UIActivityIndicatorView *_activiter;
}

@property (nonatomic,strong) UILabel *label;
- (void)startLoading;
- (void)endLoading;

@end
