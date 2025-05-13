//
//  BITCocoaLumberjack.m
//  Pods
//
//  Created       on 2017/8/2.
//  Copyright © 2017年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import "BITCocoaLumberjackConfig.h"
#import "BITSingleObject.h"
#import "BITCocoaLumberjack.h"
#import "BITCocoaLumberjackMacro.h"

extern NSUInteger bitLogLevel;


@implementation BITCocoaLumberjackConfig

-(id)init{
    if (self = [super init]) {
        [self configDDLog];
    }
    return self;
}

- (void)configDDLog
{
    switch (bitLogLevel) {
        case BITDDLogLevelError:
        case BITDDLogLevelWarning:
        case BITDDLogLevelInfo:
        case BITDDLogLevelDebug:
        case BITDDLogLevelVerbose:
        case BITDDLogLevelAll:
        {
            [self enableDDLog];
        }
            break;
            
        default:
            break;
    }
}

-(void)enableDDLog
{
    [BITDDLog addLogger:[BITDDTTYLogger sharedInstance]];
    [[BITDDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    BITDDFileLogger *fileLogger = [[BITDDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24 * 3; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 100;
    fileLogger.logFileManager.logFilesDiskQuota = 10 * 1024 * 1024;//20 * 1024 * 1024; // 20 MB
    
    [BITDDLog addLogger:fileLogger];
    
#if TARGET_OS_IPHONE
    UIColor *pink = [UIColor colorWithRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
#else
    NSColor *pink = [NSColor colorWithCalibratedRed:(255/255.0) green:(58/255.0) blue:(159/255.0) alpha:1.0];
#endif
    [[BITDDTTYLogger sharedInstance] setForegroundColor:pink backgroundColor:nil forFlag:BITDDLogFlagInfo];
#if TARGET_OS_IPHONE
    UIColor *gray = [UIColor grayColor];
#else
    NSColor *gray = [NSColor grayColor];
#endif
    [[BITDDTTYLogger sharedInstance] setForegroundColor:gray backgroundColor:nil forFlag:BITDDLogFlagVerbose];
    
    FLDDLogError(@"TEST BITDDLogError");
    FLDDLogWarn(@"TEST BITDDLogWarn");
    FLDDLogInfo(@"TEST BITDDLogInfo)");
    FLDDLogDebug(@"TEST BITDDLogDebug");
    FLDDLogVerbose(@"TEST BITDDLogVerbose");
}

@end

