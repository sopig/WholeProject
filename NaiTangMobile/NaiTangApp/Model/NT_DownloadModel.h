//
//  NT_DownloadModel.h
//  NaiTangApp
//
//  Created by 张正超 on 14-3-3.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkKit.h"

//下载状态
typedef enum
{
    LOADING = 8,
    PAUSE = 1,
    WAITEINSTALL = 4,
    FINISHED = 2,
    DOWNFAILED = 5,
    INSTALLING = 3,
    WAITEDOWNLOAD = 6,
    INSTALLFAILED = 7,
    INSTALLFINISHED = 9,
    ISMUCHMONEYFIELD = 10,
    DOWNFAILEDWITHUNCONNECT = 11,
    ISUNLITMTGOLD = 12
}LoadMode;

//按钮状态
typedef enum
{
    loadOn = 1,   //继续
    pauseOn = 2,  //暂停
    waiteOn = 3,  //等待
    reloadOn = 4, //重下
    installOn = 5, //安装
    reInstallOn = 6, //重装
    deleteOn = 7,  //显示删除按钮
    installingOn = 8 //安装中
}
buttonDownloadStatus;

@interface NT_DownloadModel : NSObject<NSCoding>

@property (nonatomic,retain)NSString *addressName,*gameName,*iconName,*savePath,*package,*saveName,*appID,*version,*installDate,*savePlistPath;
@property (nonatomic,assign)long long fileSize;
@property (nonatomic,assign)float progress;
@property (nonatomic,assign)NSTimeInterval downSpeed;
@property (nonatomic,assign)int loadType;
@property (nonatomic,strong)MKNetworkOperation *operation;
@property (nonatomic,assign)BOOL isChecked,isUpdateModel,isFinishedModel;
@property (nonatomic,assign)int priority;
//下载错误编号
@property (nonatomic,assign) NSInteger errorCode;
@property (nonatomic,assign) int buttonStatus;

//by thilong, 用于区分model.
@property (nonatomic,assign) uint64_t modelID;
@property (nonatomic,assign) bool pausedByNetworkChange;
@property (nonatomic,assign) bool isAutoRetry;
@property (nonatomic,assign) int autoRetryTimes;

- (id)initWithAddress:(NSString *)downAddress andGameName:(NSString *)gameName andRoundPic:(NSString *)roundPic andVersion:(NSString *)version  andAppID:(NSString *)appID;

@end

