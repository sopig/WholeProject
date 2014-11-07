//
//  NT_NoNetworkView.m
//  NaiTangApp
//
//  Created by 张正超 on 14-4-10.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_NoNetworkView.h"

@implementation NT_NoNetworkView

@synthesize networkButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)loadNoNetworkView
{
    networkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    networkButton.frame = CGRectMake((self.width-112)/2, (self.height-96)/2, 112, 96);
    [networkButton setBackgroundImage:[UIImage imageNamed:@"no-network.png"] forState:UIControlStateNormal];
    [networkButton setBackgroundImage:[UIImage imageNamed:@"no-network-hover.png"] forState:UIControlStateHighlighted];
    //[networkButton addTarget:self action:@selector(networkButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:networkButton];
    
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(networkButton.left+15, networkButton.bottom + 10, 100, 20)];
    label1.font = [UIFont systemFontOfSize:12];
    label1.textColor = [UIColor colorWithHex:@"#999999"];
    label1.text = @"网络加载失败";
    [self addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(networkButton.left+5, label1.bottom, 100, 20)];
    label2.text = @"请检查网络连接...";
    label2.font = [UIFont systemFontOfSize:12];
    label2.textColor = [UIColor colorWithHex:@"#999999"];
    [self addSubview:label2];

}

@end
