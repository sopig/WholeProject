//
//  NT_NoLimitGoldDialog.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_NoLimitGoldDialog.h"
#import <QuartzCore/QuartzCore.h>

@implementation NT_NoLimitGoldDialog

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _bgControl = [[UIControl alloc] initWithFrame:self.bounds];
        _bgControl.backgroundColor = [UIColor blackColor];
        _bgControl.alpha = 0.4;
        [_bgControl addTarget:self action:@selector(bgControlClick:) forControlEvents:UIControlEventTouchDown];
        [self addSubview:_bgControl];
        
        _backView = [[UIView alloc] initWithFrame:CGRectMake(40.0/800*SCREEN_WIDTH, 196.0/1279*SCREEN_HEIGHT, SCREEN_WIDTH-2*(40.0/800*SCREEN_WIDTH), 340)];
        _backView.backgroundColor = [UIColor colorWithHex:@"#f2f2f2"];
        _backView.layer.cornerRadius = 15;
        _backView.clipsToBounds = YES;
        [self addSubview:_backView];
        
        _titTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 16, _backView.width-100, 25)];
        _titTextLabel.backgroundColor = [UIColor clearColor];
        _titTextLabel.text = @"提 示";
        _titTextLabel.font = [UIFont systemFontOfSize:18];
        _titTextLabel.textAlignment = UITextAlignmentCenter;
        [_backView addSubview:_titTextLabel];
        
        UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(_backView.width-40, 20, 16, 16)];
        [delBtn addTarget:self action:@selector(delBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //[delBtn setBackgroundImage:[UIImage imageNamed:@"设置退出x.png"] forState:UIControlStateNormal];
        [delBtn setImage:[UIImage imageNamed:@"close-x.png"] forState:UIControlStateNormal];
        delBtn.backgroundColor = [UIColor clearColor];
        [_backView addSubview:delBtn];
        
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(_backView.width - 40, 0, 60, 80)];
        [control addTarget:self action:@selector(delBtnClick:)  forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:control];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 48, _backView.width, 1.5)];
        line.backgroundColor = COLOR_WITH_RGB(121, 192, 240);
        [_backView addSubview:line];
        self.lineView = line;
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(18, self.lineView.bottom+18, _backView.width-30, 40)];
        label1.backgroundColor = [UIColor clearColor];
        label1.numberOfLines = 2;
        label1.text = @"无限金币版游戏需要奶糖PC电脑客户端协助安装,您只需要连接到电脑后打开奶糖PC客户端";
        label1.font = [UIFont systemFontOfSize:12];
        label1.textColor = [UIColor colorWithHex:@"#6666666"];
        [_backView addSubview:label1];
        
        
        UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(50*320/768, label1.bottom+5, 20, 20)];
        image1.backgroundColor = COLOR_WITH_RGB(111, 167, 214);
        image1.layer.cornerRadius = image1.width/2;
        image1.clipsToBounds = YES;
        [_backView addSubview:image1];
        
        UILabel *imagLabel1 = [[UILabel alloc] initWithFrame:image1.bounds];
        imagLabel1.backgroundColor = [UIColor clearColor];
        imagLabel1.text = @"1";
        imagLabel1.textAlignment = UITextAlignmentCenter;
        imagLabel1.font = [UIFont boldSystemFontOfSize:14];
        imagLabel1.textColor = [UIColor colorWithHex:@"#ffffff"];
        [image1 addSubview:imagLabel1];
        
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(image1.right+10, image1.top+3, _backView.width-image1.right-20, 15)];
        label2.backgroundColor = [UIColor clearColor];
        label2.font = [UIFont systemFontOfSize:12];
        label2.textColor = [UIColor colorWithHex:@"#6666666"];
        label2.text = @"第一步，连接电脑安装奶糖游戏";
        [_backView addSubview:label2];
        
        UIView *bg1 = [[UIView alloc] initWithFrame:CGRectMake(image1.right+10, image1.bottom+3, label2.width-20, 23)];
        bg1.backgroundColor = [UIColor whiteColor];
        [_backView addSubview:bg1];
        
        UIImageView *iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 15, 15)];
        iconImg.image = [UIImage imageNamed:@"little_logo.png"];
        [bg1 addSubview:iconImg];
        
        UILabel *iconLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImg.right+5, 5, bg1.width-iconImg.right-10, 15)];
        iconLabel.backgroundColor = [UIColor clearColor];
        iconLabel.font = [UIFont systemFontOfSize:12];
        iconLabel.text = @"下载地址:pc.naitang.com";
        iconLabel.textColor = [UIColor colorWithHex:@"#ff6600"];
        [bg1 addSubview:iconLabel];
        
        UIImageView *image2 = [[UIImageView alloc] initWithFrame:CGRectMake(50*320/768, label1.bottom+5+50, 20, 20)];
        image2.layer.cornerRadius = image1.width/2;
        image2.clipsToBounds = YES;
        image2.backgroundColor = COLOR_WITH_RGB(111, 167, 214);
        [_backView addSubview:image2];
        
        UILabel *imagLabel2 = [[UILabel alloc] initWithFrame:image1.bounds];
        imagLabel2.backgroundColor = [UIColor clearColor];
        imagLabel2.text = @"2";
        imagLabel2.textColor = [UIColor whiteColor];
        imagLabel2.font = imagLabel1.font;
        imagLabel2.textAlignment = UITextAlignmentCenter;
        [image2 addSubview:imagLabel2];
        
        UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(image2.right+10, image2.top+3, _backView.width-image1.right-20, 15)];
        label4.backgroundColor = [UIColor clearColor];
        label4.font = [UIFont systemFontOfSize:12];
        label4.text = @"第二步，确认无限金币安装";
        label4.textColor = [UIColor colorWithHex:@"#6666666"];
        [_backView addSubview:label4];
        
        UIImageView *bg2 = [[UIImageView alloc] initWithFrame:CGRectMake(image2.right+30, image2.bottom+10, 118, 77)];
        bg2.image = [UIImage imageNamed:@"dialog-gold.png"];
        [_backView addSubview:bg2];
        
        UIButton *clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clickBtn.frame = CGRectMake(45, _backView.height-25-25, 190, 30);
        clickBtn.layer.cornerRadius = 22;
        [clickBtn addTarget:self action:@selector(delBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [clickBtn setTitle:@"确 定" forState:UIControlStateNormal];
        [clickBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        clickBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [clickBtn setBackgroundImage:[UIImage imageNamed:@"btn-confirm.png"] forState:UIControlStateNormal];
        [clickBtn setBackgroundImage:[UIImage imageNamed:@"btn-confirm-hover.png"] forState:UIControlStateHighlighted];
        [_backView addSubview:clickBtn];
        self.sureBtn = clickBtn;
    }
    return self;
}

- (void)delBtnClick:(UIButton *)btn
{
    [self removeDialog];
}

- (void)bgControlClick:(UIColor *)control
{
    [self removeDialog];
}

- (void)removeDialog
{
    self.hidden = YES;
    [self removeFromSuperview];
}

- (void)dealloc
{
    self.bgControl = nil;
    self.lineView = nil;
    self.backView = nil;
    self.titTextLabel = nil;
    self.roundView = nil;
    self.sureBtn = nil;
}

@end
