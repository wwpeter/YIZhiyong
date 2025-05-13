//
//  WTSConfigManager.h
//  assistant
//
//  Created by admin on 17/4/5.
//  Copyright © 2017年 com.91wailian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTSDeviceDataLibrery.h"
@interface WTSConfigManager : NSObject
/*
 *Keychain  储存设备号
 */


+ (void)save:(NSString *)service data:(id)data;
/**
 *  获取设备号
 *
 */
+ (id)loadDeviceId:(NSString *)service;

+ (id)getDeviceId ;

+ (void)deletekey:(NSString *)service;

/**
 *  获取版本号
 *
 */
+ (NSString *)getAppVersion ;


/**
 获取设备名称

 @return 设备名称
 */
+ (const NSString *)getDeviceName;

/**
 获取系统版本号

 @return 系统版本号
 */
+ (NSString *)getSystemVersion;


/**
 获取设备支持最高系统版本号

 @return 最高支持的系统版本号
 */
+ (const NSString *)getLatestFirmware;

/**
     获取UUID
 */
+ (NSString*) gen_uuid;

/**
     获取当前的controller
 */
+ (UIViewController *)getCurrentVC;

/**
     获取根控制器
 */
+ (UIViewController *)getRootVC;

+(BOOL)isSimuLator;


@end
