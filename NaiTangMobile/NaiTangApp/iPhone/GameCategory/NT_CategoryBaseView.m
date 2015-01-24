//
//  NT_CategoryBaseView.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-13.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_CategoryBaseView.h"
#import "UIImageView+WebCache.h"

@implementation NT_CategoryBaseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    
        _iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _iconButton.frame = self.bounds;
        _iconButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        [self addSubview:_iconButton];
        
        //分类名称
        _categoryNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, _iconButton.width-70, 20)];
        _categoryNameLabel.font = [UIFont systemFontOfSize:16];
        _categoryNameLabel.textColor = Text_Color_Title;
        [_iconButton addSubview:_categoryNameLabel];
        
        //分类类型
        _categoryTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, 60, 20)];
        _categoryTypeLabel.font = [UIFont systemFontOfSize:10];
        _categoryTypeLabel.textColor = Text_Color;
        [_iconButton addSubview:_categoryTypeLabel];
        
        //分类数量
        _categoryCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 46, _categoryTypeLabel.width, 20)];
        _categoryCountLabel.font = [UIFont systemFontOfSize:10];
        _categoryCountLabel.textColor = [UIColor colorWithHex:@"#1eb5f7"];
        [_iconButton addSubview:_categoryCountLabel];
        
        //图片
        //_categoryImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-67, 7, 57, 57)];
        _categoryImageView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"default-icon.png"]];
        _categoryImageView.frame = CGRectMake(self.width-67, 7, 57, 57);
        /*
        _categoryImageView.layer.cornerRadius = 10;
        _categoryImageView.layer.masksToBounds = YES;
         */
        [_iconButton addSubview:_categoryImageView];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width-67, 7, 57, 57)];
        imageView.image = [UIImage imageNamed:@"round-corner.png"];
        [_iconButton addSubview:imageView];
    }
    return self;
}

//分类值
- (void)refreshCategoryData:(NT_CategoryInfo *)categoryInfo
{
    self.categoryNameLabel.text = categoryInfo.title;
    self.categoryCountLabel.text = categoryInfo.gameCount;
    self.categoryTypeLabel.text = categoryInfo.subtitle;
    //[self.categoryImageView setImageWithURL:[NSURL URLWithString:categoryInfo.pic] placeholderImage:[UIImage imageNamed:@"default-icon.png"]];
    [self.categoryImageView setImageURL:[NSURL URLWithString:categoryInfo.pic]];
}

@end
