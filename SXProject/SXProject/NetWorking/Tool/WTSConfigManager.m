//
//  WTSConfigManager.m
//  assistant
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 com.91wailian. All rights reserved.
//

#import "WTSConfigManager.h"
#import "MFSIdentifier.h"
#import "WTSDataMacro.h"

@implementation WTSConfigManager
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            service, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
}

+ (id)loadDeviceId:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    //Since in our simple case we are expecting only a single attribute to be returned (the password) we can set the attribute kSecReturnData to kCFBooleanTrue
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    if (keyData)
    CFRelease(keyData);
    return ret;
}

+ (id)getDeviceId{
    return  [MFSIdentifier deviceID];
    
    NSString *usernamepasswordKVPairs = (NSString *)[WTSConfigManager loadDeviceId:wts_KEY_Iphone_UUID];
    if (!usernamepasswordKVPairs) {
        [WTSConfigManager save:wts_KEY_Iphone_UUID data:[[[UIDevice currentDevice] identifierForVendor] UUIDString]];
        usernamepasswordKVPairs = (NSString *)[WTSConfigManager loadDeviceId:wts_KEY_Iphone_UUID];
    }
    return usernamepasswordKVPairs ;
}

+ (void)deletekey:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((CFDictionaryRef)keychainQuery);
}

+ (NSString *)getAppVersion{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
//    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
//    NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    return app_Version;

}


+ (NSString*) gen_uuid
{
    CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
    CFStringRef uuid_string_ref= CFUUIDCreateString(NULL, uuid_ref);
    NSString *uuid = [NSString stringWithString:(NSString*)CFBridgingRelease(uuid_string_ref)];
    CFRelease(uuid_ref);
    return uuid;
    
}


+ (UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    id  nextResponder = nil;
    UIViewController *appRootVC = window.rootViewController;
    // 如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        nextResponder = appRootVC.presentedViewController;
    }
    else {
        nextResponder = appRootVC;
    }
    
    while ([nextResponder isKindOfClass:[UITabBarController class]] || [nextResponder isKindOfClass:[UINavigationController class]]) {
        
        if ([nextResponder isKindOfClass:[UITabBarController class]]){
            
            UITabBarController * tabbar = (UITabBarController *)nextResponder;
            UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
            nextResponder = nav.childViewControllers.lastObject;

        }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
            
            UIViewController * nav = (UIViewController *)nextResponder;
            nextResponder = nav.childViewControllers.lastObject;
        }
    }

    result = nextResponder;
    return result;
}

+ (UIViewController *)getRootVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    //app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    result = window.rootViewController;
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tab = (UITabBarController *)result;
        result = tab.viewControllers[tab.selectedIndex];
    }
    
    if ([result isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)result;
        result = nav.childViewControllers.firstObject;
    }
    return result;
}

+ (const NSString *)getDeviceName {
    return [WTSDeviceDataLibrery getDeviceName];
}

+ (NSString *)getSystemVersion {
    NSString *systemVersion = [UIDevice currentDevice].systemVersion;
    return systemVersion;
}

+ (const NSString *)getLatestFirmware {
    return [WTSDeviceDataLibrery getLatestFirmware];
}


+(BOOL)isSimuLator
{
    if (TARGET_IPHONE_SIMULATOR == 1 && TARGET_OS_IPHONE == 1) {
        //模拟器
        return YES;
    }else{
        //真机
        return NO;
    }
}

@end
