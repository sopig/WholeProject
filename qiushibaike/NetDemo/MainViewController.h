//
//  MainViewController.h
//  NetDemo
//
//  Created by 海锋 周  on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"
#import "SettingViewController.h"

@interface MainViewController : UIViewController
{
    UIView *m_helpView;                     
    UIImageView *helpimageView;             //帮助页面
    BOOL isShowHelp;                       //是否显示帮助 
    
    SettingViewController *m_settingView;  //设置页面
    ContentViewController *m_contentView;  //内容页面
    
    //未登陆显示
    UIImageView *headlogoView; //求是百科的logo
    UIButton *loginbtn;       //登陆按钮
    UIButton *regsiterbtn;    //注册按钮
    UIButton *helpbtn;        //帮助按钮  
    //登陆后显示
    UIButton *photobtn;      //有图有真相按钮
    UIButton *fourTypebtn;   //随便逛逛等按钮
    UIButton *writebtn;      //写糗事按钮
    UIButton *topbtn;        //左下角按钮
    UIButton *recentbtn;     //最新按钮
    UIButton *settingbtn;    //我的设置
    
   
    
}
@property (nonatomic,retain) UIView *m_helpView;
@property (nonatomic,retain) UIImageView *helpimageView;
@property (nonatomic,assign) BOOL isShowHelp;
@property (nonatomic,retain) ContentViewController *m_contentView;
@property (nonatomic,retain) SettingViewController *m_settingView;

@property (nonatomic,retain) UIImageView *headlogoView;
@property (nonatomic,retain) UIButton *loginbtn;    
@property (nonatomic,retain) UIButton *regsiterbtn; 
@property (nonatomic,retain) UIButton *helpbtn;   
@property (nonatomic,retain) UIButton *photobtn; 
@property (nonatomic,retain) UIButton *fourTypebtn; 
@property (nonatomic,retain) UIButton *writebtn; 
@property (nonatomic,retain) UIButton *topbtn;
@property (nonatomic,retain) UIButton *settingbtn;  
@property (nonatomic,retain) UIButton *recentbtn;


@end
