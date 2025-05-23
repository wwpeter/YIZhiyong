//
//  SXDateFormatter.h
//  SXBaseModule
//
//  Created by 王威 on 2024/1/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SXDateFormatter : NSDateFormatter

// 初始化时，指定使用公历进行时间转换
- (nullable instancetype)initWithGregorianCalendar;

//使用日历类型进行初始化
- (nullable instancetype)initWithCalendarIdentifier:(NSCalendarIdentifier)ident;

@end

NS_ASSUME_NONNULL_END
