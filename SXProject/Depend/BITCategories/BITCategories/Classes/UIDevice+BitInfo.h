//
//  UIDevice+BitInfo.h
//  ChildishBeautyParent
//
//  Created        on 2017/11/29.
//  Copyright © 2019年 BitInfo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>


#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>


typedef NS_ENUM(NSInteger, DeviceNetworkStatus){
    DeviceNetworkStatusNotReachable = 1,
    DeviceNetworkStatusUnknown = 2,
    DeviceNetworkStatusWWAN2G = 3,
    DeviceNetworkStatusWWAN3G = 4,
    DeviceNetworkStatusWWAN4G = 5,
    DeviceNetworkStatusWiFi = 6,
};

@interface UIDevice (BitInfo)

//判断设备是否越狱
+ (BOOL)isJailBreak;

//是否是模拟器
+ (BOOL)isSimulator;

//是否连接了VPN
+ (BOOL)isVPNConnected;

//版本号
+ (NSString *)bitinfo_appVersion;

//build号
+ (NSString *)bitinfo_buildVersion;

//完整版本号
+ (NSString *)bitinfo_fullVersion;

//系统型号
+ (NSString *)bitinfo_systemType;

//系统版本
+ (NSString *)bitinfo_systemVersion;
///=============================================================================
/// @name Device Information
///=============================================================================

/// Device system version (e.g. 8.1)
+ (double)bitsystemVersion;

//网络状态
+ (DeviceNetworkStatus)bitinfo_networkSatus;

//运营商名称
+ (NSString *)bitinfo_cellularProvider;

//ip地址
+ (NSString *)bitinfo_ipAddress;

//分辨率
+ (CGSize)bitinfo_screenPixelSize;

//可用内存
+ (CGFloat)bitinfo_availableMemory;

//使用内存
+ (CGFloat)bitinfo_usedMemory;

//cpu使用率
+ (CGFloat)bitinfo_cpuUsage;

//wifi名称
+ (NSString *)bitinfo_wifiName;

//系统语言
+ (NSString *)bitinfo_language;

/**
 获取通讯录

 @return 格式为
 [
    {"key":["value"]},
    {"key":["value"]}
 ]
 */
+ (NSArray *)bitinfo_addressBook;
/**
 获取系统电量
 
 @return 返回区间为0-1，如果没获取到，为-1
 */
+ (int)bitinfo_batteryQuantity;

//存储uid----如果卸载会重新生成
+ (NSString *)bitinfo_uid;

@end
