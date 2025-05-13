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

/**
 * Legacy macros used for 1.9.x backwards compatibility.
 *
 * Imported by default when importing a BITDDLog.h directly and BITDD_LEGACY_MACROS is not defined and set to 0.
 **/
#if BITDD_LEGACY_MACROS

#warning BITCocoaLumberjack 1.9.x legacy macros enabled. \
Disable legacy macros by importing BITCocoaLumberjack.h or BITDDLogMacros.h instead of BITDDLog.h or add `#define BITDD_LEGACY_MACROS 0` before importing BITDDLog.h.

#ifndef BITLOG_LEVEL_DEF
    #define BITLOG_LEVEL_DEF bitLogLevel
#endif

#define BITLOG_FLAG_ERROR    BITDDLogFlagError
#define BITLOG_FLAG_WARN     BITDDLogFlagWarning
#define BITLOG_FLAG_INFO     BITDDLogFlagInfo
#define BITLOG_FLAG_DEBUG    BITDDLogFlagDebug
#define BITLOG_FLAG_VERBOSE  BITDDLogFlagVerbose

#define BITLOG_LEVEL_OFF     BITDDLogLevelOff
#define BITLOG_LEVEL_ERROR   BITDDLogLevelError
#define BITLOG_LEVEL_WARN    BITDDLogLevelWarning
#define BITLOG_LEVEL_INFO    BITDDLogLevelInfo
#define BITLOG_LEVEL_DEBUG   BITDDLogLevelDebug
#define BITLOG_LEVEL_VERBOSE BITDDLogLevelVerbose
#define BITLOG_LEVEL_ALL     BITDDLogLevelAll

#define BITLOG_ASYNC_ENABLED YES

#define BITLOG_ASYNC_ERROR    ( NO && BITLOG_ASYNC_ENABLED)
#define BITLOG_ASYNC_WARN     (YES && BITLOG_ASYNC_ENABLED)
#define BITLOG_ASYNC_INFO     (YES && BITLOG_ASYNC_ENABLED)
#define BITLOG_ASYNC_DEBUG    (YES && BITLOG_ASYNC_ENABLED)
#define BITLOG_ASYNC_VERBOSE  (YES && BITLOG_ASYNC_ENABLED)

#define BITLOG_MACRO(isAsynchronous, lvl, flg, ctx, atag, fnct, frmt, ...) \
        [BITDDLog log : isAsynchronous                                     \
             level : lvl                                                \
              flag : flg                                                \
           context : ctx                                                \
              file : __FILE__                                           \
          function : fnct                                               \
              line : __LINE__                                           \
               tag : atag                                               \
            format : (frmt), ## __VA_ARGS__]

#define LOG_MAYBE(async, lvl, flg, ctx, fnct, frmt, ...)                       \
        do { if(lvl & flg) BITLOG_MACRO(async, lvl, flg, ctx, nil, fnct, frmt, ##__VA_ARGS__); } while(0)

#define LOG_OBJC_MAYBE(async, lvl, flg, ctx, frmt, ...) \
        LOG_MAYBE(async, lvl, flg, ctx, __PRETTY_FUNCTION__, frmt, ## __VA_ARGS__)

#define BITDDLogError(frmt, ...)   LOG_OBJC_MAYBE(BITLOG_ASYNC_ERROR,   BITLOG_LEVEL_DEF, BITLOG_FLAG_ERROR,   0, frmt, ##__VA_ARGS__)
#define BITDDLogWarn(frmt, ...)    LOG_OBJC_MAYBE(BITLOG_ASYNC_WARN,    BITLOG_LEVEL_DEF, BITLOG_FLAG_WARN,    0, frmt, ##__VA_ARGS__)
#define BITDDLogInfo(frmt, ...)    LOG_OBJC_MAYBE(BITLOG_ASYNC_INFO,    BITLOG_LEVEL_DEF, BITLOG_FLAG_INFO,    0, frmt, ##__VA_ARGS__)
#define BITDDLogDebug(frmt, ...)   LOG_OBJC_MAYBE(BITLOG_ASYNC_DEBUG,   BITLOG_LEVEL_DEF, BITLOG_FLAG_DEBUG,   0, frmt, ##__VA_ARGS__)
#define BITDDLogVerbose(frmt, ...) LOG_OBJC_MAYBE(BITLOG_ASYNC_VERBOSE, BITLOG_LEVEL_DEF, BITLOG_FLAG_VERBOSE, 0, frmt, ##__VA_ARGS__)

#endif
