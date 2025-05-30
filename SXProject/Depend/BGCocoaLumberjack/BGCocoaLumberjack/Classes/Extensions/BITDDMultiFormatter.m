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

#import "BITDDMultiFormatter.h"


#if TARGET_OS_IOS
// Compiling for iOS
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000 // iOS 6.0 or later
#define NEEDS_DISPATCH_RETAIN_RELEASE 0
#else                                         // iOS 5.X or earlier
#define NEEDS_DISPATCH_RETAIN_RELEASE 1
#endif
#elif TARGET_OS_WATCH || TARGET_OS_TV
// Compiling for watchOS, tvOS
#define NEEDS_DISPATCH_RETAIN_RELEASE 0
#else
// Compiling for Mac OS X
#if MAC_OS_X_VERSION_MIN_REQUIRED >= 1080     // Mac OS X 10.8 or later
#define NEEDS_DISPATCH_RETAIN_RELEASE 0
#else                                         // Mac OS X 10.7 or earlier
#define NEEDS_DISPATCH_RETAIN_RELEASE 1
#endif
#endif


#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif


@interface BITDDMultiFormatter () {
    dispatch_queue_t _queue;
    NSMutableArray *_formatters;
}

- (BITDDLogMessage *)logMessageForLine:(NSString *)line originalMessage:(BITDDLogMessage *)message;

@end


@implementation BITDDMultiFormatter

- (instancetype)init {
    self = [super init];

    if (self) {
#if MAC_OS_X_VERSION_MIN_REQUIRED >= 1070
        _queue = dispatch_queue_create("cocoa.lumberjack.multiformatter", DISPATCH_QUEUE_CONCURRENT);
#else
        _queue = dispatch_queue_create("cocoa.lumberjack.multiformatter", NULL);
#endif
        _formatters = [NSMutableArray new];
    }

    return self;
}

#if NEEDS_DISPATCH_RETAIN_RELEASE
- (void)dealloc {
    dispatch_release(_queue);
}

#endif

#pragma mark Processing

- (NSString *)formatLogMessage:(BITDDLogMessage *)logMessage {
    __block NSString *line = logMessage->_message;

    dispatch_sync(_queue, ^{
        for (id<BITDDLogFormatter> formatter in self->_formatters) {
            BITDDLogMessage *message = [self logMessageForLine:line originalMessage:logMessage];
            line = [formatter formatLogMessage:message];

            if (!line) {
                break;
            }
        }
    });

    return line;
}

- (BITDDLogMessage *)logMessageForLine:(NSString *)line originalMessage:(BITDDLogMessage *)message {
    BITDDLogMessage *newMessage = [message copy];

    newMessage->_message = line;
    return newMessage;
}

#pragma mark Formatters

- (NSArray *)formatters {
    __block NSArray *formatters;

    dispatch_sync(_queue, ^{
        formatters = [self->_formatters copy];
    });

    return formatters;
}

- (void)addFormatter:(id<BITDDLogFormatter>)formatter {
    dispatch_barrier_async(_queue, ^{
        [self->_formatters addObject:formatter];
    });
}

- (void)removeFormatter:(id<BITDDLogFormatter>)formatter {
    dispatch_barrier_async(_queue, ^{
        [self->_formatters removeObject:formatter];
    });
}

- (void)removeAllFormatters {
    dispatch_barrier_async(_queue, ^{
        [self->_formatters removeAllObjects];
    });
}

- (BOOL)isFormattingWithFormatter:(id<BITDDLogFormatter>)formatter {
    __block BOOL hasFormatter;

    dispatch_sync(_queue, ^{
        hasFormatter = [self->_formatters containsObject:formatter];
    });

    return hasFormatter;
}

@end
