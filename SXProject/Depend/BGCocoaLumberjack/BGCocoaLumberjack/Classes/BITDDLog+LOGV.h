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

// Disable legacy macros
#ifndef BITDD_LEGACY_MACROS
    #define BITDD_LEGACY_MACROS 0
#endif

#import "BITDDLog.h"

/**
 * The constant/variable/method responsible for controlling the current log level.
 **/
#ifndef BITLOG_LEVEL_DEF
    #define BITLOG_LEVEL_DEF bitLogLevel
#endif

/**
 * Whether async should be used by log messages, excluding error messages that are always sent sync.
 **/
#ifndef BITLOG_ASYNC_ENABLED
    #define BITLOG_ASYNC_ENABLED YES
#endif

/**
 * This is the single macro that all other macros below compile into.
 * This big multiline macro makes all the other macros easier to read.
 **/
#define BITLOGV_MACRO(isAsynchronous, lvl, flg, ctx, atag, fnct, frmt, avalist) \
        [BITDDLog log : isAsynchronous                                     \
             level : lvl                                                \
              flag : flg                                                \
           context : ctx                                                \
              file : __FILE__                                           \
          function : fnct                                               \
              line : __LINE__                                           \
               tag : atag                                               \
            format : frmt                                               \
              args : avalist]

/**
 * Define version of the macro that only execute if the log level is above the threshold.
 * The compiled versions essentially look like this:
 *
 * if (logFlagForThisLogMsg & bitLogLevel) { execute log message }
 *
 * When BITLOG_LEVEL_DEF is defined as bitLogLevel.
 *
 * As shown further below, Lumberjack actually uses a bitmask as opposed to primitive log levels.
 * This allows for a great amount of flexibility and some pretty advanced fine grained logging techniques.
 *
 * Note that when compiler optimizations are enabled (as they are for your release builds),
 * the log messages above your logging threshold will automatically be compiled out.
 *
 * (If the compiler sees BITLOG_LEVEL_DEF/bitLogLevel declared as a constant, the compiler simply checks to see
 *  if the 'if' statement would execute, and if not it strips it from the binary.)
 *
 * We also define shorthand versions for asynchronous and synchronous logging.
 **/
#define BITLOGV_MAYBE(async, lvl, flg, ctx, tag, fnct, frmt, avalist) \
        do { if(lvl & flg) BITLOGV_MACRO(async, lvl, flg, ctx, tag, fnct, frmt, avalist); } while(0)

/**
 * Ready to use log macros with no context or tag.
 **/
#define BITDDLogVError(frmt, avalist)   BITLOGV_MAYBE(NO,                BITLOG_LEVEL_DEF, BITDDLogFlagError,   0, nil, __PRETTY_FUNCTION__, frmt, avalist)
#define BITDDLogVWarn(frmt, avalist)    BITLOGV_MAYBE(BITLOG_ASYNC_ENABLED, BITLOG_LEVEL_DEF, BITDDLogFlagWarning, 0, nil, __PRETTY_FUNCTION__, frmt, avalist)
#define BITDDLogVInfo(frmt, avalist)    BITLOGV_MAYBE(BITLOG_ASYNC_ENABLED, BITLOG_LEVEL_DEF, BITDDLogFlagInfo,    0, nil, __PRETTY_FUNCTION__, frmt, avalist)
#define BITDDLogVDebug(frmt, avalist)   BITLOGV_MAYBE(BITLOG_ASYNC_ENABLED, BITLOG_LEVEL_DEF, BITDDLogFlagDebug,   0, nil, __PRETTY_FUNCTION__, frmt, avalist)
#define BITDDLogVVerbose(frmt, avalist) BITLOGV_MAYBE(BITLOG_ASYNC_ENABLED, BITLOG_LEVEL_DEF, BITDDLogFlagVerbose, 0, nil, __PRETTY_FUNCTION__, frmt, avalist)

