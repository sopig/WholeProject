//
//  MobileInstallationInstallManager.h
//  testIPAInstall
//
//  Created by 谷硕 on 13-5-17.
//
//

#import <Foundation/Foundation.h>
#include <dlfcn.h>
// ipaPath是要安装的IPA包路径
// frameworkPath是MobileInstallion的路径
// 一般来说Mac OSX应该是/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.0.sdk/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation
// 真机设备则是/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation
typedef int (*MobileInstallationInstall)(NSString *path, NSDictionary *dict, void *na, NSString *backpath);

typedef int (*MobileInstallationBrowse)(NSDictionary *options, int (*callback)(NSDictionary *dict, id value), id value);

typedef int (*MobileInstallationUninstall)(NSString *identifier, NSDictionary *dict, void *na, NSString *backpath);


static int callback(NSDictionary *dict, id result)
{
    NSArray *currentlist = [dict objectForKey:@"CurrentList"];
    if (currentlist)
    {
        for (NSDictionary *appinfo in currentlist)
        {
            [(NSMutableArray*)result addObject:[appinfo copy]];
        }
    }
    return 0;
}

@interface MobileInstallationInstallManager : NSObject

+ (void)checkInstall;
+ (id)browse;
+ (BOOL)InstallIPA:(NSString *)ipaPath MobileInstallionPath:(NSString *)frameworkPath;
+ (BOOL)unInstallIPA:(NSString *)identifier;

+ (void)openApp:(NSString*)bundleId;
+ (NSMutableArray *)IPAInstalled:(NSArray *)wanted;
+ (NSString *)appLocalizedName:(NSString *)identifier;
@end


/*
 //本测试在模拟器和真机设备（JB）均可成功安装
 //模拟器的MobileInstallation大概路径应该是
 //"/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS5.0.sdk/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation"
 //但是由于缺乏访问权限，测试时已经将MobileInstallation拷贝在资源文件中，另外模拟器测试时用app_simulator.ipa，真机用app.ipa
 if ([[[UIDevice currentDevice] name] isEqualToString:@"iPhone Simulator"]) {
 [SVProgressHUD showInView:self.view status:@"模拟器安装中..."];
 [self InstallIPA:[[NSBundle mainBundle] pathForResource:@"HelloIPA_simulator" ofType:@"ipa"] MobileInstallionPath:[[NSBundle mainBundle] pathForResource:@"MobileInstallation" ofType:@""]];
 }
 else {
 [SVProgressHUD showInView:self.view status:@"真机安装中..."];
 //        [self InstallIPA:[[NSBundle mainBundle] pathForResource:@"HelloIPA" ofType:@"ipa"] MobileInstallionPath:@"/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation"];//newCard(1).ipa
 //        [self InstallIPA:[[NSBundle mainBundle] pathForResource:@"newCard(1)" ofType:@"ipa"] MobileInstallionPath:@"/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation"];
 [self unInstallIPA:@"yshow.testIpa"];
 }
*/





