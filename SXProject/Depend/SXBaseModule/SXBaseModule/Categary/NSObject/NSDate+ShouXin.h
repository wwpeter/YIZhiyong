//
//  NSDate+ShouXin.h
//  SXBaseModule
//
//  Created by 王威 on 2024/1/2.
//
//  日期扩展

//分钟、小时、天、年对应的秒数
#define SEC_MINUTE      60
#define SEC_HOUR        (60*SEC_MINUTE)
#define SEC_DAY         (24*SEC_HOUR)
#define SEC_YEAR        (365*SEC_DAY)

typedef struct
{
    int year;
    int month;
    int day;
    int week;
    int hour;
    int minute;
    int second;
}Time_Info;


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface NSDate (ShouXin)

/**
 获取当前设置的日历，默认使用NSCalendarIdentifierGregorian
 
 @return NSCalendar
 */
+ (NSCalendar *) lc_currentCalendar;

/**
 设置默认的日历
 
 @param identifier NSCalendarIdentifier
 */
+ (void)lc_setCurrentCanlendar:(NSCalendarIdentifier)identifier;

/**
日期转换为当前系统日历日期
@param date 当前日期
@param format 当前日期格式
 
@return 系统日历下日期
*/
+ (NSString *)lc_dateCoverToSystemCalendar:(NSDate *)date format:(NSString *)format;

/**
日期转换为目标日历日期
@param date 当前日期
@param calendar 要设置的日历
@param format 当前日期格式
 
@return 目标日历下日期
*/
+ (NSString *)lc_dateCover:(NSDate *)date calendar:(NSCalendar *)calendar format:(NSString *)format;

//常用属性
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger weekOfYear;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger year;


/**
 *  将NSString转为NSDate
 *
 *  @param dateString 日期字符串
 *  @param format 日期格式
 *  @return 日期
 */
+ (NSDate *)sx_dateOfString:(NSString*)dateString withFormat:(NSString *)format;

/**
 *  将int毫秒数转为HH:mm:ss格式
 *
 *  @param time 时间毫秒数
 *
 *  @return HH:mm:ss格式时间
 */
+ (NSString*)sx_timeByLength:(NSInteger)time;

/**
 *  将NSDate转为描述
 *  @return 昨天 12:23
 */
- (NSString *)sx_dateDescription;

/**
 *  将NSString转为NSDate格式
 *
 *  @param timeString 时间2014-12-1 12:12:12
 *
 *  @return NSDate
 */
+ (NSDate *)sx_stringToDate:(NSString *)timeString format:(NSString*)format;

/**
 *  将NSInteger转为特定格式字符串
 *
 *  @param NSTimeInterval 时间毫秒数
 *  @param format     格式
 *
 *  @return 时间
 */
+ (NSString *)sx_stringOfTimeInterval:(NSTimeInterval)timeInterval format:(NSString*)format;

//常用日期方法
/**
 *  返回指定日期的 xxxx-xx-xx 00:00:00形式
 *  @return 日期
 */
- (NSDate *)sx_dateAtStartOfDay;

/**
 *  返回指定日期的 xxxx-xx-xx 23:59:59形式
 *  @return 日期
 */
- (NSDate *)sx_dateAtEndOfDay;

/**
 *  返回前一天
 *  @return 日期
 */
- (NSDate *)sx_dateBeforeDay;

/**
 *  返回后一天
 *  @return 日期
 */
- (NSDate *)sx_dateAfterDay;


//字符串方法
/**
 *  日期的字符串的默认形式,yyyy-MM-dd HH:mm:ss
 *  @return 日期
 */
- (NSString *)sx_stringRepresentation;

/**
 *  日期的字符串形式
 *
 *  @param formator 日期格式
 *
 *  @return 日期
 */
- (NSString *)sx_stringOfDateWithFormator:(NSString *)formator;

- (NSString *)sx_stringDateAtStartOfDay;

- (NSString *)sx_stringDateAtEndOfDay;


//时间比较方法
- (BOOL)sx_isEqualToDateIgnoringTime:(NSDate *)compareDate;
- (BOOL)sx_isToday;
- (BOOL)sx_isYesterday;
- (BOOL)sx_isInFuture;
- (BOOL)sx_isInPast;

#pragma mark - PubFun 分离

+ (NSString *)sx_currentTimeString;

- (Time_Info)sx_timeInfo;

+ (NSDate *)sx_dateFromString:(NSString *)string;

+ (NSDate *)sx_dateFromString:(NSString *)string format:(NSString *)format;

/**
 *  返回当天的日期及时间
 *
 *  @param string 日期字符串
 *
 *  @return 日期
 */
+ (NSDate *)sx_todayFromString:(NSString *)string;

+ (NSString *)sx_stringOfDate:(NSDate *)date format:(NSString *)format;

+ (NSDate *)sx_dateOfTimeInfo:(Time_Info)timeInfo;

///dateString返回HH:mm格式
+ (NSString *)sx_stringDateBeginWithHour:(NSString *)dateString;

+ (NSString *)sx_nextDayStringWithString:(NSString *)string;

///时、分是否晚于当前时间
+ (BOOL)sx_isLaterThanCurrentTimeByHour:(int)hour minute:(int)minute;

///返回yyyy-mm-dd HH:mm:ss的格式
+ (NSString *)sx_stringDate:(NSDate *)date;
@end

NS_ASSUME_NONNULL_END
