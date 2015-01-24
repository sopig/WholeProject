//
//  NT_SearchHistoryCell.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_SearchHistoryCell.h"

@implementation NT_SearchHistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *backLabel = [[UILabel alloc] initWithFrame:self.bounds];
        backLabel.backgroundColor = [UIColor colorWithHex:@"#efefef"];
        [self addSubview:backLabel];
        self.backLabel = backLabel;
        
        UILabel *conTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 8, self.width-60, self.height-10)];
        conTextLabel.font = [UIFont systemFontOfSize:16];
        conTextLabel.backgroundColor = [UIColor clearColor];
        [backLabel addSubview:conTextLabel];
        self.conTextLabel = conTextLabel;
        
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow-right.png"]];
        rightImageView.center = CGPointMake(self.width - 30, self.height/2+3);
        rightImageView.backgroundColor = [UIColor clearColor];
        [backLabel addSubview:rightImageView];
        
        /*
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-2, SCREEN_WIDTH, 1)];
        line.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        line.backgroundColor = COLOR_WITH_RGB(216, 216, 216);
        [backLabel addSubview:line];
        UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-1, SCREEN_WIDTH, 1)];
        line2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        line2.backgroundColor = COLOR_WITH_RGB(251, 251, 251);
        [backLabel addSubview:line2];
         */
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    [UIView animateWithDuration:3 animations:^{
        self.backLabel.backgroundColor = highlighted?[UIColor grayColor]:COLOR_WITH_RGB(239, 239, 239);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    [UIView animateWithDuration:3 animations:^{
        self.backLabel.backgroundColor = selected?[UIColor grayColor]:COLOR_WITH_RGB(239, 239, 239);
    }];
}

@end
