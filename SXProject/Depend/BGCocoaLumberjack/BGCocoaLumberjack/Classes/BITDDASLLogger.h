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

#import <Foundation/Foundation.h>

// Disable legacy macros
#ifndef BITDD_LEGACY_MACROS
    #define BITDD_LEGACY_MACROS 0
#endif

#import "BITDDLog.h"

// Custom key set on messages sent to ASL
extern const char* const bitkDDASLKeyBITDDLog;

// Value set for bitkDDASLKeyBITDDLog
extern const char* const bitkDDASLBITDDLogValue;

/**
 * This class provides a logger for the Apple System Log facility.
 *
 * As described in the "Getting Started" page,
 * the traditional NSLog() function directs its output to two places:
 *
 * - Apple System Log
 * - StdErr (if stderr is a TTY) so log statements show up in Xcode console
 *
 * To duplicate NSLog() functionality you can simply add this logger and a tty logger.
 * However, if you instead choose to use file logging (for faster performance),
 * you may choose to use a file logger and a tty logger.
 **/
@interface BITDDASLLogger : BITDDAbstractLogger <BITDDLogger>

/**
 *  Singleton method
 *
 *  @return the shared instance
 */
@property (class, readonly, strong) BITDDASLLogger *sharedInstance;

// Inherited from BITDDAbstractLogger

// - (id <BITDDLogFormatter>)logFormatter;
// - (void)setLogFormatter:(id <BITDDLogFormatter>)formatter;

@end
