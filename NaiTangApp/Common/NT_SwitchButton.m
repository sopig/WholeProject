//
//  NT_SwitchButton.m
//  NaiTangApp
//
//  Created by 张正超 on 14-4-8.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_SwitchButton.h"
#import <QuartzCore/QuartzCore.h>

@implementation NT_SwitchButton

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.onImg = [UIImage imageNamed:@"switch-on.png"];
        self.offImg = [UIImage imageNamed:@"switch-off.png"];
        self.layer.cornerRadius = self.height/2;
        self.clipsToBounds = YES;
        [self setBackgroundImage:self.offImg forState:UIControlStateNormal];
    }
    return self;
}

- (id)init
{
    if (self = [super init]) {
        self.onImg = [UIImage imageNamed:@"switch-on.png"];
        self.offImg = [UIImage imageNamed:@"switch-off.png"];
        self.layer.cornerRadius = self.height/2;
        self.clipsToBounds = YES;
        [self setBackgroundImage:self.offImg forState:UIControlStateNormal];
    }
    return self;
}

- (void)setIsChecked:(BOOL)isChecked
{
    _isChecked = isChecked;
    [self setBackgroundImage:isChecked?self.onImg:self.offImg forState:UIControlStateNormal];
}


@end
