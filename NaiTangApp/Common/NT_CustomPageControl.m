//
//  NT_CustomPageControl.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-6.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_CustomPageControl.h"

@implementation NT_CustomPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _selectedImg = [UIImage imageNamed:@"dot-gray.png"];
        _unSelectedImg = [UIImage imageNamed:@"dot-light-gray.png"];
        //ios7
        _isCreated = YES;
    }
    return self;
}
-(void) updateDots
{
    NSArray *subview = self.subviews;
    
    if (_isCreated&&[subview count]>0)
    {
        //在iOS7 [subview objectAtIndex:i]的类型是UIView,而不是UIImageView
        for (int i = 0; i<[subview count]; i++)
        {
            UIView *bgView = [subview objectAtIndex:i];
            UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0.f, 0.f, 8.f, 8.f)];
            image.tag = 1000 + i;
            [bgView addSubview:image];
            image.image = self.currentPage == i ? _selectedImg : _unSelectedImg;
        }
        _isCreated = NO;
    }
    else
    {
        for (int i = 0; i < [subview count]; i++)
        {
            UIView *bgView = [subview objectAtIndex:i];
            UIImageView *image = (UIImageView *)[bgView viewWithTag:1000 + i];
            image.image = self.currentPage == i ? _selectedImg : _unSelectedImg;
        }
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self updateDots];
}
-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}

@end
