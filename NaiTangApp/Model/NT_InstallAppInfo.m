//
//  NT_InstallAppInfo.m
//  NaiTangApp
//
//  Created by 张正超 on 14-3-2.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

#import "NT_InstallAppInfo.h"
#include "sys/stat.h"

@interface NSDictionary(iconFiles)
- (NSString *)iconFileName;
- (NSArray *)iconFiles;
@end

@implementation NSDictionary(iconFiles)
- (NSString *)iconFileName
{
    NSString *iconFile = [self objectForKey:@"CFBundleIconFile"];
    //    if (!iconFile) {
    //        for (NSDictionary *dic in self.allValues) {
    //            if ([dic isKindOfClass:[NSDictionary class]]) {
    //                iconFile = [dic iconFileName];
    //                if (iconFile) {
    //                    return iconFile;
    //                }
    //            }
    //        }
    //    }
    return iconFile;
}

- (NSArray *)iconFiles
{
    NSArray *arr = [self objectForKey:@"CFBundleIconFiles"];
    if (!arr) {
        arr = [[self objectForKey:@"CFBundleIcons"] objectForKey:@"CFBundleIconFiles"];
    }
    if (!arr) {
        arr = [[[self objectForKey:@"CFBundleIcons"] objectForKey:@"CFBundlePrimaryIcon"] objectForKey:@"CFBundleIconFiles"];
    }
    if (!arr.count) {
        return nil;
    }
    return arr;
}
@end

@implementation NT_InstallAppInfo

+ (NT_InstallAppInfo *)infoFromDic:(NSDictionary *)dic
{
    NT_InstallAppInfo *info  = [[NT_InstallAppInfo alloc] init];
    info.appType = [dic objectForKey:@"ApplicationType"];
    info.appName = [dic objectForKey:@"CFBundleDisplayName"];
    if (!info.appName) {
        info.appName = [dic objectForKey:@"CFBundleName"];
    }
    info.appIdentifier = [dic objectForKey:@"CFBundleIdentifier"];
    info.appVersion = [dic objectForKey:@"CFBundleVersion"];
    
    NSArray *urlSchemes = [dic objectForKey:@"CFBundleURLTypes"];
    if (urlSchemes.count) {
        info.appURLSchemes = [[urlSchemes objectAtIndex:0] objectForKey:@"templerun"];
    }
    info.appPath = [dic objectForKey:@"Path"];
    info.homePath = [[dic objectForKey:@"EnvironmentVariables"] objectForKey:@"HOME"];
    
    NSString *appPath = info.appPath;
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:[appPath stringByAppendingFormat:@"/Icon@2x.png"]];
    if (!image) {
        image = [[UIImage alloc] initWithContentsOfFile:[appPath stringByAppendingFormat:@"/Icon.png"]];
    }
    if (!image) {
        image = [[UIImage alloc] initWithContentsOfFile:[appPath stringByAppendingFormat:@"/icon@2x.png"]];
    }
    if (!image) {
        image = [[UIImage alloc] initWithContentsOfFile:[appPath stringByAppendingFormat:@"/icon.png"]];
    }
    if (!image) {
        NSString *iconName = [dic iconFileName];
        if (!iconName) {
            NSArray *iconArray = [dic iconFiles];
            iconName = [iconArray objectAtIndex:0];
        }
        if (iconName) {
            image = [[UIImage alloc] initWithContentsOfFile:[appPath stringByAppendingFormat:@"/%@",iconName]];
            if (!image) {
                image = [[UIImage alloc] initWithContentsOfFile:[appPath stringByAppendingFormat:@"/%@.png",iconName]];
            }
        }
    }
    info.iconImage = image;
    
    info.appIcon = [dic objectForKey:@"Icon"];
    
    NSArray *urlTypes = [dic objectForKey:@"CFBundleURLTypes"];
    if (urlTypes.count) {
        urlTypes = [[urlTypes objectAtIndex:0] objectForKey:@"CFBundleURLSchemes"];
        if (urlTypes.count) {
            info.openUrlScheme = [[urlTypes objectAtIndex:0] stringByAppendingString:@"://"];
        }
    }
    return info;
}
- (void)calculateAppSize
{
    if (!self.appSizeString) {
        self.appSizeString = [self stringForAllFileSize:[self folderSizeAtPath:self.appPath]];
    }
    //        _appSizeString = NSStringFromSize([[self class] folderSizeAtPath:self.appPath]);
}

- (NSString *)totalSizeString
{
    if (!_totalSizeString) {
        _totalSizeString = [self stringForAllFileSize:[self folderSizeAtPath:self.homePath]];
    }
    return _totalSizeString;
}
- (NSString *)doucumentSizeString
{
    if (!_doucumentSizeString) {
        long long totalSize = [self folderSizeAtPath:self.homePath];
        self.totalSizeString = [self stringForAllFileSize:totalSize];
        long long appSize = [self folderSizeAtPath:self.appPath];
        self.appSizeString = [self stringForAllFileSize:appSize];
        _doucumentSizeString = [self stringForAllFileSize:totalSize - appSize];
    }
    return _doucumentSizeString;
}

+ (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}
+ (long long) fileSizeAtPath2:(NSString*) filePath{
    struct stat st;
    if(lstat([filePath cStringUsingEncoding:NSUTF8StringEncoding], &st) == 0){
        return st.st_size;
    }
    return 0;
}
// 循环调用fileSizeAtPath来获取一个目录所占空间大小
+ (long long) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}

#include <sys/stat.h>
#include <dirent.h>
#define Localizable_LF_Size_Bytes                                   @"%lld Bytes"
#define Localizable_LF_Size_K                                       @"%lld K"
#define Localizable_LF_Size_M                                       @"%lld.%lld M"
#define Localizable_LF_Size_G                                       @"%lld.%d G"
#define Localizable_LF_All_Size_M                                   @"%lld.%lld M"
#define Localizable_LF_All_Size_G                                   @"%lld.%lld G"
////////////////////获取文件大小
-(long long) folderSizeAtPath:(NSString*) folderPath{
    return [self _folderSizeAtPath:[folderPath cStringUsingEncoding:NSUTF8StringEncoding]];
}
-(long long) _folderSizeAtPath: (const char*)folderPath{
    long long folderSize = 0;
    DIR* dir = opendir(folderPath);
    if (dir == NULL) return 0;
    struct dirent* child;
    while ((child = readdir(dir))!=NULL) {
        if (child->d_type == DT_DIR && (
                                        (child->d_name[0] == '.' && child->d_name[1] == 0) || // 忽略目录 .
                                        (child->d_name[0] == '.' && child->d_name[1] == '.' && child->d_name[2] == 0) // 忽略目录 ..
                                        )) continue;
        int folderPathLength = strlen(folderPath);
        char childPath[1024]; // 子文件的路径地址
        stpcpy(childPath, folderPath);
        if (folderPath[folderPathLength-1] != '/'){
            childPath[folderPathLength] = '/';
            folderPathLength++;
        }
        stpcpy(childPath+folderPathLength, child->d_name);
        childPath[folderPathLength + child->d_namlen] = 0;
        if (child->d_type == DT_DIR){ // directory
            folderSize += [self _folderSizeAtPath:childPath]; // 递归调用子目录
            // 把目录本身所占的空间也加上
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }else if (child->d_type == DT_REG || child->d_type == DT_LNK){ // file or link
            struct stat st;
            if(lstat(childPath, &st) == 0) folderSize += st.st_size;
        }
    }
    closedir(dir);
    return folderSize;
}
/******************************************************************************
 函数名称 : + (NSString *)stringForAllFileSize:(UInt64)fileSize
 39
 函数描述 : 格式话返回文件大小
 40
 输入参数 : (UInt64)fileSize
 41
 输出参数 : N/A
 42
 返回参数 : (NSString *)
 43
 备注信息 :
 44
 ******************************************************************************/
-(NSString *)stringForAllFileSize:(UInt64)fileSize
{
    if (fileSize<1024) {//Bytes/Byte
        if (fileSize>1) {
            return [NSString stringWithFormat:Localizable_LF_Size_Bytes,
                    fileSize];
        }else {//==1 Byte
            return [NSString stringWithFormat:Localizable_LF_Size_Bytes,
                    fileSize];
        }
    }
    if ((1024*1024)>(fileSize)&&(fileSize)>1024) {//K
        return [NSString stringWithFormat:Localizable_LF_Size_K,
                fileSize/1024];
    }
    if ((1024*1024*1024)>fileSize&&fileSize>(1024*1024)) {//M
        return [NSString stringWithFormat:Localizable_LF_All_Size_M,
                fileSize/(1024*1024),
                fileSize%(1024*1024)/(1024*102)];
    }
    if (fileSize>(1024*1024*1024)) {//G
        return [NSString stringWithFormat:Localizable_LF_All_Size_G,
                fileSize/(1024*1024*1024),
                fileSize%(1024*1024*1024)/(1024*1024*102)];
    }
    return @"";
}


@end

