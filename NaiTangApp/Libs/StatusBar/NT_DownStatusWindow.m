//
//  NT_DownStatusWindow.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_DownStatusWindow.h"
#import "NT_Singleton.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImageView+WebCache.h"

@implementation NT_DownStatusWindow
SYNTHESIZE_SINGLETON_FOR_CLASS(NT_DownStatusWindow);

- (id)init
{
    if (self = [super initWithFrame:CGRectMake(0, -22, SCREEN_WIDTH, 22)]) {
        self.backgroundColor = [UIColor colorWithHex:@"#1eb5f7"];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.userInteractionEnabled = NO;
        [self setWindowLevel:UIWindowLevelStatusBar+11];
        
        //UIImageView *iconImg = [[UIImageView alloc] initWithFrame:CGRectMake(15, 2, 20, 18)];
        EGOImageView *iconImg = [[EGOImageView alloc] initWithPlaceholderImage:[UIImage imageNamed:@"default-icon.png"]];
        iconImg.frame = CGRectMake(15, 2, 20, 18);
        iconImg.layer.cornerRadius = 5;
        iconImg.clipsToBounds = YES;
        iconImg.backgroundColor = [UIColor clearColor];
        [self addSubview:iconImg];
        self.iconImg = iconImg;
        
        UILabel *leftText = [[UILabel alloc] initWithFrame:CGRectMake(iconImg.right+10, 0, 120, self.height)];
        leftText.textColor = [UIColor whiteColor];
        leftText.font = [UIFont systemFontOfSize:15];
        leftText.backgroundColor = [UIColor clearColor];
        [self addSubview:leftText];
        self.leftText = leftText;
        
        UILabel *rightText = [[UILabel alloc] initWithFrame:CGRectMake(self.width-200, 0, 190, self.height)];
        rightText.textColor = [UIColor whiteColor];
        rightText.font = [UIFont systemFontOfSize:15];
        rightText.backgroundColor = [UIColor clearColor];
        rightText.textAlignment = TEXT_ALIGN_RIGHT;
        [self addSubview:rightText];
        self.rightText = rightText;
    }
    return self;
}

- (void)checkArray
{
    if (self.array.count) {
        [self showMessageIconStr:self.array[0][@"iconImg"] leftText:self.array[0][@"leftText"] rightText:self.array[0][@"rightText"]];
        [self.array removeObjectAtIndex:0];
    }
}

- (void)showMessageIconStr:(NSString *)iconImg leftText:(NSString *)leftText rightText:(NSString *)rightText
{
    if (self.isShowing) {
        if (!self.array) {
            self.array = [NSMutableArray array];
        }
        [self.array addObject:@{@"iconImg":iconImg,@"leftText":leftText,@"rightText":rightText}];
        return;
    }
    //[self.iconImg setImageWithURL:[NSURL URLWithString:iconImg]];
    [self.iconImg imageUrl:[NSURL URLWithString:iconImg] tempSTR:@"false"];
    self.iconImg.layer.cornerRadius = 5;
    self.leftText.text = leftText;
    self.rightText.text = rightText;
    self.hidden = NO;
    self.isShowing = YES;
    self.leftText.alpha = 0;
    self.rightText.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.top += 22;
        self.leftText.alpha = 1;
        self.rightText.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 delay:2 options:UIViewAnimationOptionTransitionNone animations:^{
            self.top -= 22;
            self.leftText.alpha = 0;
            self.rightText.alpha = 0;
        } completion:^(BOOL finished) {
            self.hidden = YES;
            self.isShowing = NO;
            [self checkArray];
        }];
    }];
}

+ (void)showMessageIconStr:(NSString *)iconImg leftText:(NSString *)leftText rightText:(NSString *)rightText
{
    [[self sharedNT_DownStatusWindow] showMessageIconStr:iconImg leftText:leftText rightText:rightText];
}

- (void)dealloc
{
    self.array = nil;
    self.rightText = nil;
    self.leftText = nil;
}



@end
