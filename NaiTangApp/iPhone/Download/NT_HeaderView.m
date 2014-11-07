//
//  NT_HeaderView.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-11.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_HeaderView.h"
#import "UIProgressBar.h"
#import "NT_DownloadManager.h"

@implementation NT_HeaderView

@synthesize backImageView = _backImageView;
@synthesize usedLabel = _usedLabel;
@synthesize unUsedLabel = _unUsedLabel;
@synthesize editButton = _editButton;
@synthesize allStartButton = _allStartButton;
@synthesize progressView = _progressView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        //背景图片
        UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
        backImageView.image = [UIImage imageNamed:@"white-bg.png"];
        [self addSubview:backImageView];
        
        //已用图片
        UIImageView *usedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(14, 21, 7, 7)];
        usedImageView.image = [UIImage imageNamed:@"rect-green.png"];
        [self addSubview:usedImageView];
        
        //已用空间
        _usedLabel = [[UILabel alloc] initWithFrame:CGRectMake(usedImageView.right+4, 13, 100, 20)];
        _usedLabel.font = [UIFont systemFontOfSize:12];
        _usedLabel.text = @"已用5.1G";
        _usedLabel.textColor = Text_Color;
        _usedLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_usedLabel];
        
        //空闲图片
        UIImageView *unUsedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(_usedLabel.right-20, 21, 7, 7)];
        unUsedImageView.image = [UIImage imageNamed:@"rect-gray.png"];
        [self addSubview:unUsedImageView];
        
        //空闲空间
        _unUsedLabel = [[UILabel alloc] initWithFrame:CGRectMake(unUsedImageView.right+4, 13, 100, 20)];
        _unUsedLabel.font = [UIFont systemFontOfSize:12];
        _unUsedLabel.text = @"空闲22G";
        _unUsedLabel.backgroundColor = [UIColor clearColor];
        _unUsedLabel.textColor = Text_Color;
        [self addSubview:_unUsedLabel];
        
        //编辑按钮
        _editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _editButton.frame = CGRectMake(_unUsedLabel.right-30, 10, 54, 29);
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        //[_editButton setTitleColor:[UIColor colorWithHex:@"#a3aaad"] forState:UIControlStateNormal];
        [_editButton setTitleColor:Text_Color forState:UIControlStateNormal];
        [_editButton setBackgroundImage:[UIImage imageNamed:@"btn-white.png"] forState:UIControlStateNormal];
        [_editButton setBackgroundImage:[UIImage imageNamed:@"btn-white-hover.png"] forState:UIControlStateHighlighted];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_editButton];
        
        //全部开始按钮
        _allStartButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _allStartButton.frame = CGRectMake(_editButton.right+4, 10, 74, 29);
        [_allStartButton setTitle:@"全部暂停" forState:UIControlStateNormal];
        [_allStartButton setBackgroundImage:[UIImage imageNamed:@"btn-blue.png"] forState:UIControlStateNormal];
        [_allStartButton setBackgroundImage:[UIImage imageNamed:@"btn-blue-hover.png"] forState:UIControlStateHighlighted];
        _allStartButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_allStartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_allStartButton];
        
        //重设编辑frame
        _editButton.frame = CGRectMake(frame.size.width-65, 10, 54, 29);
        _allStartButton.hidden = YES;
        
        /*
         //磁盘空间
         _progressView = [[UIProgressBar alloc] initWithFrame:CGRectMake(10, _allStartButton.bottom+10, 300, 10)];
         _progressView.minValue = 0;
         _progressView.currentValue = 1;
         [_progressView setLineColor:[UIColor whiteColor]];
         _progressView.progressColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sd_card.png"]];
         _progressView.progressRemainingColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray-line.png"]];
         [self addSubview:_progressView];
         */
        
        //分割线，若滑动时显示分割线，需要cell高度-1，不然往上滑动时，无分割线
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 47.5, SCREEN_WIDTH, 0.5)];
        view.backgroundColor = [UIColor colorWithHex:@"#f0f0f0"];
        [self addSubview:view];
    }
    return self;
}

//刷新空间数据
- (void)refreshHeaderData
{
    NSString* path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] ;
    //    showAlert(path);
    NSFileManager* fileManager = [[NSFileManager alloc ]init];
    NSDictionary *fileSysAttributes = [fileManager attributesOfFileSystemForPath:path error:nil];
    
    //获取剩余空间
    NSNumber *freeSpace = [fileSysAttributes objectForKey:NSFileSystemFreeSize];
    
    //空闲空间
    [[NSUserDefaults standardUserDefaults] setObject:freeSpace forKey:KFreeSpace];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //获取总空间
    NSNumber *totalSpace = [fileSysAttributes objectForKey:NSFileSystemSize];
    
    //获取已用空间
    NSNumber *usedSpace = [NSNumber numberWithLongLong:([totalSpace longLongValue] - [freeSpace longLongValue])];
    
    //已用空间
    NSString *usedSpaceString = [NSString stringWithFormat:@"已用%0.1fG",([totalSpace longLongValue] - [freeSpace longLongValue])/1024.0/1024.0/1024.0];
    
    self.usedLabel.text = usedSpaceString;
    self.unUsedLabel.text = [NSString stringWithFormat:@"空闲%0.1fG",([freeSpace longLongValue])/1024.0/1024.0/1024.0];
    
    self.progressView.maxValue = ([totalSpace longLongValue]/1024.0/1024.0/1024.0);
    self.progressView.currentValue = ([usedSpace longLongValue]/1024.0/1024.0/1024.0);
    
}

@end
