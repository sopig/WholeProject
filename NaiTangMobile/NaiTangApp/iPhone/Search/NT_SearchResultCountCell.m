//
//  NT_SearchResultCountCell.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_SearchResultCountCell.h"

@implementation NT_SearchResultCountCell

@synthesize countLabel;
@synthesize label;
@synthesize searchKeywordLabel;
@synthesize searchLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithHex:@"#efefef"];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 30)];
        titleLabel.text = @"共搜索到";
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = Text_Color;
        [self.contentView addSubview:titleLabel];
        
        countLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 60, 30)];
        countLabel.font = [UIFont systemFontOfSize:14];
        countLabel.tag = KSearchCount;
        countLabel.backgroundColor = [UIColor clearColor];
        countLabel.textColor = [UIColor colorWithHex:@"#1eb5f7"];
        [self.contentView addSubview:countLabel];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, 40, 30)];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = Text_Color;
        label.backgroundColor = [UIColor clearColor];
        label.text = @"条与“";
        [self.contentView addSubview:label];
        
        searchKeywordLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.right, 10, 60, 30)];
        searchKeywordLabel.tag = KSearchValue;
        searchKeywordLabel.font = [UIFont systemFontOfSize:14];
        searchKeywordLabel.textColor = [UIColor colorWithHex:@"#1eb5f7"];
        searchKeywordLabel.textAlignment = TEXT_ALIGN_LEFT;
        searchKeywordLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:searchKeywordLabel];
        
        searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(searchKeywordLabel.right, 10, 100, 30)];
        searchLabel.font = [UIFont systemFontOfSize:14];
        searchLabel.textColor = Text_Color;
        searchLabel.backgroundColor = [UIColor clearColor];
        searchLabel.text = @"”相关的结果";
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
