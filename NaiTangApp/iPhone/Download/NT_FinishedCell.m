//
//  NT_FinishedCell.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-13.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_FinishedCell.h"
#import "UIImageView+WebCache.h"
#import "NT_CustomButtonStyle.h"

@implementation NT_FinishedCell

@synthesize versionSizeLabel = _versionSizeLabel;
@synthesize dateLabel = _dateLabel;
@synthesize installedButton = _installedButton;
@synthesize model = _model;
@synthesize customButtonStyle = _customButtonStyle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _customButtonStyle = [[NT_CustomButtonStyle alloc] init];
        
        //版本和大小显示
        _versionSizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, 40, 240, 20)];
        _versionSizeLabel.font = [UIFont systemFontOfSize:12];
        _versionSizeLabel.textColor = Text_Color;
        _versionSizeLabel.tag = KFinishedVersionSizeTag;
        [self.contentView addSubview:_versionSizeLabel];
        
        //日期
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, _versionSizeLabel.bottom, 200, 20)];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        _dateLabel.textColor = Text_Color;
        _dateLabel.tag = KFinishedDateTag;
        [self.contentView addSubview:_dateLabel];
       
        //安装或重装按钮
        _installedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        //_installedButton.frame = CGRectMake(SCREEN_WIDTH-(54+15), 22, 54, 29);
        _installedButton.frame = CGRectMake(SCREEN_WIDTH-(54+10), 22, 54, 29);
        /*
        [_installedButton setBackgroundImage:[UIImage imageNamed:@"btn-blue.png"] forState:UIControlStateNormal];
        [_installedButton setBackgroundImage:[UIImage imageNamed:@"btn-blue-hover.png"] forState:UIControlStateHighlighted];
        [_installedButton setTitle:@"安装" forState:UIControlStateNormal];
        [_installedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         */
        [_installedButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        _installedButton.tag = KFinishedInstallButtonTag;
        [self.contentView addSubview:_installedButton];
        
        /*
        //分割线，若滑动时显示分割线，需要cell高度-1，不然往上滑动时，无分割线
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 70.5, SCREEN_WIDTH, 0.5)];
        view.backgroundColor = [UIColor colorWithHex:@"#f0f0f0"];
        [self.contentView addSubview:view];
         */
    }
    return self;
}

- (void)refreshFinishedData:(NT_DownloadModel *)model
{
    //by 张正超 使用图片缓存方式显示
    [self.iconView setImageURL:[NSURL URLWithString:model.iconName]];
    /*
    BOOL isFirst = [[NSUserDefaults standardUserDefaults] boolForKey:KIsFirstFinishedImage];
    if (!isFirst)
    {
        //若是第一次显示下载中，则加载图片
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:KIsFirstFinishedImage];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //by 张正超 使用图片缓存方式显示
        [self.iconView setImageURL:[NSURL URLWithString:model.iconName]];
    }
    else
    {
        //第二次使用缓存图片
        [self.iconView imageUrl:[NSURL URLWithString:model.iconName] tempSTR:@"false"];
    }
*/
    //[self.iconView setImageWithURL:[NSURL URLWithString:model.iconName] placeholderImage:[UIImage imageNamed:@"default-icon.png"]];
    

    self.nameLabel.text = model.gameName;
    _versionSizeLabel.text = [NSString stringWithFormat:@"版本:%@  大小:%@",model.version,NSStringFromSize(model.fileSize)];
    _dateLabel.text = model.installDate;
    //_installedButton.hidden = NO;
    if (model.buttonStatus == deleteOn)
    {
        [_customButtonStyle customButton:_installedButton title:@"删除" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] bgImage:[UIImage imageNamed:@"btn-read.png"] highlightedImage:[UIImage imageNamed:@"btn-read-hover.png"]];
    }
    else
    {
        
        if (model.loadType == FINISHED)
        {
            [_customButtonStyle customButton:_installedButton title:@"安装" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] bgImage:[UIImage imageNamed:@"btn-blue.png"] highlightedImage:[UIImage imageNamed:@"btn-blue-hover.png"]];
            //_installedButton.hidden = YES;
        }
        else if (model.loadType == INSTALLFAILED)
        {
            _dateLabel.textColor = [UIColor redColor];
            _dateLabel.text = @"安装失败";
            
            [_customButtonStyle customButton:_installedButton title:@"安装" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] bgImage:[UIImage imageNamed:@"btn-blue.png"] highlightedImage:[UIImage imageNamed:@"btn-blue-hover.png"]];
            //[_customButtonStyle customButton:_installedButton title:@"重装" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] bgImage:[UIImage imageNamed:@"btn-blue.png"] highlightedImage:[UIImage imageNamed:@"btn-blue-hover.png"]];
        }
        else if (model.loadType == INSTALLING)
        {
            [_customButtonStyle customButton:_installedButton title:@"安装中" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] bgImage:[UIImage imageNamed:@"btn-blue.png"] highlightedImage:[UIImage imageNamed:@"btn-blue-hover.png"]];
            
        }
        else if (model.loadType == INSTALLFINISHED)
        {
            //若已安装为越狱的，则可以重装
            [_customButtonStyle customButton:_installedButton title:@"安装" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] bgImage:[UIImage imageNamed:@"btn-blue.png"] highlightedImage:[UIImage imageNamed:@"btn-blue-hover.png"]];
            //[_customButtonStyle customButton:_installedButton title:@"重装" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] bgImage:[UIImage imageNamed:@"btn-blue.png"] highlightedImage:[UIImage imageNamed:@"btn-blue-hover.png"]];
            /*
            if ([[UIDevice currentDevice] isJailbroken])
            {
                //若已安装为越狱的，则可以重装
                [_customButtonStyle customButton:_installedButton title:@"重装" titleColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:12] bgImage:[UIImage imageNamed:@"btn-blue.png"] highlightedImage:[UIImage imageNamed:@"btn-blue-hover.png"]];
            }
            else
            {
                //正版的不能重装
                _installedButton.hidden = YES;
            }
            */
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
