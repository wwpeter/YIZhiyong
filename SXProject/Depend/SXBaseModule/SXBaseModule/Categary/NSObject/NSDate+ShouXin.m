//
//  NSDate+ShouXin.m
//  SXBaseModule
//
//  Created by 王威 on 2024/1/2.
//

#import "NSDate+ShouXin.h"
#import "SXDateFormatter.h"
#import "NSString+LeChange.h"

static const unsigned componentFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal;
static NSCalendar *sharedCalendar = nil;

@implementation NSDate (ShouXin)
+ (NSCalendar *) sx_currentCalendar
{
    if (!sharedCalendar) {
        sharedCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        // 监听系统时区变化
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(systemTimeZoneChange) name:UIApplicationSignificantTimeChangeNotification object:nil];
    }
    
    return sharedCalendar;
}

+ (void)systemTimeZoneChange {
    if (sharedCalendar) {
        // 时区发生变化 更新时区成员变量值
        sharedCalendar.timeZone = [NSTimeZone systemTimeZone];
    }
}


+ (void)sx_setCurrentCanlendar:(NSCalendarIdentifier)identifier
{
    sharedCalendar = [NSCalendar calendarWithIdentifier:identifier];
}

+ (NSString *)sx_dateCoverToSystemCalendar:(NSDate *)date format:(NSString *)format {
    return [self sx_dateCover:date calendar:[NSCalendar currentCalendar] format:format];
}

+ (NSString *)sx_dateCover:(NSDate *)date calendar:(NSCalendar *)calendar format:(NSString *)format {
    if (!date) {
        return @"";
    }
    NSDateComponents *components = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:date];
    NSDate *buddhistDate = [calendar dateFromComponents:components];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:buddhistDate]?:@"";
}

+ (NSDate *)sx_dateOfString:(NSString*)dateString withFormat:(NSString *)format {
    //NSDateFormatter *formatter = [NSDateFormatter new];
    SXDateFormatter *formatter = [[SXDateFormatter alloc]initWithGregorianCalendar];
    formatter.dateFormat = format;
    NSDate *date = [formatter dateFromString:dateString];
    return date;
}

- (NSString *)sx_dateDescription {
    //NSDateFormatter *formatter = [NSDateFormatter new];
    SXDateFormatter *formatter = [[SXDateFormatter alloc]initWithGregorianCalendar];
    NSDate *todayEndDate = [[NSDate date] sx_dateAtEndOfDay];
    
    NSTimeInterval dayInterval = 3600 * 24;
    NSTimeInterval dateInterval = [self timeIntervalSince1970];
    NSTimeInterval todayEndInterval = [todayEndDate timeIntervalSince1970];
    NSTimeInterval todayStartInterval = todayEndInterval - dayInterval + 1;
    
    
    if (dateInterval >= todayStartInterval && dateInterval <= todayEndInterval) {
        formatter.dateFormat = @"HH:mm";
        return [formatter stringFromDate:self];
    } else if (dateInterval < todayStartInterval  && dateInterval >= todayStartInterval - dayInterval) {
        formatter.dateFormat = @"HH:mm";
        return @"Yesterday";
    }
    
    formatter.dateFormat = @"yy/MM/dd";
    return [formatter stringFromDate:self];
}

+ (NSDate *)sx_stringToDate:(NSString *)timeString format:(NSString*)format{
    //NSDateFormatter *formatter = [NSDateFormatter new];
    SXDateFormatter *formatter = [[SXDateFormatter alloc]initWithGregorianCalendar];
    formatter.dateFormat = format;
    NSDate *date = [formatter dateFromString:timeString];
    
    return date;
}

+ (NSString *)sx_stringOfTimeInterval:(NSTimeInterval)timeInterval format:(NSString*)format {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return [NSDate sx_stringOfDate:date format:format];
}

#pragma mark - Time Length

+ (NSString*)sx_timeByLength:(NSInteger)time
{
    NSInteger hour = time / (60 * 60);
    NSInteger min =  (time % (60 * 60)) / 60;
    
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)hour, (long)min];
}


#pragma mark - Common Properties
- (NSInteger)hour
{
    NSDateComponents *components = [[NSDate sx_currentCalendar] components:componentFlags fromDate:self];
    return components.hour;
}

- (NSInteger)minute
{
    NSDateComponents *components = [[NSDate sx_currentCalendar] components:componentFlags fromDate:self];
    return components.minute;
}

- (NSInteger)seconds
{
    NSDateComponents *components = [[NSDate sx_currentCalendar] components:componentFlags fromDate:self];
    return components.second;
}

- (NSInteger)day
{
    NSDateComponents *components = [[NSDate sx_currentCalendar] components:componentFlags fromDate:self];
    return components.day;
}

- (NSInteger)month
{
    NSDateComponents *components = [[NSDate sx_currentCalendar] components:componentFlags fromDate:self];
    return components.month;
}

- (NSInteger)weekOfYear
{
    NSDateComponents *components = [[NSDate sx_currentCalendar] components:componentFlags fromDate:self];
    return components.weekOfYear;
}

- (NSInteger)weekday
{
    NSDateComponents *components = [[NSDate sx_currentCalendar] components:componentFlags fromDate:self];
    return components.weekday;
}

- (NSInteger)year
{
    NSDateComponents *components = [[NSDate sx_currentCalendar] components:componentFlags fromDate:self];
    return components.year;
}

#pragma mark - Common Days Operation
- (NSString *)sx_stringRepresentation
{
    //NSDateFormatter *format = [[NSDateFormatter alloc]init];
    SXDateFormatter *format = [[SXDateFormatter alloc]initWithGregorianCalendar];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *string = [format stringFromDate:self];
    return string;
}

- (NSString *)sx_stringOfDateWithFormator:(NSString *)formator
{
    //NSDateFormatter *format = [[NSDateFormatter alloc]init];
    SXDateFormatter *format = [[SXDateFormatter alloc]initWithGregorianCalendar];
    [format setDateFormat:formator];
    NSString *string = [format stringFromDate:self];
    return string;
}

- (NSDate *)sx_dateAtStartOfDay
{
    NSDateComponents *components = [[NSDate sx_currentCalendar] components:componentFlags fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [[NSDate sx_currentCalendar] dateFromComponents:components];
}

- (NSDate *)sx_dateAtEndOfDay
{
    NSDateComponents *components = [[NSDate sx_currentCalendar] components:componentFlags fromDate:self];
    components.hour = 23; // Thanks Aleksey Kononov
    components.minute = 59;
    components.second = 59;
    return [[NSDate sx_currentCalendar] dateFromComponents:components];
}

- (NSDate *)sx_dateBeforeDay
{
    return [self dateByAddingTimeInterval:-SEC_DAY];
}

- (NSDate *)sx_dateAfterDay
{
    return [self dateByAddingTimeInterval:SEC_DAY];
}



#pragma mark - String Methods
- (NSString *)sx_stringDateAtStartOfDay
{
    NSDate *startDate = [self sx_dateAtStartOfDay];
    return [startDate sx_stringRepresentation];
}

- (NSString *)sx_stringDateAtEndOfDay
{
    NSDate *endDate = [self sx_dateAtEndOfDay];
    return [endDate sx_stringRepresentation];
}

#pragma mark - Compare Methods
- (BOOL)sx_isEqualToDateIgnoringTime:(NSDate *)compareDate
{
    NSDateComponents *components1 = [[NSDate sx_currentCalendar] components:componentFlags fromDate:self];
    NSDateComponents *components2 = [[NSDate sx_currentCalendar] components:componentFlags fromDate:compareDate];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)sx_isToday
{
    return [self sx_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)sx_isYesterday
{
    NSCalendar *calendar = [NSDate sx_currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:self toDate:[NSDate date] options:0];
    return components.day == 1;
}

- (BOOL)isEarlierThanDate:(NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)isLaterThanDate:(NSDate *) aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)sx_isInFuture
{
    return ([self isLaterThanDate:[NSDate date]]);
}

- (BOOL)sx_isInPast
{
    return ([self isEarlierThanDate:[NSDate date]]);
}


#pragma mark -

+ (NSString *)sx_currentTimeString;
{
    NSDate *nowdate = [NSDate date];
    //NSDateFormatter* format = [[NSDateFormatter alloc] init];//格式化
    SXDateFormatter *format = [[SXDateFormatter alloc]initWithGregorianCalendar];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* strCurrentTime = [format stringFromDate:nowdate];
    
    return strCurrentTime;
}

- (Time_Info)sx_timeInfo
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay |
    NSCalendarUnitWeekOfYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    Time_Info timeInfo = {0};
    timeInfo.year = (int)[comps year];
    timeInfo.month = (int)[comps month];
    timeInfo.day = (int)[comps day];
    timeInfo.week = (int)[comps weekOfYear];
    timeInfo.hour = (int)[comps hour];
    timeInfo.minute = (int)[comps minute];
    timeInfo.second = (int)[comps second];
    
    return timeInfo;
}

+ (NSDate *)sx_dateFromString:(NSString *)string
{
    if (string == nil)
    {
        return nil;
    }
    
    //NSDateFormatter *format = [[NSDateFormatter alloc] init];
    SXDateFormatter *format = [[SXDateFormatter alloc]initWithGregorianCalendar];
    
    NSDate *date = nil;
    
    //带日期格式:
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    date = [format dateFromString:string];
    
    //不带日期格式的 HH:mm:ss
    if (date == nil)
    {
        [format setDateFormat:@"HH:mm:ss"];
        date = [format dateFromString:string];
    }
    
    //不带日期格式的 HH:mm
    if (date == nil)
    {
        [format setDateFormat:@"HH:mm"];
        date = [format dateFromString:string];
    }
    
    //其他格式的不处理
    if (date == nil)
    {
        return nil;
    }
    
    return date;
}

+ (NSDate *)sx_todayFromString:(NSString *)string
{
    NSDate *date = [self sx_dateFromString:string];
    
    if (date) {
        Time_Info currentTime = [[NSDate date] sx_timeInfo];
        Time_Info referTime = [date sx_timeInfo];
        referTime.year = currentTime.year;
        referTime.month = currentTime.month;
        referTime.day = currentTime.day;
        date = [self sx_dateOfTimeInfo:referTime];
    }
    
    return date;
}

+ (NSDate *)sx_dateFromString:(NSString *)string format:(NSString *)format
{
    //NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    SXDateFormatter *formatter = [[SXDateFormatter alloc]initWithGregorianCalendar];
    [formatter setDateFormat:format];
    return [formatter dateFromString:string];
}

+ (NSString *)sx_stringOfDate:(NSDate *)date format:(NSString *)format
{
    //NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    SXDateFormatter *formatter = [[SXDateFormatter alloc]initWithGregorianCalendar];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:date];
}


+ (NSDate *)sx_dateOfTimeInfo:(Time_Info)timeInfo
{
    //NSDateFormatter *format = [[NSDateFormatter alloc]init];
    SXDateFormatter *format = [[SXDateFormatter alloc]initWithGregorianCalendar];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [NSString stringWithFormat:@"%d-%02d-%2d %2d:%2d:%2d", timeInfo.year, timeInfo.month,
                         timeInfo.day, timeInfo.hour, timeInfo.minute, timeInfo.second];
    NSDate *date = [format dateFromString:strDate];
    return date;
}

+ (NSString *)sx_nextDayStringWithString:(NSString *)string
{
    if (string == nil) {
        return nil;
    }
    
    NSDate *date = [self sx_dateFromString:string];
    NSDate *nextDate = [[NSDate date] dateByAddingTimeInterval:24*3600];
    Time_Info nextInfo = [nextDate sx_timeInfo];
    Time_Info timeInfo = [date sx_timeInfo];
    
    timeInfo.year = nextInfo.year;
    timeInfo.month = nextInfo.month;
    timeInfo.day = nextInfo.day;
    
    nextDate = [self sx_dateOfTimeInfo:timeInfo];
    NSLog(@"next date:%@", [self sx_stringDate:nextDate]);
    return [self sx_stringDate:nextDate];
}

///返回yyyy-mm-dd HH:mm:ss的格式
+ (NSString *)sx_stringDate:(NSDate *)date
{
    if (date == nil) {
        return nil;
    }
    
    //NSDateFormatter *format = [[NSDateFormatter alloc]init];
    SXDateFormatter *format = [[SXDateFormatter alloc]initWithGregorianCalendar];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *string = [format stringFromDate:date];
    return string;
}

///dateString返回HH:mm格式
+ (NSString *)sx_stringDateBeginWithHour:(NSString *)dateString
{
    if (dateString == nil) {
        return nil;
    }
    
    NSDate *date = [self sx_dateFromString:dateString];
    if (date)
    {
        //NSDateFormatter *format = [[NSDateFormatter alloc]init];
        SXDateFormatter *format = [[SXDateFormatter alloc]initWithGregorianCalendar];
        [format setDateFormat:@"HH:mm"];
        NSString *string = [format stringFromDate:date];
        return string;
    }
    
    return nil;
}

///时、分是否晚于当前时间
+ (BOOL)sx_isLaterThanCurrentTimeByHour:(int)hour minute:(int)minute
{
    Time_Info currentTime = [[NSDate date] sx_timeInfo];
    if (currentTime.hour * 60 * 60 + currentTime.minute * 60 + currentTime.second > hour * 60 * 60 + minute * 60 ) {
        return NO;
    }
    return YES;
}

@end
