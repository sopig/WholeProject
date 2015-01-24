//
//  NT_SearchNoDataCell.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_SearchNoDataCell.h"

@implementation NT_SearchNoDataCell

@synthesize searchKeywordLabel = _searchKeywordLabel;
@synthesize searchLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithHex:@"#efefef"];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
        titleLabel.text = @"您搜索的“";
        titleLabel.textColor = Text_Color;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:titleLabel];
        
        _searchKeywordLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleLabel.right, 10, 120, 30)];
        _searchKeywordLabel.tag = KSearchKeywordTag;
        _searchKeywordLabel.font = [UIFont systemFontOfSize:14];
        _searchKeywordLabel.textAlignment = TEXT_ALIGN_LEFT;
        _searchKeywordLabel.textColor = [UIColor colorWithHex:@"#1eb5f7"];
        _searchKeywordLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_searchKeywordLabel];
        
        
        searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(_searchKeywordLabel.right, 10, 120, 30)];
        searchLabel.tag = KSearchTipTag;
        searchLabel.font = [UIFont systemFontOfSize:14];
        searchLabel.textColor = Text_Color;
        searchLabel.backgroundColor = [UIColor clearColor];
        searchLabel.text = @"”,暂无匹配结果";
        [self.contentView addSubview:searchLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
