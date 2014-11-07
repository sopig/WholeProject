//
//  SwitchTableView.m
//  GAMENEWS
//
//  Created by 小远子 on 14-2-27.
//  Copyright (c) 2014年 Hua Wang. All rights reserved.
//

#import "SwitchTableView.h"
#import "Reachability.h"
#import "AppDelegate_Def.h"
#import "DataService.h"



static SwitchTableView * shareSwitchTableView;

@implementation SwitchTableView


+ (SwitchTableView *)shareSwitchTableViewData
{
    @synchronized(self)
    {
        if (shareSwitchTableView == nil)
        {
            shareSwitchTableView = [[SwitchTableView alloc] init];
        }
    }
    return shareSwitchTableView;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        
        //请求网址                                            gamelist/index/2.html
        self.segUrlStr = @"http://dev.dedecms.7k7k.com/json/fahao/indexlist/pg/1.html";
        self.monUrlStr = @"http://w.7kapp.cn/zshtml/gamenews/gamelist/pc/1.html";
        self.magUrlStr = @"http://w.7kapp.cn/zshtml/gamenews/gamelist/gl/1.html";
        self.sceUrlStr = @"http://w.7kapp.cn/zshtml/gamenews/gamelist/sp/1.html";
        self.candyUrlStr = @"http://w.7kapp.cn/zshtml/gamenews/gamelist/wd/1.html";
        
    }
    return self;
}

- (NSString *)dealPicUrl:(NSString *)url requestNum:(int)requestNum
{
    NSString *urlStr = [url substringToIndex:(url.length - 6)];
    NSString *htmlStr = @".html";
    urlStr = [urlStr stringByAppendingFormat:@"%d%@", requestNum,htmlStr];
    return urlStr;
}
- (NSString *)dealPicOrMovieUrl:(NSString *)url requestNum:(int)requestNum
{
    NSString *urlStr = [url substringToIndex:(url.length - 6)];
    NSString *htmlStr = @".html";
    urlStr = [urlStr stringByAppendingFormat:@"%d%@", requestNum,htmlStr];
    urlStr = [urlStr substringFromIndex:(34)];
    return urlStr;
}

- (BOOL)isConnectionAvailable{
    
    BOOL isExistenceNetwork = YES;
    Reachability *reach = [Reachability reachabilityWithHostname:@"www.7kapp.cn"];
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork = NO;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            break;
    }
    return isExistenceNetwork;
}





@end
