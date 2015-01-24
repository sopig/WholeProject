//
//  LoginViewController.h
//  NetDemo
//
//  Created by 海锋 周  on 12-6-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHttpHeaders.h"
#import "CJSONDeserializer.h"
#import "tooles.h"
@interface LoginViewController : UIViewController<ASIHTTPRequestDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UITextField *username;
    UITextField *password;

}
@property (nonatomic,retain) UITextField *username;
@property (nonatomic,retain) UITextField *password;

@end
