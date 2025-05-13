//
//  NSString+BitInfo.m
//  ChildishBeautyParent
//
//  Created        on 2017/11/29.
//  Copyright © 2019年 BitInfo. All rights reserved.
//

#import "NSString+BitInfo.h"
#import <sys/xattr.h>
#import <CommonCrypto/CommonDigest.h>
#include <CommonCrypto/CommonHMAC.h>
#include "NSMutableDictionary+BitInfo.h"
#import "NSData+BitInfo.h"

//判断字符串是否为空
#define isNSStringBitInfoEmptyString(str) ([str isKindOfClass:[NSNull class]] || str == nil || ![str isKindOfClass:[NSString class]] || [str length] < 1)
/*
 *  iOS版本
 */
#define IOS_STR_BITINFO_VERSION_LARGE_OR_EQUAL(v)        [[[UIDevice currentDevice] systemVersion] floatValue] >= v ? YES : NO

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

@implementation NSString (BitInfo)

- (NSString *)bitinfo_urldecode
{
    return[self stringByRemovingPercentEncoding];
}

- (NSString *)bitinfo_urlencode
{
    NSString *charactersToEscape = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedUrl;
}

- (NSString *)bitinfo_base64encode
{
    if ([self length] == 0)
        return @"";
    
    const char *source = [self UTF8String];
    long strlength  = strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
    
    NSUInteger length = 0;
    NSUInteger i = 0;
    
    while (i < strlength) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < strlength)
            buffer[bufferLength++] = source[i++];
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

- (NSString *)bitinfo_md5hashString
{
    // Create pointer to the string as UTF8
    const char* ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    // Create 16 byte MD5 hash value, store in buffer
    CC_MD5(ptr, (int)strlen(ptr), md5Buffer);
    
    // Convert MD5 value in the buffer to NSString of hex values
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x",md5Buffer[i]];
    }
    
    return output;
}

+ (NSString *)bitinfo_UUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    CFRelease(uuidObj);
    return uuidString;
}


+ (NSString *)combineURLWithBaseURL:(NSString *)baseURL parameters:(NSDictionary *)parameters
{
    NSMutableString *combinedURL = [[NSMutableString alloc] initWithString:@""];
    if (baseURL) {
        combinedURL = [baseURL mutableCopy];
        
        if (parameters.count > 0) {
            
            NSMutableString *queryString = [[NSMutableString alloc] init];
            
            NSArray *sortedKeys =[parameters.allKeys sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
                return [obj1 compare:obj2];
            }];
            
            
            NSUInteger questionMarkLocation = [combinedURL rangeOfString:@"?"].location;
            if (questionMarkLocation != NSNotFound) {
                [queryString appendString:@"&"];
            }
            else
            {
                [queryString appendString:@"?"];
            }
            
            for (id key in sortedKeys) {
                [queryString appendFormat:@"%@=%@&", [key description], [[parameters[key] description] bitinfo_urlencode]];
            }
            
            if ([queryString hasSuffix:@"&"]) {
                [queryString deleteCharactersInRange:NSMakeRange(queryString.length - 1, 1)];
            }
            
            //处理前端 URL 中的 hash
            NSInteger insertPosition = [combinedURL rangeOfString:@"#"].location;
            if (insertPosition == NSNotFound) {
                insertPosition = combinedURL.length;
            }
            else {
                // 存在问号，并且问号在 hash 之后时，直接把 URL 拼到最后
                if (questionMarkLocation != NSNotFound && questionMarkLocation > insertPosition) {
                    insertPosition = combinedURL.length;
                }
            }
            
            [combinedURL insertString:queryString atIndex:insertPosition];
        }
    }
    return combinedURL;
    
}



- (id)jsonObject
{
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                                options:NSJSONReadingMutableContainers
                                                  error:&error];
    
    return object;
}

- (id)jsonFragment
{
    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:[self dataUsingEncoding:NSUTF8StringEncoding]
                                                options:NSJSONReadingAllowFragments
                                                  error:&error];
    return object;
}


#pragma mark - 字符串需要重新计算的字符串尺寸比例,由于计算字符串比例时把一个非汉字按照半个汉字就算，但是显示时却按一个汉字尺寸占位，需要补偿这个比例,IOS10一个汉字比原来多0.35个像素的尺寸
- (CGFloat)rateAdjustmentContent{
    if(self.length == 0)
    {
        return 1;
    }
    float  character1 = 0, character2 = 0, character3 = 0;
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fa5){ //判断是否为中文
            character1 +=1;
        }
        else if( a >= 0x0042 && a <= 0x005A){ //判断是A~Z
            character2 +=1;
        }
        else{
            character3 +=1;
        }
    }
    //ios11计算中文，大写英文的宽度又正常了。iOS计算中文，大写英文的宽度又正常了。
    if (IOS_STR_BITINFO_VERSION_LARGE_OR_EQUAL(11.0))
    {
        return 1;
    }
    else if (IOS_STR_BITINFO_VERSION_LARGE_OR_EQUAL(10.0))
    {
        return (character1*1.35 + character2 * 2 + character3)/(character1 + character2+character3);
    }
    else
    {
        return (character1 + character2 * 2 + character3)/(character1 + character2+character3);
    }
}

#pragma mark - 字符串需要重新计算的字符串尺寸比例,由于计算字符串比例时把一个非汉字按照半个汉字就算，但是显示时却按一个汉字尺寸占位，需要补偿这个比例,在汉字小字体时，IOS10可以忽略进一步补偿
- (CGFloat)rateAdjustmentNoVersionContent
{
    if(self.length == 0)
    {
        return 1;
    }
    float  character1 = 0, character2 = 0, character3 = 0;
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fa5){ //判断是否为中文
            character1 +=1;
        }
        else if( a >= 0x0042 && a <= 0x005A){ //判断是A~Z
            character2 +=1;
        }
        else{
            character3 +=1;
        }
    }
    return (character1 + character2 * 2 + character3)/(character1 + character2 + character3);
}


#pragma mark - 屏蔽emoji表情
- (NSString *)noEmoji
{
    if(self.length == 0)
    {
        return nil;
    }
    //屏蔽emoji表情
    NSRegularExpression *regularExpression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:0 error:nil];
    
    return [regularExpression stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:@""];
    
}

#pragma mark - 把时间戳格式化为 MM月dd日的格式
- (NSString *)dateFomatterStringWithMD {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    return [formatter stringFromDate:confromTimesp];
}

#pragma mark - 把时间戳格式化为 HH:mm 的格式
- (NSString *)dateFomatterStringWithHM {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    return [formatter stringFromDate:confromTimesp];
}

#pragma mark - 把时间戳格式化为 HH:mm 的格式
- (NSString *)dateFomatterStringWithHMS {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm:ss"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    return [formatter stringFromDate:confromTimesp];
}

#pragma mark - 把时间戳格式化为 yyyy年MM月dd日
- (NSString *)dateFomatterStringWithYMD;
{
    NSLog(@"函数");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy年MM月dd日"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    return [formatter stringFromDate:confromTimesp];
}

#pragma mark - 把时间戳格式化为 yyyy-MM-dd
- (NSString *)dateFomatterStringWithYYMMDD
{
    NSLog(@"函数");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    return [formatter stringFromDate:confromTimesp];
}

#pragma mark - 把时间戳格式化为 MM月dd日 HH:mm格式
- (NSString *)dateFomatterStringWithMDHM;
{
    NSLog(@"函数");
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"MM月dd日 HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[self longLongValue]/1000];
    return [formatter stringFromDate:confromTimesp];
}

#pragma mark - 把YY.MM.dd HH:mm格式的日期转化为时间戳
- (long long)timeYMDHMFomatterString
{
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy.MM.dd HH:mm"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate *date =[dateFormat dateFromString:self];
    NSLog(@"%@,date:%@,time:%lld",self,date, (long long)([date timeIntervalSince1970]*1000));
    return (long long)([date timeIntervalSince1970]*1000);
}

#pragma mark - 把时间戳格式化为 天，时，分字典
- (NSMutableDictionary *)dateFomatterStringYMDHMDic
{
    NSLog(@"函数");
    long long intervalSecondTime = [self longLongValue]/1000;
    long long intervalTime = [self longLongValue]/60000;
    NSInteger day = intervalTime/1440;
    NSInteger minute = intervalTime%60;
    NSInteger modifyMinute = minute;
    NSInteger hour = (intervalTime - day*1440 - minute)/60;
    NSInteger second = intervalSecondTime%60;
    if(intervalTime*60 != intervalSecondTime)
    {
        modifyMinute = modifyMinute + 1;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSString *dayStr = [NSString stringWithFormat:@"%ld", day];
    if(dayStr.length <= 1)
    {
        dayStr = [NSString stringWithFormat:@"0%@", dayStr];
    }
    [dic setSafeObject:dayStr forKey:@"day"];
    NSString *hourStr = [NSString stringWithFormat:@"%ld", hour];
    if(hourStr.length <= 1)
    {
        hourStr = [NSString stringWithFormat:@"0%@", hourStr];
    }
    [dic setSafeObject:hourStr forKey:@"hour"];
    NSString *modifyMinuteStr = [NSString stringWithFormat:@"%ld", modifyMinute];
    if(modifyMinuteStr.length <= 1)
    {
        modifyMinuteStr = [NSString stringWithFormat:@"0%@", modifyMinuteStr];
    }
    [dic setSafeObject:modifyMinuteStr forKey:@"modifyMinute"];
    
    NSString *minuteStr = [NSString stringWithFormat:@"%ld", minute];
    if(minuteStr.length <= 1)
    {
        minuteStr = [NSString stringWithFormat:@"0%@", minuteStr];
    }
    [dic setSafeObject:minuteStr forKey:@"minute"];
    
    NSString *secondStr = [NSString stringWithFormat:@"%ld", second];
    if(secondStr.length <= 1)
    {
        secondStr = [NSString stringWithFormat:@"0%@", secondStr];
    }
    [dic setSafeObject:secondStr forKey:@"second"];
    return dic;
}

//判断是否为整形：

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形：

- (BOOL)isPureFloat:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

-(BOOL)checkNumber
{
    if( ![self isPureInt:self] || ![self isPureFloat:self])
    {
        return NO;
    }
    return YES;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

////HmacSHA1加密；
//-(NSString *)HmacSha1
//{
//    NSString *key = @"nsjbVT2u7y9rSqMt7iIF";
//    NSString *data = (NSString *)(self);
//    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
//    const char *cData = [data cStringUsingEncoding:NSASCIIStringEncoding];
//
//    //Sha256:
//    // unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
//    //CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
//
//    //sha1
//    unsigned char cHMAC[CC_SHA1_DIGEST_LENGTH];
//    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
//
//    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
//                                          length:sizeof(cHMAC)];
//
//    NSString *hash = [HMAC base64EncodedStringWithOptions:0];//将加密结果进行一次BASE64编码。
//    NSLog(@"key:%@  ,  data:%@ , hash :%@",key, data, hash);
//    return hash;
//}

//HmacSHA1加密；
-(NSString *)HmacSha1
{
    NSString *key = @"nsjbVT2u7y9rSqMt7iIF";
    NSString *text = (NSString *)(self);
    const char *cKey  = [key cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [text cStringUsingEncoding:NSASCIIStringEncoding];
    
    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
    
    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSString *hash;
    
    NSMutableString * output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", cHMAC[i]];
    
    hash = output;
    hash = [output uppercaseString];
    NSLog(@"key:%@  ,  text:%@ , hash :%@",key, text, hash);
    
    return hash;
}

////密码加密方式：SHA1
//-(NSString *)EncriptPassword_SHA1:(NSString *)password{
//    const char *cstr = [password cStringUsingEncoding:NSUTF8StringEncoding];
//    NSData *data = [NSData dataWithBytes:cstr length:password.length];
//    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
//    CC_SHA1(data.bytes, data.length, digest);
//
//    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH *2];
//
//    for(int i =0; i < CC_SHA1_DIGEST_LENGTH; i++) {
//        [result appendFormat:@"%02x", digest[i]];
//    }
//
//    return [result uppercaseString];
//}

//检查图片的后缀是否是支持图片格式
-(BOOL)checkImageFileExtend
{
    if(isNSStringBitInfoEmptyString(self))
    {
        return YES;
    }
    NSString *fileExtend = [self uppercaseString];
    //https://image.oss.m.1-joy.com/2018-09-19/6578b5b7ae171f0d8dcbd628e1bfc6fb.HEIC?x-oss-process=style/wxlookup
    NSArray* fileExtendArr = [fileExtend componentsSeparatedByString:@"?"];
    if(fileExtendArr.count > 1)
    {
        fileExtend = fileExtendArr[0];
    }
    if([fileExtend isEqualToString:@"PNG"] || [fileExtend isEqualToString:@"BMP"] || [fileExtend isEqualToString:@"GIF"] || [fileExtend isEqualToString:@"JPG"] || [fileExtend isEqualToString:@"JPEG"])
    {
        return YES;
    }
    return NO;
}

//检查图片图片地址的后缀是否是支持图片格式
- (BOOL)checkImageFileExtendWithUrlString
{
    if(isNSStringBitInfoEmptyString(self))
    {
        return YES;
    }
    
    if (![self isKindOfClass:[NSString class]]) {
        return YES;
    }
    NSArray* jpgArr = [self componentsSeparatedByString:@"."];
    if(jpgArr.count <= 1)
    {
        return YES;
    }
    else
    {
        NSString *fileExtend = jpgArr[jpgArr.count-1];
        return [fileExtend checkImageFileExtend];
    }
}

//yyyy-MM-dd HH:mm
-(BOOL)checkYMDHMFomatterString
{
    if(isNSStringBitInfoEmptyString(self))
    {
        return NO;
    }
    
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];//设定时间格式,这里可以设置成自己需要的格式
    
    NSDate *date =[dateFormat dateFromString:self];
    NSLog(@"%@,date:%@,time:%lld",self,date, (long long)([date timeIntervalSince1970]*1000));
    long long timeValue = ([date timeIntervalSince1970]*1000);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeValue/1000];
    NSString *time2 = [formatter stringFromDate:confromTimesp];
    NSLog(@"time:%@,timeValue:%lld,time2:%@", self,timeValue,time2);
    if(isNSStringBitInfoEmptyString(time2))
    {
        return NO;
    }
    return [self isEqualToString:time2];
}

- (NSString *)bitmd5String {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] bitmd5String];
}
@end
