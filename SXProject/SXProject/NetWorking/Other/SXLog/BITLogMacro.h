//
//  BITLogMacro.h
//  ELockSDK
//
//  Created by huihui on 2017/8/2.
//  Copyright © 2017年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#ifndef BITLogMacro_h
#define BITLogMacro_h

////禁用iOSDFULibrary
//#ifndef FORBIDDEN_iOSDFULibrary
////不禁用禁用iOSDFULibrary为0,禁用iOSDFULibrary为1
//#define FORBIDDEN_iOSDFULibrary 0
//#endif

//测试环境，生产环境切换宏
#ifndef TEST_ENVIRONMENT
//生产环境为0,测试环境为1
#define TEST_ENVIRONMENT 1
#else
#endif

//异步日志处理
#ifndef TEST_XCODE_COLORS
//当发布生产环境时需要置为0或当发布到外面的外部SDK测试就需要置为0，就能关闭日志系统。一般若为内部测试，需要置为1，来启动日志系统
#define TEST_XCODE_COLORS 1
#else
#endif

#if TEST_XCODE_COLORS
//测试机可能不支持定位,所以开发环境可以关闭定位检查
#ifndef CLOSE_LOCATION_CHECH
#define CLOSE_LOCATION_CHECH 1
#else
#endif
#endif

// BaseUrl
#if TEST_ENVIRONMENT

#endif

//#import "BITCocoaLumberjackConfig.h"
#import "BITCocoaLumberjack.h"
#import "BITCocoaLumberjackMacro.h"

#if TEST_XCODE_COLORS
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...)
#endif

#endif /* BITLogMacro_h */

NS_ASSUME_NONNULL_BEGIN

@interface BITLogMacro : NSObject


@end

NS_ASSUME_NONNULL_END
