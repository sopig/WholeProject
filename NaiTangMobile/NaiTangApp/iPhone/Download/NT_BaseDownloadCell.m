//
//  NT_BaseDownloadCell.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-9.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_BaseDownloadCell.h"

@implementation NT_BaseDownloadCell

@synthesize iconView = _iconView;
@synthesize nameLabel = _nameLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        //游戏图片
        //_iconView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 65, 65)];
        _iconView = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"default-icon.png"]];
        _iconView.frame = CGRectMake(10, 7, 57, 57);
        /*
        _iconView.layer.cornerRadius = 15;
        _iconView.clipsToBounds = YES;
         */
        [self.contentView addSubview:_iconView];
        
        //优化tableview，使用图片遮罩，圆角底图
        UIImageView *roundCornerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 7, 57, 57)];
        roundCornerImageView.image = [UIImage imageNamed:@"round-corner.png"];
        [self.contentView addSubview:roundCornerImageView];

        
        //游戏名称
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_iconView.right+10, 5, 150, 30)];
        _nameLabel.textColor = Text_Color_Title;
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
        [self.contentView addSubview:_nameLabel];
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
