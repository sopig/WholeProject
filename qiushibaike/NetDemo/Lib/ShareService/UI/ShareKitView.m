//
//  ShareKitView.m
//  NetDemo
//
//  Created by 海锋 周 on 12-6-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ShareKitView.h"

@implementation ShareKitView
@synthesize imageViewBg;
@synthesize SKdelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.f;
        UIImage *imgbg = [UIImage imageNamed:@"forward_background"];
        imageViewBg= [[UIImageView alloc]initWithImage:imgbg];
        [imageViewBg setFrame:CGRectMake(0, 0 , imgbg.size.width/2,imgbg.size.height/2)];
        imageViewBg.center = CGPointMake(self.center.x, -self.center.y);
        [imageViewBg setUserInteractionEnabled:YES];
        [self setUserInteractionEnabled:YES];
        [self addSubview:imageViewBg];
        [imageViewBg release];
        [imgbg release];
        
        NSArray *array = [NSArray arrayWithObjects:@"tencent",@"sina",@"renren",@"qzone",@"mail",@"copy",nil];
        for (int i=0; i<[array count]; i++) 
        {
            UIImage *normal = [UIImage imageNamed:[NSString stringWithFormat:@"forward_%@.png",[array objectAtIndex:i]]];
            UIImage *active = [UIImage imageNamed:[NSString stringWithFormat:@"forward_%@_active.png",[array objectAtIndex:i]]];
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(15+60*(i%3),25+60*(i/3),54,54)];
            [btn setImage:normal forState:UIControlStateNormal];
            [btn setImage:active forState:UIControlStateHighlighted];
            [btn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTag:i];
            [imageViewBg addSubview:btn];
            [normal release];
            [active release];
        }
     
    }
    return self;
}

-(void) fadeIn
{
    [UIView animateWithDuration:1.0f animations:^{
          self.alpha = 0.8f;
          imageViewBg.center = self.center;
    } completion:^(BOOL finished) {
          
    }];
}

-(void) fadeOut
{
    [UIView animateWithDuration:1.0f animations:^{
          self.alpha = 0.f;
         imageViewBg.center = CGPointMake(self.center.x, -self.center.y);
    } completion:^(BOOL finished) {
        [imageViewBg release];
        imageViewBg = nil;
        [self removeFromSuperview];
    }];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    //点击其他地方消失
    if (!CGRectContainsPoint([imageViewBg frame], pt)) {
        if (SKdelegate) {
            if ([SKdelegate respondsToSelector:@selector(ShareKitView:clickedButtonAtIndex:)])
            {
                [SKdelegate ShareKitView:self clickedButtonAtIndex:-1];
            }else {
                NSLog(@"there is no delegate");
            }
        }else {
            NSLog(@"there is no delegate");
        }
        [self fadeOut];
    }
   
}


-(void) BtnClicked:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (SKdelegate) {
        if ([SKdelegate respondsToSelector:@selector(ShareKitView:clickedButtonAtIndex:)])
        {
            [SKdelegate ShareKitView:self clickedButtonAtIndex:btn.tag];
        }else {
            NSLog(@"there is no delegate");
        }
    }else {
        NSLog(@"there is no delegate");
    }
   
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
