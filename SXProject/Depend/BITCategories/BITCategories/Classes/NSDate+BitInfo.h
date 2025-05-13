//
//  NSDate+BitInfo.h
//  Pods
//
//  Created        on 2017/7/21.
//
//

#import <Foundation/Foundation.h>
/*
 @"yyyy-MM-dd"                     2107-01-01
 @"yyyy-MM-dd HH:mm:ss.SSS"        2107-01-01 11:24:20:123
 @"yyyy-MM-dd aahh:mm"             2107-01-01 上午11：45
 @"yy-MM-ddEEE aahh:mm"            2107-01-01 星期一 上午11：45
 
 
 @"yyyy/MM/dd"                     2107/01/01
 @"yyyy-MM-dd HH:mm:ss.SSS"        2107/01/01 11:24:20:123
 @"yyyy/MM/dd aahh:mm"             2107/01/01 上午11：45
 @"yyyy/MM/ddEEE aahh:mm"          2107/01/01 星期一 上午11：45
 
 
 @"yyyy年MM月dd日 EEEE aahh:mm"     2107年1月1日 星期一 上午11：45
 @"yyyy年MM月dd日 HH:mm"            2107年1月1日 11：45
 
 */

/*
 longlong <-- timeInterval --> NSDate <-- NSDateFormatter  --> NSString
 */

@interface NSDate (BitInfo)

+(NSString *)getStringFromDate:(NSDate *)date formatString:(NSString *)formatString;
+(NSString *)getStringFromLongLong:(long long)msSince1970 formatString:(NSString *)formatString;


+(NSDate *)getDateFromString:(NSString *)dateStr formatString:(NSString *)formatString;
+(NSDate*)dateFromLongLong:(long long)msSince1970;


+(long long)longLongFromDate:(NSDate*)date;
+(long long)longLongFromDateString:(NSString*)dateStr formatString:(NSString *)formatString;


+ (NSInteger)getAgeFromBirthday:(NSDate *)birthday;

/** 时间戳于当前相差几天 */
+ (NSInteger)getTimerNumberOfDaysToday:(NSTimeInterval)msSince1970;

/** 时间间隔转天数，小时。。。 */
+ (NSString *)timeWith:(NSTimeInterval)time;

/** 用于倒计时计时，转成时分秒，不带单位 */
+ (NSString *)countDownstringForTime:(NSTimeInterval)time;

/** 是否是今天 */
- (BOOL)isToday;

/** 是否为昨天 */
- (BOOL)isYesterday;

+(NSString *)getNextDay;

/**
 比较两个日期

 @param oneDay 日期1
 @param anotherDay 日期2
 @return 0 = 同一天，1 = oneDate在anotherDay之后，-1 = oneDate在anotherDay之前
 */
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;


/**
 判断是否是同一天/同一个月/同一年

 @param date1 date1
 @param date2 date2
 @return 0.同天，1.同月，2.同年
 */
+ (int)isSameDate:(NSDate *)date1 date2:(NSDate *)date2;

/**
 时间差

 @param toDate 时间
 @return NSDateComponents
 */
- (NSDateComponents *)componentsToDate:(NSDate *)toDate;


/**
 判断系统时间是24小时制还是12小时制

 @return YES-12 ,NO-24
 */
+ (BOOL)determineSystemTimeFormat;


// 一个月的第一天，最后一天
+(NSArray *)getStartTimeAndFinalTime;

@end
