//
//  NSDate+BitInfo.m
//  Pods
//
//  Created        on 2019/5/21.
//
//

#import "NSDate+BitInfo.h"


@implementation NSDate (BitInfo)

+ (NSString *)getStringFromDate:(NSDate *)date formatString:(NSString *)formatString{
    if (date == nil || formatString == nil) {
        return nil;
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    NSString *showtimeNew = [formatter stringFromDate:date];
    return showtimeNew;
    
}


+ (NSString *)getStringFromLongLong:(long long)msSince1970 formatString:(NSString *)formatString{
    if (msSince1970 == 0 || formatString == nil) {
        return nil;
    }
    NSTimeInterval time = msSince1970;
    if ([formatString containsString:@"SSS"]) {
        time = time/ 1000.0f;
    }
    NSDate *date =  [NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatString];
    NSString *showtimeNew = [formatter stringFromDate:date];
    return showtimeNew;
    
}


//MARK: 时间字符串转Date
+(NSDate *)getDateFromString:(NSString *)dateStr formatString:(NSString *)formatString{
    if (dateStr == nil || formatString == nil) {
        return nil;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter  setDateFormat:formatString];
    NSDate* date = [dateFormatter dateFromString:dateStr];
    return date;
}
+(NSDate*)dateFromLongLong:(long long)msSince1970{
    if (msSince1970 == 0) {
        return nil;
    }
    //    return [NSDate dateWithTimeIntervalSince1970:msSince1970 / 1000]; 毫秒
    
    NSTimeInterval timestamp =  msSince1970;
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}



// return longlong
+(long long)longLongFromDate:(NSDate*)date{
    if (date == nil) {
        return 0.0;
    }
    //    return [date timeIntervalSince1970] * 1000; //毫秒返回
    return [date timeIntervalSince1970] ;
}

+(long long)longLongFromDateString:(NSString*)dateStr formatString:(NSString *)formatString{
    if (dateStr == nil) {
        return 0.0;
    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter  setDateFormat:formatString];
    NSDate* date = [dateFormatter dateFromString:dateStr];
    //    return [date timeIntervalSince1970] * 1000; //毫秒返回
    return [date timeIntervalSince1970];
    
    
}


+(NSString *)getNextDay{
    NSDate *  senddate=[NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:senddate];
    //今天
//    [components setDay:([components day])];
    //明天
    [components setDay:([components day]+1)];
    //后天
//    [components setDay:([components day]+2)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString * dataStri = [NSString stringWithFormat:@"%@",[dateday stringFromDate:beginningOfWeek]];
    return dataStri;
}




/**
 *  将一个时间变为只有年月日的时间(时分秒都是0)
 */
- (NSDate *)ymd
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    return [fmt dateFromString:[fmt stringFromDate:self]];
}


+ (NSInteger)getAgeFromBirthday:(NSDate *)birthday
{
    NSDate *currentDate = [NSDate date];
    //创建日历(格里高利历)
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //设置component的组成部分
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    //按照组成部分格式计算出生日期与现在时间的时间间隔
    NSDateComponents *date = [calendar components:unitFlags fromDate:birthday toDate:currentDate options:0];
    return date.year;
}

+ (NSInteger)getTimerNumberOfDaysToday:(NSTimeInterval)msSince1970 {
    //现在的时间
    NSDate * nowDate = [NSDate date];

    //字符串转NSDate格式的方法
    NSDate * ValueDate = [NSDate dateWithTimeIntervalSince1970:msSince1970];
    //计算两个中间差值(秒)
    NSTimeInterval time = [ValueDate timeIntervalSinceDate:nowDate];
    
    //开始时间和结束时间的中间相差的时间
    NSInteger days;
    days = ((int)time)/(3600*24);  //一天是24小时*3600秒
    return days;
}

+ (NSString *)timeWith:(NSTimeInterval)time
{
    NSMutableString *s = nil;
    NSInteger t = time;
    NSString *d = nil;
    NSString *h = nil;
    NSString *m = nil;
    if(t / (24 * 60 * 60) > 0){
        d = [NSString stringWithFormat:@"%ld天",t / (24 * 60 * 60)];
        t = t % (24 * 60 * 60);
    }
    if(t / (60 * 60) > 0){
        h = [NSString stringWithFormat:@"%ld小时",t / (60 * 60)];
        t = t % (60 * 60);
    }
    if(t  > 0){
        if(t % 60 == 0){
            m = [NSString stringWithFormat:@"%ld分钟",t / 60 ];
        }else{
            m = [NSString stringWithFormat:@"%ld分钟",t /60 +1];
        }
    }
    if(d){
        if(h && m){
            s = [NSString stringWithFormat:@"%@%@%@",d,h,m].mutableCopy;
        }else if(h){
            s = [NSString stringWithFormat:@"%@%@",d,h].mutableCopy;
        }else if(m){
            s = [NSString stringWithFormat:@"%@%@",d,m].mutableCopy;
        }else{
            s = [NSString stringWithFormat:@"%@",d].mutableCopy;
        }
    }else if(h){
        if(m){
            s = [NSString stringWithFormat:@"%@%@",h,m].mutableCopy;
        }else{
            s = [NSString stringWithFormat:@"%@",h].mutableCopy;
        }
    }else if(m){
        s = [NSString stringWithFormat:@"%@",m].mutableCopy;
    }else{
        s = [NSString stringWithFormat:@"0"].mutableCopy;
    }
    return s;
}

+ (NSString *)countDownstringForTime:(NSTimeInterval)time {
    
    NSMutableString *mutableString = [[NSMutableString alloc]init];
    
    NSInteger day = time / (24 * 60 * 60);
    if (day > 0) {
        [mutableString appendString:[NSString stringWithFormat:@"%ld天 ", day]];
    }
    
    time = time - day * 24 * 60 * 60;
    NSInteger hour = time / (60 * 60);
    if (hour > 0) {
        [mutableString appendString:[NSString stringWithFormat:@"%.2ld:", hour]];
    }
    
    time = time - hour * 60 * 60;
    NSInteger minute = time / 60;
    [mutableString appendString:[NSString stringWithFormat:@"%.2ld:", minute]];
    
    time = time - minute * 60;
    NSInteger second = time;
    [mutableString appendString:[NSString stringWithFormat:@"%.2ld", second]];
    
    return mutableString;
}

//MARK: 是否是今天
- (BOOL)isToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar components:NSCalendarUnitDay fromDate:[NSDate date].ymd toDate:self.ymd options:0].day == 0;
}

//MARK: 是否为昨天
- (BOOL)isYesterday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:self.ymd toDate:[NSDate date].ymd options:0];
    return cmps.day == 1;
}

//MARK: 消息时间显示格式模仿微信
- (NSString *)messageDisplayForamterChatList:(BOOL)chatList {
    
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    // created_at(NSString) --> NSDate
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss z yyyy";
    
    // 设置时间所属的区域
    //如果是真机环境, 需要设置locale, 说明时间所属的区域
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 当前时间
    NSDate *now = [NSDate date];
    
    //判断日式格式
    NSString*formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    
    NSRange containsA =[formatStringForHours rangeOfString:@"a"];
    
    BOOL hasAMPM =containsA.location != NSNotFound;
    
    NSDateComponents *cmps = [self componentsToDate:now];
    
    NSDateFormatter *fmtDay = [[NSDateFormatter alloc] init];
    fmtDay.dateFormat = @"HH:mm";
    NSDateFormatter *fmtHourDay = [[NSDateFormatter alloc] init];
    fmtHourDay.dateFormat = @"HH";
    NSString *hourTime = [fmtHourDay stringFromDate:self];
    
    NSDateFormatter *fmtMisDay = [[NSDateFormatter alloc] init];
    fmtMisDay.dateFormat = @"mm";
    NSString *misDayTime = [fmtMisDay stringFromDate:self];
    
    
    NSString *smalHours = nil; // 凌晨
    NSString *morningHours = nil; //上午
    NSString *afternoonHours = nil; // 下午
    
    NSString *twentyFour = nil;
    NSString *tempStr = nil;
    if (hasAMPM == true) {
        if (hourTime.doubleValue > 0 && hourTime.doubleValue < 6 ) {
            NSString *substring = [[fmtDay stringFromDate:self] substringFromIndex:1];
            smalHours = [NSString stringWithFormat:@"凌晨%@",substring]; //今天显示时间
            tempStr = smalHours;
        }else if (hourTime.doubleValue >= 6 && hourTime.doubleValue < 12){
            NSString *substring = [fmtDay stringFromDate:self];
            
            if (hourTime.doubleValue < 10) {
                substring = [substring substringFromIndex:1];
            }
            morningHours = [NSString stringWithFormat:@"上午%@",substring]; //今天显示时间
            tempStr = morningHours;
        }else if (hourTime.integerValue == 12) {//下午12点时,hour值为12
            NSInteger hour = (NSInteger )(hourTime.doubleValue);
            smalHours  =[NSString stringWithFormat:@"下午%ld:%@",(long)hour,misDayTime];
            tempStr = smalHours;
        } else if (hourTime.integerValue == 0) {
            NSInteger hour = (NSInteger )(hourTime.doubleValue);
            afternoonHours  =[NSString stringWithFormat:@"凌晨%ld:%@",(long)hour,misDayTime]; //今天显示时间
            tempStr = afternoonHours;
        } else  {
            NSInteger hour = (NSInteger )(hourTime.doubleValue - 12);
            afternoonHours  =[NSString stringWithFormat:@"下午%ld:%@",(long)hour,misDayTime]; //今天显示时间
            tempStr = afternoonHours;
        }
        
    }else{
        twentyFour =[fmtDay stringFromDate:self];
        tempStr = twentyFour;
    }
    if (self.isToday) { // 今天
        return tempStr;
    } else if (self.isYesterday) { // 昨天
        return [NSString stringWithFormat:@"昨天 %@",tempStr];
    }
    else if(cmps.day >= 1 && (cmps.day < 7 && cmps.hour < hourTime.doubleValue)){
        //昨天之前7天
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setDateStyle:NSDateFormatterFullStyle];
        
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        
        NSString *dateString = [dateFormatter stringFromDate:self];
        NSString *weekString = [[dateString componentsSeparatedByString:@" "] lastObject];
        if (chatList) {
            return weekString;
        }
        
        return [NSString stringWithFormat:@"%@ %@",weekString, tempStr];
        
    }
    else{
        if (chatList) {
            fmt.dateFormat = @"yyyy/MM/dd";
            //return [fmt stringFromDate:self];
            NSString *dateString = [fmt stringFromDate:self];
            NSString *year = [dateString substringToIndex:4];
            NSString *month = [dateString substringWithRange:NSMakeRange(5,2)];
            NSString *day = [dateString substringWithRange:NSMakeRange(8,2)];
            if([[month substringToIndex:1] isEqualToString:@"0"]){
                month = [month substringFromIndex:1];
            }
            if([[day substringToIndex:1] isEqualToString:@"0"]){
                day = [day substringFromIndex:1];
            }
            return [NSString stringWithFormat:@"%@/%@/%@",year,month,day];
        }
        fmt.dateFormat = @"yyyy年MM月dd日";
        NSString *dateString = [fmt stringFromDate:self];
        NSString *year = [dateString substringToIndex:4];
        NSString *month = [dateString substringWithRange:NSMakeRange(5,2)];
        NSString *day = [dateString substringWithRange:NSMakeRange(8,2)];
        if([[month substringToIndex:1] isEqualToString:@"0"]){
            month = [month substringFromIndex:1];
        }
        if([[day substringToIndex:1] isEqualToString:@"0"]){
            day = [day substringFromIndex:1];
        }
        if (cmps.day >= 1 && cmps.day < 364) {
            return [NSString stringWithFormat:@"%@月%@日 %@",month,day,tempStr];
            
        }else{
            return [NSString stringWithFormat:@"%@年%@月%@日 %@",year,month,day,tempStr];
        }
        return [NSString stringWithFormat:@"%@ %@",dateString, tempStr];
    }
}

//MARK: 比较两个日期
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    
    if (result == NSOrderedDescending) {
        //oneDate在anotherDay之后
        return 1;
    }
    else if (result == NSOrderedAscending){
        //oneDate在anotherDay之前
        return -1;
    }
    //同一天
    return 0;
}

//MARK: 计算toDate和self的时间差距
- (NSDateComponents *)componentsToDate:(NSDate *)toDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:toDate options:0];
}

//MARK: 判断是否是同一天/同一个月/同一年
+ (int)isSameDate:(NSDate *)date1 date2:(NSDate *)date2 {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    
    if (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year])) {
        return 0;
    }
    
    if (([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year])) {
        return 1;
    }
    
    if ([comp1 year] == [comp2 year]) {
        return 2;
    }
    
    return 3;
}
//MARK: 判断系统时间是否是12小时制
+ (BOOL)determineSystemTimeFormat {
    NSString *formatStringForHours = [NSDateFormatter dateFormatFromTemplate:@"j" options:0 locale:[NSLocale currentLocale]];
    
    NSRange containsA = [formatStringForHours rangeOfString:@"a"];
    return containsA.location != NSNotFound;
}



+(NSArray *)getStartTimeAndFinalTime{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[NSDate date];
    double interval = 0;
    NSDate *firstDate = nil;
    NSDate *lastDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:newDate];
    
    if (OK) {
        lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
    }else {
        return @[@"",@""];
    }
    return @[firstDate, lastDate];
}
@end
