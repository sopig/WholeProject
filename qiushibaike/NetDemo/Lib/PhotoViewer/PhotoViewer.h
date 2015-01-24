//
//  PhotoViewer.h
//  NetDemo
//
//  Created by 海锋 周 on 12-6-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGOImageView.h"
@interface PhotoViewer : UIViewController<EGOImageViewDelegate,UIGestureRecognizerDelegate>
{
    NSString *imgUrl;
    EGOImageView *imageView;
    CGFloat roation;
    CGFloat scale;
}

@property (nonatomic,retain) EGOImageView *imageView;
@property (nonatomic,retain) NSString *imgUrl;
-(void) fadeOut;
-(void) fadeIn;

@end
