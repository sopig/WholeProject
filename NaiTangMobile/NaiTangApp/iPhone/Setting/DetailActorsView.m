//
//  DetailActorsView.m
//  GameGuide
//
//  Created by 邹高成 on 13-12-23.
//  Copyright (c) 2013年 Hua Wang. All rights reserved.
//

#import "DetailActorsView.h"
#import "AppDelegate_Def.h"
#import "UIView+Additions.h"
#import "AppDelegate_Def.h"


@implementation DetailActorsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        actorsArray = [NSMutableArray arrayWithCapacity:0];
        [self initViews];
    }
    return self;
}

- (void)initViews
{
    self.backgroundColor = [UIColor colorWithRed:245/255.0 green:242/255.0 blue:237/255.0 alpha:1.0];
    
    UIView  * customNavView = [[UIView alloc]init];
    UILabel * titleLabel = [[UILabel alloc] init];
    UIButton * returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIView  * contentView = [[UIView alloc]init];
    UILabel * aboutLabel = [[UILabel alloc] init];
    UILabel * contactLabel = [[UILabel alloc] init];
    UIImageView  *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon.png"]];
    UIButton * checkupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton * goodBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    

    //适配
    //CGFloat height = 568;
    CGFloat superHeight = self.bounds.size.height;
//    if (iPad || iPad4) {
//        superWidth = 768;
//    } else
//    {
        superWidth = 320;
//    }
    
    if (superHeight == 480) {
        //superHeight = height;
    }
    
    customNavView.frame = CGRectMake(0, 0, superWidth, 65);
    contentView.frame = CGRectMake(20, 90, 300, 300);
    titleLabel.frame = CGRectMake(0, 20, superWidth, 44);
//    if(iPad || iPad4){
//        contentView.frame = CGRectMake(240, 150, 300, 300);
//    }
    imageView.frame = CGRectMake(90, 0, 100, 100);
    aboutLabel.frame = CGRectMake(40, 110, 200, 50);
    checkupBtn.frame = CGRectMake(32, 180, 220, 40);
    goodBtn.frame = CGRectMake(32, 230, 220, 40);
    contactLabel.frame = CGRectMake(35, 290, 210, 50);
    
    
    customNavView.userInteractionEnabled = YES;
    customNavView.backgroundColor = NAV_UICOLOR;
    [self addSubview:customNavView];
    [self addSubview:contentView];
    
    titleLabel.text = @"关于我们";
    titleLabel.userInteractionEnabled = YES;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    titleLabel.textColor = [UIColor whiteColor];
    [customNavView addSubview:titleLabel];
    
    
    
    [returnBtn setImage:[UIImage imageNamed:@"btn-nav-back.png"] forState:UIControlStateNormal];
    returnBtn.tag = 5;
    returnBtn.frame = CGRectMake(15, 10, 50, 25);
    [returnBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [titleLabel addSubview:returnBtn];
    
     self.backgroundColor = [UIColor colorWithRed:245/255.0 green:242/255.0 blue:237/255.0 alpha:1.0];
    
    imageView.layer.cornerRadius=15.0;
    imageView.layer.masksToBounds=YES;
    [contentView addSubview:imageView];
    
    NSString *string;
    string = [NSString stringWithFormat:@"%@\n%@", @"7k7k游戏", AppVersion];
    aboutLabel.text = string;
    aboutLabel.userInteractionEnabled = YES;
    aboutLabel.backgroundColor = [UIColor clearColor];
    aboutLabel.textAlignment = NSTextAlignmentCenter;
    aboutLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    aboutLabel.textColor = [UIColor blackColor];
    aboutLabel.lineBreakMode = UILineBreakModeWordWrap;
    aboutLabel.numberOfLines = 0;
    [contentView addSubview:aboutLabel];
    
    checkupBtn.backgroundColor = [UIColor whiteColor];
    [checkupBtn setTitle:@"检查更新" forState:UIControlStateNormal];
    checkupBtn.showsTouchWhenHighlighted = YES;
    [checkupBtn addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    [checkupBtn.layer setMasksToBounds:YES];
    [checkupBtn.layer setCornerRadius:9.0];
//    checkupBtn.backgroundColor = [UIColor whiteColor];
    checkupBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
    [checkupBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [contentView addSubview:checkupBtn];
    

    
    
    
    goodBtn.backgroundColor = [UIColor whiteColor];
    NSString * tmpstring = [NSString stringWithFormat:@"%@%@", AppNickname,@"，给个好评吧!"];
    [goodBtn setTitle:tmpstring forState:UIControlStateNormal];
    goodBtn.showsTouchWhenHighlighted = YES;
    [goodBtn addTarget:self action:@selector(btnHref:) forControlEvents:UIControlEventTouchUpInside];
    [goodBtn.layer setMasksToBounds:YES];
    [goodBtn.layer setCornerRadius:9.0];
    goodBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
//    goodBtn.backgroundColor = [UIColor whiteColor];
    [goodBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
    [contentView addSubview:goodBtn];
    
    
    contactLabel.text = @"7k7k.com出品";
    contactLabel.userInteractionEnabled = YES;
    contactLabel.backgroundColor = [UIColor clearColor];
    contactLabel.textAlignment = NSTextAlignmentCenter;
    contactLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    contactLabel.textColor = [UIColor blackColor];
    contactLabel.lineBreakMode = UILineBreakModeWordWrap;
    contactLabel.numberOfLines = 0;
    [contentView addSubview:contactLabel];
}


- (void)butClick:(UIButton *)sender {
    //[MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
//    [MobClick checkUpdate];
}

- (void)updateMethod:(NSDictionary *)appInfo {
    if([[appInfo objectForKey:@"update"] isEqualToString:@"YES"]==YES) {
        NSString * newVersion = [[NSString alloc]initWithString:[appInfo objectForKey:@"version"]];
        
        newVersionPath = [[NSString alloc]initWithString:[appInfo objectForKey:@"path"]];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"有新版本V%@",newVersion] message:[NSString stringWithString:[appInfo objectForKey:@"update_log"]] delegate:self cancelButtonTitle:@"下次再说" otherButtonTitles:@"更新", nil];
        [alert show];
    }else {
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:nil message:@"当前已是最新版本" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alertview show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==1)
    {
        NSURL *url = [NSURL URLWithString:newVersionPath];
        [[UIApplication sharedApplication]openURL:url];
    }
}


- (void)btnHref:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:AppUrl]];
}


- (void)buttonAction:(UIButton *)btn
{
    [UIView animateWithDuration:.35 animations:^{
        self.frame = CGRectMake(superWidth, 0, superWidth, self.bounds.size.height);
    } completion:^(BOOL finished) {
        self.superview.hidden = YES;
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end




