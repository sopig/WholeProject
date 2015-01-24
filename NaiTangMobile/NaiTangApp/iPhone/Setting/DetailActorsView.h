//
//  DetailActorsView.h
//  GameGuide
//
//  Created by 邹高成 on 13-12-23.
//  Copyright (c) 2013年 Hua Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailActorsView : UIView<UITableViewDelegate>
{
    NSArray *actorsArray;
    CGFloat superWidth;
    NSString *newVersionPath;
    
}
@property (nonatomic, strong) UILabel * titleLabel;

@end
