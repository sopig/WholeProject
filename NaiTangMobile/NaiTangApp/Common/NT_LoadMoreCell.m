//
//  NT_LoadMoreCell.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_LoadMoreCell.h"

@implementation NT_LoadMoreCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.alpha = 1.0;
        self.opaque = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 40)];
        [self.contentView addSubview:label];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        if (isIpad) {
            label.width = SCREEN_WIDTH;
            label.backgroundColor = [UIColor clearColor];
            label.font = [UIFont systemFontOfSize:18];
        }
        self.label = label;

    }
    return self;
}

- (void)startLoading
{
    if (_activiter == nil) {
		_activiter = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activiter.frame = CGRectMake(80, 10, 20, 20);
	}
    self.label.text = NSLocalizedString(@"加载中...", @"");
	[self addSubview:_activiter];
	[_activiter startAnimating];
}

- (void)endLoading
{
    [_activiter stopAnimating];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
