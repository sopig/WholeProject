//
//  NT_DownStatusWindow.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NT_DownStatusWindow : UIWindow

//@property (nonatomic,strong)UIImageView *iconImg;
@property (nonatomic,strong)EGOImageView *iconImg;
@property (nonatomic,strong) UIImageView *roundImageView;
@property (nonatomic,strong) UIView *redView;
@property (nonatomic,strong)UILabel *leftText,*rightText;
@property (nonatomic, retain) NSMutableArray *array;
@property (nonatomic, assign) BOOL isShowing;

+ (void)showMessageIconStr:(NSString *)iconImg leftText:(NSString *)leftText rightText:(NSString *)rightText;

@end
