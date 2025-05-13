//
//  BITNSObject.m
//  BITNSObject
//
//  Created       on 2019/4/25.
//  Copyright © 2019 huihui. All rights reserved.
//

#import "BITNSObject.h"
#import "BITSingleObject.h"

extern NSUInteger bitLogLevel;

@implementation BITNSObject

-(void)configLog
{
    if(![BITSingleObject sharedInstance].isInitializeLog)
    {
#if TEST_XCODE_COLORS
        bitLogLevel = BITDDLogLevelVerbose;
        //#define NSLog(...) NSLog(__VA_ARGS__)
#else
        bitLogLevel = BITDDLogLevelOff;
        //#define NSLog(...)
#endif
        (void)[[BITCocoaLumberjackConfig alloc] init];
    }
    NSLog(@"BITNSObject configLog");
}

+(void)initialize {
    if(![BITSingleObject sharedInstance].isInitializeLog)
    {
#if TEST_XCODE_COLORS
        bitLogLevel = BITDDLogLevelVerbose;
        //#define NSLog(...) NSLog(__VA_ARGS__)
#else
        bitLogLevel = BITDDLogLevelOff;
        //#define NSLog(...)
#endif
        (void)[[BITCocoaLumberjackConfig alloc] init];
        [BITSingleObject sharedInstance].isInitializeLog = YES;
    }
    NSLog(@"BITNSObject isInitializeLog");
}

@end
