//
//  NT_DetailIntroView.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-7.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_DetailIntroView.h"
#import "NT_BaseAppDetailInfo.h"

@implementation NT_DetailIntroView
@synthesize  infoView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    //分类
    //infoView = [[UIView alloc] initWithFrame:CGRectMake(0, infoView.height, SCREEN_WIDTH, infoView.height)];
    
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        /*
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        lineImageView.image = [UIImage imageNamed:@"line.png"];
        [self addSubview:lineImageView];
         */
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = [UIColor colorWithHex:@"#f0f0f0"];
        [self addSubview:lineView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 20)];
        titleLabel.text = @"游戏信息";
        titleLabel.font = [UIFont boldSystemFontOfSize:14];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = Text_Color_Title;
        [self addSubview:titleLabel];
        
        //兼容信息
        UIView *firmwareView = [[UIView alloc] initWithFrame:CGRectMake(0, 25, SCREEN_WIDTH, 30)];
        [self addSubview:firmwareView];
        
        UILabel *firmwareLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, 60, 20)];
        firmwareLabel.text = @"适用固件：";
        firmwareLabel.font = [UIFont systemFontOfSize:12];
        firmwareLabel.backgroundColor = [UIColor clearColor];
        firmwareLabel.textColor = Text_Color;
        [firmwareView addSubview:firmwareLabel];
        
        _jreLabel = [[UILabel alloc] initWithFrame:CGRectMake(firmwareLabel.right, 0, SCREEN_WIDTH-(firmwareLabel.right+10), 40)];
        _jreLabel.text = @"需要iOS6.0或更高版本";
        _jreLabel.numberOfLines = 2;
        _jreLabel.font = [UIFont systemFontOfSize:12];
        _jreLabel.backgroundColor = [UIColor clearColor];
        _jreLabel.textColor = Text_Color;
        [firmwareView addSubview:_jreLabel];
        
        //分类
        infoView = [[UIView alloc] initWithFrame:CGRectMake(0, firmwareView.bottom, SCREEN_WIDTH, 120)];
        [self addSubview:infoView];
        
        UILabel *labelCategory = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 60, 20)];
        labelCategory.text = @"分  类：";
        labelCategory.font = [UIFont systemFontOfSize:12];
        labelCategory.textColor = Text_Color;
        [infoView addSubview:labelCategory];
        
        _categoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelCategory.right, 10, 200, 20)];
        _categoryLabel.text = @"角色扮演";
        _categoryLabel.textColor = Text_Color;
        _categoryLabel.font = [UIFont systemFontOfSize:12];
        [infoView addSubview:_categoryLabel];
        
        UILabel *labelSize = [[UILabel alloc] initWithFrame:CGRectMake(labelCategory.left, labelCategory.bottom, labelCategory.width, labelCategory.height)];
        labelSize.font = [UIFont systemFontOfSize:12];
        labelSize.text = @"大  小：";
        labelSize.textColor = Text_Color;
        [infoView addSubview:labelSize];
        
        _sizeLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelSize.right, labelCategory.bottom, _categoryLabel.width, labelCategory.height)];
        _sizeLabel.text = @"23MB";
        _sizeLabel.font = [UIFont systemFontOfSize:12];
        _sizeLabel.textColor = Text_Color;
        [infoView addSubview:_sizeLabel];
        
        UILabel *labelLanguage = [[UILabel alloc] initWithFrame:CGRectMake(labelCategory.left, labelSize.bottom, labelCategory.width, labelCategory.height)];
        labelLanguage.font = [UIFont systemFontOfSize:12];
        labelLanguage.text = @"语  言";
        labelLanguage.textColor = Text_Color;
        [infoView addSubview:labelLanguage];
        
        _languageLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelLanguage.right, labelSize.bottom, _categoryLabel.width, labelCategory.height)];
        _languageLabel.text = @"中文";
        _languageLabel.textColor = Text_Color;
        _languageLabel.font = [UIFont systemFontOfSize:12];
        [infoView addSubview:_languageLabel];
        
        UILabel *labelDev = [[UILabel alloc] initWithFrame:CGRectMake(labelCategory.left, labelLanguage.bottom, labelCategory.width, labelCategory.height)];
        labelDev.font = [UIFont systemFontOfSize:12];
        labelDev.textColor = Text_Color;
        labelDev.text = @"开 发 商：";
        [infoView addSubview:labelDev];
        
        _devLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelDev.right, labelLanguage.bottom, 240, labelCategory.height)];
        _devLabel.text = @"EA SWiss";
        _devLabel.textColor = Text_Color;
        _devLabel.font = [UIFont systemFontOfSize:12];
        [infoView addSubview:_devLabel];
        
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(labelCategory.left, labelDev.bottom, SCREEN_WIDTH-20,60)];
        _detailLabel.font = [UIFont systemFontOfSize:12];
        _detailLabel.numberOfLines = 3;
        _detailLabel.textColor = Text_Color;
        _detailLabel.text = @"这是一款策略塔防游戏";
        [infoView addSubview:_detailLabel];
        
        
        //展开按钮
        _expansionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _expansionButton.frame = CGRectMake(0, infoView.bottom+firmwareLabel.bottom+10, SCREEN_WIDTH, 21);
        [_expansionButton setImage:[UIImage imageNamed:@"expansion.png"] forState:UIControlStateNormal];
        [_expansionButton setImage:[UIImage imageNamed:@"expansion-hover.png"] forState:UIControlStateHighlighted];
        [_expansionButton addTarget:self action:@selector(expansionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_expansionButton];
    }
    return self;
}

//加载游戏介绍信息
- (void)refreshIntroData:(NT_BaseAppDetailInfo *)info isExpansion:(BOOL)flag
{
    NT_GameInfo *gameInfo = info.gameInfo;
    self.jreLabel.text = gameInfo.jre;
    self.categoryLabel.text = gameInfo.categoryName;
    self.sizeLabel.text = gameInfo.size;
    self.languageLabel.text = gameInfo.lang;
    self.devLabel.text = gameInfo.devName;
    
    NSLog(@"summary:%@",gameInfo.summary);
    //解析html格式为换行
    NSString *p = [gameInfo.summary stringByReplacingOccurrencesOfString:@"<p>" withString:@"\r\n"];
    p = [p stringByReplacingOccurrencesOfString:@"</p>" withString:@"\r\n"];
    
    p = [p stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@"\t"];
    
    p = [p stringByReplacingOccurrencesOfString:@"<br />" withString:@"\r"];
    self.detailLabel.text = p;
    
    
    
    CGSize size = [self.detailLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(self.detailLabel.width, MAXFLOAT)];
    
    if (flag)
    {
        //展开
        self.detailLabel.frame = CGRectMake(10, self.devLabel.bottom+5, SCREEN_WIDTH-20,20);
        self.detailLabel.height = size.height;
        self.detailLabel.numberOfLines = 0;
        if (self.expansionButton)
        {
            [self.expansionButton removeFromSuperview];
        }
    }
}

//展开按钮
- (void)expansionButtonPressed:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    CGSize size = [self.detailLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(self.detailLabel.width, MAXFLOAT)];
    
    self.isExpansion = YES;
    //self.isExpansion = !self.isExpansion;
    if (self.isExpansion)
    {
        //展开
        _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _devLabel.bottom, SCREEN_WIDTH-20,20)];
        self.detailLabel.height = size.height;
        NSLog(@"detail height:%f",self.detailLabel.height);
        self.detailLabel.numberOfLines = 0;
        
        // 更新introView的高度
        //self.height=self.height + self.detailLabel.height;
        
        //展开更多简介信息
        CGFloat totalHeight = size.height;
        
        //移除按钮
        [btn removeFromSuperview];
        
        //移除按钮后的 info view展开高度
        self.height = totalHeight - 21;
        /*
         btn.top = 208 + self.detailLabel.height;
         [btn setImage:[UIImage imageNamed:@"collapse.png"] forState:UIControlStateNormal];
         [btn setImage:[UIImage imageNamed:@"collapse-hover.png"] forState:UIControlStateHighlighted];
         
         CGFloat totalHeight = btn.top+btn.height;
         NSLog(@"btn total height:%f",totalHeight);
         */
        //委托传递展开高度
        if (self.delegate&&[self.delegate respondsToSelector:@selector(expansionDetailInfoViewDelegate:expansion:)])
        {
            [self.delegate expansionDetailInfoViewDelegate:self.height expansion:YES];
        }
    }
}

@end
