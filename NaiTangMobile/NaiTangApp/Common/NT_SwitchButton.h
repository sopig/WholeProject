//
//  NT_SwitchButton.h
//  NaiTangApp
//
//  Created by 张正超 on 14-4-8.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NT_SwitchButton : UIButton

@property (nonatomic,strong)UIImage *onImg,*offImg;
@property (nonatomic,assign)BOOL isChecked;

@end
