//
//  NT_FinishedHeaderCell.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-13.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_FinishedHeaderCell.h"

@implementation NT_FinishedHeaderCell

@synthesize headerLabel = _headerLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        _headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 2, 200, 20)];
        _headerLabel.font = [UIFont boldSystemFontOfSize:12];
        _headerLabel.textColor = [UIColor blackColor];
        _headerLabel.tag = KFinishedHeadCellTag;
        [self.contentView addSubview:_headerLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
