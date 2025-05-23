// Software License Agreement (BSD License)
//
// Copyright (c) 2010-2016, Deusty, LLC
// All rights reserved.
//
// Redistribution and use of this software in source and binary forms,
// with or without modification, are permitted provided that the following conditions are met:
//
// * Redistributions of source code must retain the above copyright notice,
//   this list of conditions and the following disclaimer.
//
// * Neither the name of Deusty nor the names of its contributors may be used
//   to endorse or promote products derived from this software without specific
//   prior written permission of Deusty, LLC.

#import "BITDDASLLogger.h"
#import <asl.h>

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif

const char* const bitkDDASLKeyBITDDLog = "BITDDLog";

const char* const bitkDDASLBITDDLogValue = "1";

static BITDDASLLogger *sharedInstance;

@interface BITDDASLLogger () {
    aslclient _client;
}

@end


@implementation BITDDASLLogger

+ (instancetype)sharedInstance {
    static dispatch_once_t BITDDASLLoggerOnceToken;

    dispatch_once(&BITDDASLLoggerOnceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });

    return sharedInstance;
}

- (instancetype)init {
    if (sharedInstance != nil) {
        return nil;
    }

    if ((self = [super init])) {
        // A default asl client is provided for the main thread,
        // but background threads need to create their own client.

        _client = asl_open(NULL, "com.apple.console", 0);
    }

    return self;
}

- (void)logMessage:(BITDDLogMessage *)logMessage {
    // Skip captured log messages
    if ([logMessage->_fileName isEqualToString:@"BITDDASLLogCapture"]) {
        return;
    }

    NSString * message = _logFormatter ? [_logFormatter formatLogMessage:logMessage] : logMessage->_message;

    if (message) {
        const char *msg = [message UTF8String];

        size_t aslLogLevel;
        switch (logMessage->_flag) {
            // Note: By default ASL will filter anything above level 5 (Notice).
            // So our mappings shouldn't go above that level.
            case BITDDLogFlagError     : aslLogLevel = ASL_LEVEL_CRIT;     break;
            case BITDDLogFlagWarning   : aslLogLevel = ASL_LEVEL_ERR;      break;
            case BITDDLogFlagInfo      : aslLogLevel = ASL_LEVEL_WARNING;  break; // Regular NSLog's level
            case BITDDLogFlagDebug     :
            case BITDDLogFlagVerbose   :
            default                 : aslLogLevel = ASL_LEVEL_NOTICE;   break;
        }

        static char const *const level_strings[] = { "0", "1", "2", "3", "4", "5", "6", "7" };

        // NSLog uses the current euid to set the ASL_KEY_READ_UID.
        uid_t const readUID = geteuid();

        char readUIDString[16];
#ifndef NS_BLOCK_ASSERTIONS
        size_t l = snprintf(readUIDString, sizeof(readUIDString), "%d", readUID);
#else
        snprintf(readUIDString, sizeof(readUIDString), "%d", readUID);
#endif

        NSAssert(l < sizeof(readUIDString),
                 @"Formatted euid is too long.");
        NSAssert(aslLogLevel < (sizeof(level_strings) / sizeof(level_strings[0])),
                 @"Unhandled ASL log level.");

        aslmsg m = asl_new(ASL_TYPE_MSG);
        if (m != NULL) {
            if (asl_set(m, ASL_KEY_LEVEL, level_strings[aslLogLevel]) == 0 &&
                asl_set(m, ASL_KEY_MSG, msg) == 0 &&
                asl_set(m, ASL_KEY_READ_UID, readUIDString) == 0 &&
                asl_set(m, bitkDDASLKeyBITDDLog, bitkDDASLBITDDLogValue) == 0) {
                asl_send(_client, m);
            }
            asl_free(m);
        }
        //TODO handle asl_* failures non-silently?
    }
}

- (NSString *)loggerName {
    return @"cocoa.lumberjack.aslLogger";
}

@end
