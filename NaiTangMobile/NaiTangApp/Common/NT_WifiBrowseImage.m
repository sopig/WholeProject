//
//  NT_WifiBrowseImage.m
//  NaiTangApp
//
//  Created by 张正超 on 14-4-12.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_WifiBrowseImage.h"
#import "NT_MacroDefine.h"

@implementation NT_WifiBrowseImage

//  设置-打开或关闭wifi下浏览图片的处理方法
- (void)wifiBrowseImage:(EGOImageView *)appImageView urlString:(NSString *)url
{
    // 检测当前是否WIFI网络环境
    BOOL isConnectedProperly =[[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==ReachableViaWiFi;
    //是否是2G/3G网络
    BOOL isWWAN = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==ReachableViaWWAN;
    //无网络
    BOOL notReach = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable;
    NSString * netStatus;
    //    NSString * placeHoldImgSrc;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    
    //若关闭"只在wifi下加载图片"，则3G、wifi都可以加载图片
    if ([[userDefaults objectForKey:@"BigPicLoad"] isEqualToString:@"close"])
    {
        //3g或wifif连接
        if (!notReach)
        {
            //netStatus = @"true";
            //            placeHoldImgSrc = detailInfo.round_pic;
            [appImageView setImageURL:[NSURL URLWithString:url]];
        }
        else
        {
            //无网络使用缓存图片
            netStatus = @"false";
            //            placeHoldImgSrc = detailInfo.round_pic;
            [appImageView imageUrl:[NSURL URLWithString:url] tempSTR:netStatus];
        }
    }
    else
    {
        //打开只在wifi下加载图片
        if (isWWAN)
        {
            //若使用的是3G，就不加载图片，使用缓存过的图片
            netStatus = @"false";
            //            placeHoldImgSrc = detailInfo.round_pic;
            [appImageView imageUrl:[NSURL URLWithString:url] tempSTR:netStatus];
        }
        else if (isConnectedProperly)
        {
            //若使用的是wifi，则加载图片
            //netStatus = @"true";
            //            placeHoldImgSrc = detailInfo.round_pic;
            [appImageView setImageURL:[NSURL URLWithString:url]];
        }
        else
        {
            //无网络也使用缓存过的图片
            netStatus = @"false";
            //            placeHoldImgSrc = detailInfo.round_pic;
            [appImageView imageUrl:[NSURL URLWithString:url] tempSTR:netStatus];
        }
        
    }
}

//获取wifi的状态，显示缓存图片（详情大图、大家还喜欢）
- (NSDictionary *)getWifiStatusAndUrlString:(NSString *)urlString placeholderString:(NSString *)placeholder
{
    // 检测当前是否WIFI网络环境
    BOOL isConnectedProperly =[[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==ReachableViaWiFi;
    //是否是2G/3G网络
    BOOL isWWAN = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==ReachableViaWWAN;
    //无网络
    BOOL notReach = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable;
    NSString * netStatus;
    NSString * placeHoldImgSrc;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //若关闭"只在wifi下加载图片"，则3G、wifi都可以加载图片
    if ([[userDefaults objectForKey:@"BigPicLoad"] isEqualToString:@"close"])
    {
        //3g或wifif连接
        if (!notReach)
        {
            netStatus = @"true";
            placeHoldImgSrc = urlString;
        }
        else
        {
            //无网络使用缓存图片
            netStatus = @"false";
            placeHoldImgSrc = urlString;
        }
    }
    else
    {
        //打开只在wifi下加载图片
        if (isWWAN)
        {
            //若使用的是3G，就不加载图片，就使用缓存图片
            netStatus = @"false";
            placeHoldImgSrc = urlString;
        }
        else if (isConnectedProperly)
        {
            //若使用的是wifi，则加载图片
            netStatus = @"true";
            placeHoldImgSrc = urlString;
        }
        else
        {
            //若使用的是3G，就不加载图片，就使用缓存图片
            netStatus = @"false";
            placeHoldImgSrc = urlString;
        }
        
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:netStatus,KNetStatus,placeHoldImgSrc,KPlaceHoldImgSrc, nil];
    return dic;
}

//获取wifi的状态显示的占位图片（文章页）
- (NSDictionary *)getWifiStatusAndUrlString
{
    // 检测当前是否WIFI网络环境
    BOOL isConnectedProperly =[[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==ReachableViaWiFi;
    //是否是2G/3G网络
    BOOL isWWAN = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==ReachableViaWWAN;
    //无网络
    BOOL notReach = [[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable;
    NSString * netStatus;
    NSString * placeHoldImgSrc;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //若关闭"只在wifi下加载图片"，则3G、wifi都可以加载图片
    if ([[userDefaults objectForKey:@"BigPicLoad"] isEqualToString:@"close"])
    {
        //3g或wifif连接
        if (!notReach)
        {
            netStatus = @"true";
            placeHoldImgSrc = @"vertical-default.png";
        }
        else
        {
            netStatus = @"false";
            placeHoldImgSrc = @"vertical-default.png";
        }
    }
    else
    {
        //打开只在wifi下加载图片
        //若使用的是3G，就不加载图片
        if (isWWAN)
        {
            netStatus = @"false";
            placeHoldImgSrc = @"vertical-default.png";
        }
        else if (isConnectedProperly)
        {
            //若使用的是wifi，则加载图片
            netStatus = @"true";
            placeHoldImgSrc = @"vertical-default.png";
        }
        else
        {
            netStatus = @"false";
            placeHoldImgSrc = @"vertical-default.png";

        }
        
    }
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:netStatus,KNetStatus,placeHoldImgSrc,KPlaceHoldImgSrc, nil];
    return dic;
}

@end
