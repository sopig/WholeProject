//
//  DataCell.m
//  libao
//
//  Created by 小远子 on 14-3-5.
//  Copyright (c) 2014年 wangxing. All rights reserved.
//

#import "DataCell.h"

@implementation DataCell
@synthesize imgView;
@synthesize titleText;
@synthesize briefLabel;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initLabelTitleImg];
    }
    return self;
}
- (void)initLabelTitleImg
{
    imgView = [[EGOImageView alloc] init];
    titleText = [[UILabel alloc] init];
    briefLabel = [[UILabel alloc] init];
    
    if (self.isTemp == NO) {
        
        titleText.frame = CGRectMake(self.frame.origin.x + 10, 5, self.frame.size.width - 20, 30);
        briefLabel.frame = CGRectMake(self.frame.origin.x + 10, titleText.frame.size.height + 5, titleText.frame.size.width, 40);
        
    }else{
        imgView.frame = CGRectMake(self.frame.origin.x + 10, 10, 80, 60);
        titleText.frame = CGRectMake(imgView.frame.size.width + 20, 5, self.frame.size.width - imgView.frame.size.width - 25, 30);
        briefLabel.frame = CGRectMake(imgView.frame.size.width + 20, titleText.frame.size.height + 5, titleText.frame.size.width, 40);
    }
    
    
    [self addSubview:imgView];
    
    titleText.textColor = [UIColor colorWithRed:33/255.0 green:33/255.0 blue:33/255.0 alpha:1.0];
    titleText.font = [UIFont fontWithName:@"Helvetica" size:13];
    [self addSubview:titleText];
    
    briefLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    briefLabel.font = [UIFont fontWithName:@"Helvetica" size:11];
    briefLabel.numberOfLines = 0;
    [self addSubview:briefLabel];
    
    UIView * v = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x, 79, self.frame.size.width, 1)];
    v.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha: 1];
    [self addSubview:v];
    
}




- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview)
    {
        [imgView cancelImageLoad];
    }
}
- (void)setImageURL:(NSString *)imageURL
{
    imgView.imageURL = [NSURL URLWithString:imageURL];
}
//无网络请求调用
- (void)setImageURL:(NSString *)imageURL strTemp:(NSString *)temp
{
    NSURL * url = [NSURL URLWithString:imageURL];
    [imgView imageUrl:url tempSTR:temp];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
