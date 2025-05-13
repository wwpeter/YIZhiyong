//
//  BITCocoaLumberjackMacro.h
//
//  Created by jiaguoshang on 2018/11/28.
//  Copyright © 2018年 jiaguoshang All rights reserved.
//

#ifndef BITCocoaLumberjackMacro_h
#define BITCocoaLumberjackMacro_h

#ifndef LOG_DOCUMENT_DICRECTORY
//日志文档目录，若定义就把日志存在NSDocumentDirectory目录下，若不定义就存在NSCachesDirectory目录下
#define LOG_DOCUMENT_DICRECTORY
#endif

//自定义日志开关
#ifndef FLDDLogError
#define FLDDLogError(format, ...)                                                                                   \
{                                                                                                                   \
BITDDLogError((@"%@.m:%s:%d Err:" format), NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);                \
}
#endif

#ifndef FLDDLogWarn
#define FLDDLogWarn(format, ...)                                                                                   \
{                                                                                                                  \
BITDDLogWarn((@"%@.m:%s:%d Warn:" format), NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);               \
}
#endif

#ifndef FLDDLogInfo
#define FLDDLogInfo(format, ...)                                                                                   \
{                                                                                                                  \
BITDDLogInfo((@"%@.m:%s:%d Info:" format), NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);               \
}
#endif


#ifndef FLDDLogDebug
#define FLDDLogDebug(format, ...)                                                                                    \
{                                                                                                                 \
BITDDLogDebug((@"%@.m:%s:%d Debug:" format), NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);               \
}
#endif


#ifndef FLDDLogVerbose
#define FLDDLogVerbose(format, ...)                                                                               \
{                                                                                                                 \
BITDDLogVerbose((@"%@.m:%s:%d Verbose:" format), NSStringFromClass([self class]), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);        \
}
#endif

#endif /* BITCocoaLumberjackMacro_h */
