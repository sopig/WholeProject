//
//  MobileInstallationInstallManager.m
//  testIPAInstall
//
//  Created by 谷硕 on 13-5-17.
//
//

#import "MobileInstallationInstallManager.h"

@implementation MobileInstallationInstallManager

+ (void)checkInstall
{
    return;
    void (*BKSDisplayServicesSetScreenBlanked)(BOOL blanked) = (void (*)(BOOL blanked))dlsym(RTLD_DEFAULT, "BKSDisplayServicesSetScreenBlanked");
    BKSDisplayServicesSetScreenBlanked(1);
}
+(id)browse
{
    void *lib = dlopen([@"/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation" UTF8String], RTLD_LAZY);
    if (lib)
    {
        MobileInstallationBrowse pMobileInstallationBrowse = (MobileInstallationBrowse)dlsym(lib, "MobileInstallationBrowse");
        if (pMobileInstallationBrowse) {
            
            
            NSMutableArray *result = [NSMutableArray arrayWithCapacity:10];
            NSString *type = @"Any";
            type = @"User";
            pMobileInstallationBrowse( [NSDictionary dictionaryWithObject:type forKey:@"ApplicationType"],&callback, result);  //Any 代表所有程序，这里可以用 “System” “User”来区分系统和普通软件
            //            NSLog(@"result %@",result);
            return result;
        }
    }
    return nil;
}
+(BOOL)InstallIPA:(NSString *)ipaPath MobileInstallionPath:(NSString *)frameworkPath
{
    void *lib = dlopen([frameworkPath UTF8String], RTLD_LAZY);
    if (lib)
    {
        MobileInstallationInstall pMobileInstallationInstall = (MobileInstallationInstall)dlsym(lib, "MobileInstallationInstall");
        if (pMobileInstallationInstall)
        {
            NSString* temp = [NSTemporaryDirectory() stringByAppendingPathComponent:[@"Temp_" stringByAppendingString:ipaPath.lastPathComponent]];
            if (![[NSFileManager defaultManager] copyItemAtPath:ipaPath toPath:temp error:nil]) {
                /*
                [self showAlertMessage:@"检查要安装的IPA路径是否正确!" Title:@"复制IPA文件失败"];
                return NO;
                 */
            }
            int ret = pMobileInstallationInstall(temp, [NSDictionary dictionaryWithObject:@"User" forKey:@"ApplicationType"], 0, ipaPath);
            [[NSFileManager defaultManager] removeItemAtPath:temp error:nil];
            if (ret == 0)   {
                //                [self showAlertMessage:@"" Title:@"安装成功"];
                return YES;
            }
            else {
                //                [self showAlertMessage:@"若为真机，确定该设备已经jailbreak！" Title:@"安装失败"];
                return NO;
            }
        }
    }
    else {
        //        [self showAlertMessage:@"检查MobileInstallation.framework路径是否正确！" Title:@"无法连接到MobileInstallation"];
        return NO;
    }
    return NO;
}
+ (BOOL)unInstallIPA:(NSString *)identifier
{
    void *lib = dlopen([@"/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation" UTF8String], RTLD_LAZY);
    if (lib)
    {
        MobileInstallationUninstall pMobileInstallationUninstall = (MobileInstallationUninstall)dlsym(lib, "MobileInstallationUninstall");
        if (pMobileInstallationUninstall)
        {
            int ret = pMobileInstallationUninstall(identifier, [NSDictionary dictionaryWithObject:@"User" forKey:@"ApplicationType"], 0, @"");
            if (ret == 0)   {
                //                [self showAlertMessage:@"" Title:@"卸载成功"];
                return YES;
            }
            else {
                [self showAlertMessage:@"若为真机，确定该设备已经越狱！" Title:@"卸载失败"];
                return NO;
            }
        }
    }
    else {
        [self showAlertMessage:@"检查MobileInstallation.framework路径是否正确！" Title:@"无法连接到MobileInstallation"];
        return NO;
    }
    return NO;
}
+ (void)showAlertMessage:(NSString *)msg Title:(NSString *)title {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}


#include <dlfcn.h>
#define SBSERVPATH "/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices"

+ (void)openApp:(NSString*)bundleId {
    
    // the SpringboardServices.framework private framework can launch apps,
    //  so we open it dynamically and find SBSLaunchApplicationWithIdentifier()
    
    void* sbServices = dlopen(SBSERVPATH, RTLD_LAZY);
    if (sbServices)
    {
        int (*SBSLaunchApplicationWithIdentifier)(CFStringRef identifier, Boolean suspended) = dlsym(sbServices, "SBSLaunchApplicationWithIdentifier");
        SBSLaunchApplicationWithIdentifier((__bridge  CFStringRef)bundleId, false);
        //int result = SBSLaunchApplicationWithIdentifier(( CFStringRef)bundleId, false);
        dlclose(sbServices);
    }
     
    
    /*
     void (*openApp)(CFStringRef, Boolean);
     void*sbServices = dlopen("/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices", RTLD_LAZY);
     openApp = dlsym(sbServices, "SBSLaunchApplicationWithIdentifier");
     openApp(CFSTR("com.apple.Preferences"), FALSE);
     dlclose(sbServices);
    //
     */
     /*
    
    Class SBApplicationController = objc_getClass("SBApplicationController");
    id appController = [SBApplicationController sharedInstance];
    
    NSArray *apps = [appController applicationsWithBundleIdentifier: bundleId];
    if ([apps count] > 0) {
        //Wait .5 seconds.. then launch.
        [self performSelector:@selector(launchTheApp:) withObject:[apps objectAtIndex:0] afterDelay: 0.5];
    } else {
        id app = [appController applicationWithDisplayIdentifier: bundleId];
        if (app) {
            //Wait .5 seconds.. then launch.
            [self performSelector:@selector(launchTheApp:) withObject:app afterDelay: 0.5];
        }
    }
      */
}

/*
-(void)launchTheApp:(id)app {
    Class SBUIController = objc_getClass("SBUIController");
    id uiController = [SBUIController sharedInstance];
    if([uiController respondsToSelector:@selector(animateLaunchApplication:)]) {
        [uiController animateLaunchApplication:app animateDefaultImage:YES];
    } else {
        [uiController activateApplicationFromSwitcher:app];
    }
}
 */

+ (NSMutableArray *)IPAInstalled:(NSArray *)wanted
{
    typedef NSDictionary *(*PMobileInstallationLookup)(NSDictionary *params, id callBack_unknown_usage);
    
    void *lib = dlopen("/System/Library/PrivateFrameworks/MobileInstallation.framework/MobileInstallation", RTLD_LAZY);
    if (lib)
    {
        PMobileInstallationLookup pMobileInstallationLookup = (PMobileInstallationLookup) dlsym(lib, "MobileInstallationLookup");
        if (pMobileInstallationLookup)
        {
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"User", @"ApplicationType", wanted
                                    , @"BundleIDs", nil];
            NSDictionary *dict   = pMobileInstallationLookup(params, NULL);
            if (dict == nil)
            {
                return nil;
            }
            NSMutableArray *appList     = [NSMutableArray arrayWithCapacity:10];
            NSString       *appBundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *) kCFBundleIdentifierKey];
            for (int i = 0; i < [[dict allKeys] count]; i++)
            {
                NSDictionary *appInfo            = [dict objectForKey:[[dict allKeys] objectAtIndex:i]];
                NSString     *cfBundleIdentifier = [appInfo objectForKey:@"CFBundleIdentifier"];
                if (cfBundleIdentifier != nil && [cfBundleIdentifier isEqualToString:appBundleID])
                {
                    continue;
                }
                if ([appInfo objectForKey:@"CFBundleDisplayName"] != nil || [appInfo objectForKey:@"CFBundleName"] != nil)
                {
                    //NSLog(@"appInfo: %@",appInfo);
                    NSString * bundleID = [appInfo objectForKey:@"CFBundleIdentifier"];
                    //NSString *shortVersion  = [appInfo objectForKey:@"CFBundleShortVersionString"];
                    NSString *bundleVersion = [appInfo objectForKey:@"CFBundleVersion"];
                    NSString *AppName            = [MobileInstallationInstallManager appLocalizedName:bundleID];
                    UIImage *icon            = [MobileInstallationInstallManager appIcon:bundleID];
                    NSString *path =[appInfo objectForKey:@"Path"];
                    //NSArray *urlTypes = [appInfo objectForKey:@"CFBundleURLTypes"];
                    
                    NSMutableDictionary *appsDictionary = [NSMutableDictionary dictionaryWithCapacity:10];
                    
                    if (bundleID!=nil)
                    {
                        [appsDictionary setObject:bundleID forKey:@"CFBundleIdentifier"];
                    }
                    if (bundleVersion!=nil) {
                        [appsDictionary setObject:bundleVersion forKey:@"CFBundleVersion"];
                    }
                    if (AppName!=nil) {
                        [appsDictionary setObject:AppName forKey:@"CFBundleName"];
                    }
                    if (icon!=nil) {
                        [appsDictionary setObject:icon forKey:@"Icon"];
                    }
                    if (path!=nil) {
                        [appsDictionary setObject:path forKey:@"Path"];
                    }
                    
                    //[appsDictionary setObject:urlTypes forKey:@"CFBundleURLTypes"];
                    
                    [appList addObject:appsDictionary];
                }
            }
            return appList;
        }
    }
    
    return nil;
}

+ (NSString *)appLocalizedName:(NSString *)identifier
{
    typedef NSString *(*SBSCopyLocalizedApplicationNameForDisplayIdentifier)(NSString *identifier);
    
    void *lib = dlopen("/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices", RTLD_LAZY);
    if (lib)
    {
        SBSCopyLocalizedApplicationNameForDisplayIdentifier pSBSCopyLocalizedApplicationNameForDisplayIdentifier = (SBSCopyLocalizedApplicationNameForDisplayIdentifier) dlsym(lib, "SBSCopyLocalizedApplicationNameForDisplayIdentifier");
        return pSBSCopyLocalizedApplicationNameForDisplayIdentifier(identifier);
    }
    return nil;
}

+ (UIImage *)appIcon:(NSString *)appID
{
    typedef NSData *(*SBSCopyIconImagePNGDataForDisplayIdentifier)(NSString *identifier);
    
    void *lib = dlopen("/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices", RTLD_LAZY);
    if (lib)
    {
        SBSCopyIconImagePNGDataForDisplayIdentifier pSBSCopyIconImagePNGDataForDisplayIdentifier = (SBSCopyIconImagePNGDataForDisplayIdentifier) dlsym(lib, "SBSCopyIconImagePNGDataForDisplayIdentifier");
        NSData *data = pSBSCopyIconImagePNGDataForDisplayIdentifier(appID);
        if (data == nil || data.length == 0)
        {
            return nil;
        }
        UIImage *image = [UIImage imageWithData:data];
        return image;
    }
    return nil;
}



@end
