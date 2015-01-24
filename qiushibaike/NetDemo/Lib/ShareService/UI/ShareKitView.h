//
//  ShareKitView.h
//  NetDemo
//
//  Created by 海锋 周 on 12-6-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShareKitView;
@protocol ShareKitViewDelegate <NSObject>
@optional
- (void)ShareKitView:(ShareKitView *)sharekit clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface ShareKitView : UIView
{
    id SKdelegate;
    UIImageView *imageViewBg;
}
@property (nonatomic,retain) UIImageView *imageViewBg;
@property(nonatomic, assign) id SKdelegate;
-(void) fadeOut;
-(void) fadeIn;
-(void) BtnClicked:(id)sender;
@end


