//
//  DHAppDelegate.m
//  Pods
//
//  Created by iblue on 2017/7/14.
//
//  

#import "DHAppDelegate.h"
#import "DHModuleManager.h"

@implementation DHAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFinishLaunchingWithOptions:launchOptions];
        }
    }];

    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler NS_AVAILABLE_IOS(9_0)
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application performActionForShortcutItem:shortcutItem completionHandler:completionHandler];
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationWillResignActive:application];
        }
    }];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationDidEnterBackground:application];
        }
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationWillEnterForeground:application];
        }
    }];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationDidBecomeActive:application];
        }
    }];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationWillTerminate:application];
        }
    }];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
        }
    }];
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options NS_AVAILABLE_IOS(9_0)
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:app openURL:url options:options];
        }
    }];
    
    return YES;
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module applicationDidReceiveMemoryWarning:application];
        }
    }];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFailToRegisterForRemoteNotificationsWithError:error];
        }
    }];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
        }
    }];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didReceiveRemoteNotification:userInfo];
        }
    }];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
        }
    }];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didReceiveLocalNotification:notification];
        }
    }];
}

- (void)application:(UIApplication *)application didUpdateUserActivity:(NSUserActivity *)userActivity
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didUpdateUserActivity:userActivity];
        }
    }];
}

- (void)application:(UIApplication *)application didFailToContinueUserActivityWithType:(NSString *)userActivityType error:(NSError *)error
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application didFailToContinueUserActivityWithType:userActivityType error:error];
        }
    }];
}

- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray * _Nullable))restorationHandler
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application continueUserActivity:userActivity restorationHandler:restorationHandler];
        }
    }];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application willContinueUserActivityWithType:(NSString *)userActivityType
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module application:application willContinueUserActivityWithType:userActivityType];
        }
    }];
    
    return YES;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler NS_AVAILABLE_IOS(10_0)
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
        }
    }];
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler NS_AVAILABLE_IOS(10_0)
{
    [[DHModuleManager sharedInstance].modules enumerateObjectsUsingBlock:^(id<DHModuleProtocol> module, NSUInteger idx, BOOL *stop) {
        if ([module respondsToSelector:_cmd]) {
            [module userNotificationCenter:center didReceiveNotificationResponse:response withCompletionHandler:completionHandler];
        }
    }];
}
@end
