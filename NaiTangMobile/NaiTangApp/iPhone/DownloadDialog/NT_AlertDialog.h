//
//  NT_AlertDialog.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NT_AlertDialog : UIView

@property (nonatomic,strong)UIControl *bgControl;
@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UILabel *titTextLabel;
@property (nonatomic,strong)UIImageView *roundView;
@property (nonatomic,strong)UIButton *sureBtn;

@end
