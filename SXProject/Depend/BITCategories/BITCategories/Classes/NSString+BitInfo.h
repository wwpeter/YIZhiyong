//
//  NSString+BitInfo.h
//  ChildishBeautyParent
//
//  Created        on 2017/11/29.
//  Copyright © 2019年 BitInfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//#import "BITNSObject.h"

@interface NSString (BitInfo)

- (NSString *)bitinfo_md5hashString;

- (NSString *)bitinfo_base64encode;

- (NSString *)bitinfo_urlencode;

- (NSString *)bitinfo_urldecode;

+ (NSString *)bitinfo_UUID;

+ (NSString *)combineURLWithBaseURL:(NSString *)baseURL parameters:(NSDictionary *)parameters;

- (id)jsonObject;

- (id)jsonFragment;

/**
 *  字符串需要重新计算的字符串尺寸比例,由于计算字符串比例时把一个非汉字按照半个汉字就算，但是显示时却按一个汉字尺寸占位，需要补偿这个比例
 */
- (CGFloat)rateAdjustmentContent;
/**
 *  屏蔽emoji表情
 */
- (NSString *)noEmoji;
/**
 *  字符串需要重新计算的字符串尺寸比例,由于计算字符串比例时把一个非汉字按照半个汉字就算，但是显示时却按一个汉字尺寸占位，需要补偿这个比例,在汉字小字体时，IOS10可以忽略进一步补偿
 */
- (CGFloat)rateAdjustmentNoVersionContent;

/**
 *  把时间戳格式化为 MM月dd日格式
 */
- (NSString *)dateFomatterStringWithMD;
/**
 *  把时间戳格式化为 HH:mm 的格式
 */
- (NSString *)dateFomatterStringWithHM;
/**
 *  把时间戳格式化为 HH:mm 的格式
 */
- (NSString *)dateFomatterStringWithHMS;
/**
 *  把时间戳格式化为 yyyy年MM月dd日的格式
 */
- (NSString *)dateFomatterStringWithYMD;
/**
 *  把时间戳格式化为 yyyy-MM-dd的格式
 */
- (NSString *)dateFomatterStringWithYYMMDD;
/**
 *  把时间戳格式化为 MM月dd日 HH:mm格式
 */
- (NSString *)dateFomatterStringWithMDHM;

/**
 *  把YY.MM.dd HH:mm格式的日期转化为时间戳
 */
- (long long)timeYMDHMFomatterString;

/**
 *  把时间戳格式化为 天，时，分字典
 */
- (NSMutableDictionary *)dateFomatterStringYMDHMDic;
/**
 *  检验是否为纯数组
 */
-(BOOL)checkNumber;

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

//HmacSHA1加密；
-(NSString *)HmacSha1;

//检查图片的后缀是否是支持图片格式
-(BOOL)checkImageFileExtend;
//检查图片图片地址的后缀是否是支持图片格式
- (BOOL)checkImageFileExtendWithUrlString;
//yyyy-MM-dd HH:mm
-(BOOL)checkYMDHMFomatterString;
/**
 Returns a lowercase NSString for md5 hash.
 */
- (nullable NSString *)bitmd5String;
@end
