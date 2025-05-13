//
//  Date+ZL.swift
//  Sleep
//
//  Created by 王威 on 2023/2/15.
//

import UIKit

extension Date {
    // 转成当前时区的日期
    static func dateFromGMT(_ date: Date) -> Date {
        let secondFromGMT: TimeInterval = TimeInterval(TimeZone.current.secondsFromGMT(for: date))
        return date.addingTimeInterval(secondFromGMT)
    }
    // MARK: - 时间格式转换为Date类型 (传入的字符串要与下方的格式一致！！！)
    static func getDateFromTime(time: String) -> Date {
        if time.isEmpty {
            return Date()
        }
        let dateformatter = DateFormatter()
        
        //自定义日期格式
        dateformatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateformatter.date(from: time) ?? Date()
    }
    // 转换成时间
    static func getDateFromTime(time: String, formatter: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        if time.isEmpty {
            return Date()
        }
        let dateformatter = DateFormatter()
        
        //自定义日期格式
        dateformatter.dateFormat = formatter
        
        return dateformatter.date(from: time) ?? Date()
    }
    
    // MARK: - 时间戳转成字符串
    static func timeIntervalChangeToTimeStr(timeInterval: Double, _ dateFormat:String? = "HH:mm") -> String {
        let date: Date = Date.init(timeIntervalSince1970: timeInterval)
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        } else {
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: date as Date)
    }
    // MARK: - 时间戳转换为Date类型
    static func getDateFromTimeStamp(timeStamp:String) -> Date {

        if timeStamp.isEmpty {
            return Date()
        }
        let interval:TimeInterval = TimeInterval.init(timeStamp)!

        return Date(timeIntervalSince1970: interval)
    }
    // MARK: - 将Date 格式化输出
    static func getTheTimeOfYMD(date: Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let dateStr = dateFormatter.string(from: date)
        
        return dateStr
    }
    
    // MARK: - 获取 UTC 上的时间，转换为本地时间
    func getLocalDate(from UTCDate: String) -> String {
            
        let dateFormatter = DateFormatter.init()

        // UTC 时间格式
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let utcTimeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.timeZone = utcTimeZone

        guard let dateFormatted = dateFormatter.date(from: UTCDate) else {
            return ""
        }

        // 输出格式
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy:MM:dd HH:mm:ss"
        let dateString = dateFormatter.string(from: dateFormatted)

        return dateString
    }
    
    // MARK: - 周几判断 取决于周几是 第一天
    static func getweekDayWithDate(_ date: Date) -> String {
            let calensar : Calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
            let comps = (calensar as NSCalendar).component(NSCalendar.Unit.weekday, from: date)
            print("comps :\(comps)")
            var dateStr : String = String()
            if comps == 2 {
                dateStr = "星期一"
            } else if comps == 3 {
                dateStr = "星期二"
            } else if comps == 4 {
                dateStr = "星期三"
            } else if comps == 5 {
                dateStr = "星期四"
            } else if comps == 6 {
                dateStr = "星期五"
            } else if comps == 7 {
                dateStr = "星期六"
            } else if comps == 1 {
                dateStr = "星期日"
            }
            return dateStr
        }
    // MARK: - 周几判断 取决于周几是 第一天
    static func getweekDayWithDateChina(_ date: Date) -> String {
            let calensar : Calendar = Calendar.init(identifier: Calendar.Identifier.gregorian)
            let comps = (calensar as NSCalendar).component(NSCalendar.Unit.weekday, from: date)
            print("comps :\(comps)")
            var dateStr : String = String()
            if comps == 1 {
                dateStr = "星期一"
            } else if comps == 2 {
                dateStr = "星期二"
            } else if comps == 3 {
                dateStr = "星期三"
            } else if comps == 4 {
                dateStr = "星期四"
            } else if comps == 5 {
                dateStr = "星期五"
            } else if comps == 6 {
                dateStr = "星期六"
            } else if comps == 7 {
                dateStr = "星期日"
            }
            return dateStr
        }
}
