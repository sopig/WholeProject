//
//  RightCell.m
//  GameGuide
//
//  Created by 邹高成 on 13-12-26.
//  Copyright (c) 2013年 Hua Wang. All rights reserved.
//

#import "RightCell.h"

@implementation RightCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initViews];
    }
    return self;
}



- (void)initViews
{
    
    self.tagImgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 25, 25)];
    self.tagImgView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tagImgView];
    
    self.rightLabelTitle = [[UILabel alloc] initWithFrame:CGRectMake(42, 0.5, self.frame.size.width, 44-0.5)];
    self.rightLabelTitle.backgroundColor = [UIColor clearColor];
    self.rightLabelTitle.textColor = [UIColor colorWithRed:42/255.0 green:42/255.0 blue:42/255.0 alpha: 1.0f];
    [self addSubview:_rightLabelTitle];

    
   // borderTop
//    UIView * borderTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
//    borderTop.backgroundColor = [UIColor colorWithRed:56/255.0 green:56/255.0 blue:58/255.0 alpha: 1];
//    [self addSubview:borderTop];
    
    // borderBottom
    self.borderBottom = [[UIView alloc] initWithFrame:CGRectMake(0, 44-1, self.frame.size.width, 1)];
    self.borderBottom.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha: 1];
    [self addSubview:self.borderBottom];
    
    // 高亮时的列表左侧红线
    self.contertListImage = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 4, 44)];
    [_contertListImage setHidden:YES];
    _contertListImage.backgroundColor = [UIColor redColor];
    [self addSubview:_contertListImage];
    

}
@end
