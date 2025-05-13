//
//  BITSingleObject.m
//  Pods
//
//  Created by huihui on 2017/8/2.
//  Copyright © 2017年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import "BITLogMacro.h"
#import "BITSingleObject.h"
#import <CommonCrypto/CommonDigest.h>
#import "BGUICKeyChainStore.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>  //为判断网络制式的主要文件
#import <CoreTelephony/CTCarrier.h> //添加获取客户端运营商 支持

NSUInteger bitLogLevel = ULONG_MAX;

//判断字符串是否为空
#define isBITSingleObjectEmptyString(str) ([str isKindOfClass:[NSNull class]] || str == nil || ![str isKindOfClass:[NSString class]] || [str length] < 1)

@interface BITSingleObject ()

@end

@implementation BITSingleObject

+(BITSingleObject *) sharedInstance
{
    static BITSingleObject *sharedInstace = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedInstace = [[self alloc] init];
        sharedInstace.localServerDifferenceTimeZone = 8*3600*1000 - [sharedInstace getZoneTimeDifference];
        sharedInstace.messageID = [[NSUserDefaults standardUserDefaults] objectForKey:@"messageID"] == NULL ? 100000000000 : [[[NSUserDefaults standardUserDefaults] objectForKey:@"messageID"] longLongValue];
    });
    
    return sharedInstace;
}

//请注意：该函数只有在显示状态栏的页面才能获取到2G/3G/4G网络
- (BGNetworkReachabilityStatus)getNetWorkStatesWithStatus : (AFNetworkReachabilityStatus)status
{
    if(AFNetworkReachabilityStatusUnknown == status)
    {
        return BGNetworkReachabilityStatusUnknown;
    }
    else if(AFNetworkReachabilityStatusNotReachable == status)
    {
        return BGNetworkReachabilityStatusNotReachable;
    }
    else if(AFNetworkReachabilityStatusReachableViaWiFi == status)
    {
        return BGNetworkReachabilityStatusReachableViaWiFi;
    }else if (@available(iOS 12.1, *))
    {
        return  [self getNetType];
    }
//    if(LL_iPhoneX)
//    {
//        return BGNetworkReachabilityStatusReachableViaWWAN;
//    }
    UIApplication *app = [UIApplication sharedApplication];
//    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    NSArray *children;
    // 不能用 [[self deviceVersion] isEqualToString:@"iPhone X"] 来判断，因为模拟器不会返回 iPhone X
//    NSLog(@"%@   %@", [[app valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"], [[[app valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar.currentData"]);
    if (@available(iOS 13.0, *))
    {
        return BGNetworkReachabilityStatusReachableViaWWAN;
    }
    else
    {
        if ([[app valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
            children = [[[[app valueForKeyPath:@"_statusBar"] valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
        }
        else
        {
            children = [[[app valueForKeyPath:@"_statusBar"] valueForKeyPath:@"foregroundView"] subviews];
            
    //        if ([[app valueForKeyPath:@"_statusBar"] isKindOfClass:NSClassFromString(@"UIStatusBar_Modern")]) {
    //            id curData = [statusBar valueForKeyPath:@"statusBar.currentData"];
    //            BOOL wifiEnable = [[curData valueForKeyPath:@"_wifiEntry.isEnabled"] boolValue];
    //            BOOL cellEnable = [[curData valueForKeyPath:@"_cellularEntry.isEnabled"] boolValue];
    //            // iPhone X上通过StatusBar只能获取到网络是WiFi还是蜂窝网
    //            // 当网络为蜂窝网的时候，无法获取到具体的网络状态
    //            if (wifiEnable) {
    //                states = @"WiFi";
    //            } else if (cellEnable) {
    //                states = @"Cellular";
    //            }

        }
        int netType = 0;
        //获取到网络返回码
        for (id child in children) {
            if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                //获取到状态栏
                netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
                
                switch (netType) {
                    case 0:
                    {
                        NSLog(@"无网络");
                        //无网模式
                        return BGNetworkReachabilityStatusNotReachable;
                    }
                        break;
                    case 1:
                    {
                        NSLog(@"2G");
                        return BGNetworkReachabilityStatusReachableViaWWAN2G;
                    }
                        break;
                    case 2:
                    {
                        NSLog(@"3G");
                        return BGNetworkReachabilityStatusReachableViaWWAN3G;
                    }
                        break;
                    case 3:
                    {
                        NSLog(@"4G");
                        return BGNetworkReachabilityStatusReachableViaWWAN4G;
                    }
                    case 4:
                    {
                        NSLog(@"5G");
                        return BGNetworkReachabilityStatusReachableViaWWAN5G;
                    }
                        break;
                    case 5:
                    {
                        NSLog(@"wifi");
                        return BGNetworkReachabilityStatusReachableViaWWAN5G;
                    }
                        break;
                    default:
                        break;
                }
            }
            //根据状态选择
            return BGNetworkReachabilityStatusReachableViaWWAN;
        }
    }
    return BGNetworkReachabilityStatusReachableViaWWAN;
}

- (BGNetworkReachabilityStatus )getNetType
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *currentStatus = info.currentRadioAccessTechnology;
    BGNetworkReachabilityStatus currentNet = BGNetworkReachabilityStatusReachableViaWWAN5G;
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyGPRS]) {
        currentNet = BGNetworkReachabilityStatusReachableViaWWAN2G;
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyEdge]) {
        currentNet = BGNetworkReachabilityStatusReachableViaWWAN2G;
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyWCDMA]){
        currentNet = BGNetworkReachabilityStatusReachableViaWWAN3G;
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSDPA]){
        currentNet = BGNetworkReachabilityStatusReachableViaWWAN3G;
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSUPA]){
        currentNet = BGNetworkReachabilityStatusReachableViaWWAN3G;
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMA1x]){
        currentNet = BGNetworkReachabilityStatusReachableViaWWAN2G;
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]){
        currentNet = BGNetworkReachabilityStatusReachableViaWWAN3G;
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]){
        currentNet = BGNetworkReachabilityStatusReachableViaWWAN3G;
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]){
        currentNet = BGNetworkReachabilityStatusReachableViaWWAN3G;
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyeHRPD]){
        currentNet = BGNetworkReachabilityStatusReachableViaWWAN3G;
    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyLTE]){
        currentNet = BGNetworkReachabilityStatusReachableViaWWAN4G;
    }else if (@available(iOS 14.0, *)) {
//        if ([currentStatus isEqualToString:CTRadioAccessTechnologyNRNSA]){
//            currentNet = @"5G NSA";
//        }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyNR])
        {
            currentNet = BGNetworkReachabilityStatusReachableViaWWAN5G;
        }
    }
    return currentNet;

}


//- (NSString *)getNetType
//{
//    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//    NSString *currentStatus = info.currentRadioAccessTechnology;
//    NSString *currentNet = @"5G";
//
//    if ([currentStatus isEqualToString:CTRadioAccessTechnologyGPRS]) {
//        currentNet = @"GPRS";
//    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyEdge]) {
//        currentNet = @"2.75G EDGE";
//    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyWCDMA]){
//        currentNet = @"3G";
//    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSDPA]){
//        currentNet = @"3.5G HSDPA";
//    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSUPA]){
//        currentNet = @"3.5G HSUPA";
//    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMA1x]){
//        currentNet = @"2G";
//    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]){
//        currentNet = @"3G";
//    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]){
//        currentNet = @"3G";
//    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]){
//        currentNet = @"3G";
//    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyeHRPD]){
//        currentNet = @"HRPD";
//    }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyLTE]){
//        currentNet = @"4G";
//    }else if (@available(iOS 14.0, *)) {
//        if ([currentStatus isEqualToString:CTRadioAccessTechnologyNRNSA]){
//            currentNet = @"5G NSA";
//        }else if ([currentStatus isEqualToString:CTRadioAccessTechnologyNR]){
//            currentNet = @"5G";
//        }
//    }
//    return currentNet;
//
//}

//密码混淆  rule：[1,16],[3,20,[4,12],[6,20],[11,23],[15,18]
+ (NSString *)passwordGetDecodeConfusionKey : (NSString *)key
{
    //    FLDDLogDebug("key:%@,lenght%d", key, [key length]);
    if((key == nil) || ([key length] != 32))
    {
        return nil;
    }
    char *key_char = (char *)[key UTF8String];
    char c;
    c = key_char[1];
    key_char[1] = key_char[16];
    key_char[16] = c;
    c = key_char[3];
    key_char[3] = key_char[20];
    key_char[20] = c;
    c = key_char[4];
    key_char[4] = key_char[12];
    key_char[12] = c;
    c = key_char[6];
    key_char[6] = key_char[20];
    key_char[20] = c;
    c = key_char[11];
    key_char[11] = key_char[23];
    key_char[23] = c;
    c = key_char[15];
    key_char[15] = key_char[18];
    key_char[18] = c;
    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", key_char]];
    
}

//密码混淆 [0,15],[6,23],[7,14],[9,26],[11,12],[15,18],[25,28]
+ (NSString *)passwordGetEecodeConfusionKey : (NSString *)key
{
    //    FLDDLogDebug("key:%@,lenght%d", key, [key length]);
    if((key == nil) || ([key length] != 32))
    {
        return @"";
    }
    char *key_char = (char *)[key UTF8String];
    char c;
    c = key_char[0];
    key_char[0] = key_char[15];
    key_char[15] = c;
    c = key_char[6];
    key_char[6] = key_char[23];
    key_char[23] = c;
    c = key_char[7];
    key_char[7] = key_char[14];
    key_char[14] = c;
    c = key_char[9];
    key_char[9] = key_char[26];
    key_char[26] = c;
    c = key_char[11];
    key_char[11] = key_char[12];
    key_char[12] = c;
    c = key_char[15];
    key_char[15] = key_char[18];
    key_char[18] = c;
    c = key_char[25];
    key_char[25] = key_char[28];
    key_char[28] = c;
    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", key_char]];
    
}

/*****************************************************************************
 函数:  (NSString *)switchNSStringValueWithKey : (NSString *)key startIndex:(NSUInteger)startIndex endIndex:(NSUInteger)endIndex
 描述:  交换字符串中指定两个以0开始编号的位置的字符
 调用:  无
 被调用: (NSString *)getEncodeConfusionKey : (NSString *)key
 返回值: 成功返回字符串，失败返回nil
 其它: 无
 ******************************************************************************/
+ (NSString *)switchNSStringValueWithKey : (NSString *)key startIndex:(NSUInteger)startIndex endIndex:(NSUInteger)endIndex
{
    if(startIndex > endIndex)
    {
        NSUInteger n = startIndex;
        startIndex = endIndex;
        endIndex = n;
    }
    else if(startIndex == endIndex)
    {
        return key;
    }
    
    if(([key length] < 2) || (endIndex > [key length] - 1))
    {
        return @"";
    }
    
    char c, cc;
    
    NSRange range;
    NSString *first = nil;
    NSString *front = nil;
    NSString *back = nil;
    
    c = [key characterAtIndex:startIndex];
    cc = [key characterAtIndex:endIndex];
    if(startIndex > 0)
    {
        range = NSMakeRange(0, startIndex);
        first = [key substringWithRange:range];
    }
    
    range = NSMakeRange(startIndex + 1, endIndex - 1 - startIndex);
    front = [key substringWithRange:range];
    range = NSMakeRange(endIndex + 1, 32 - 1 - endIndex);
    back = [key substringWithRange:range];
    if(nil != first)
    {
        back = [NSString stringWithFormat:@"%@%c%@%c%@", first, cc, front, c, back];
    }
    else
    {
        back = [NSString stringWithFormat:@"%c%@%c%@", cc, front, c, back];
    }
    
    return back;
}

/*****************************************************************************
 函数:  (NSString *)getEncodeConfusionKey : (NSString *)key
 描述:  对发送key字符串进行混淆加密
 调用:  (NSString *)switchNSStringValue : (NSString *)key : (NSUInteger)startIndex : (NSUInteger)endIndex
 被调用: (NSString *)getEncodeKey : (NSString *)phoneId : (NSString *)cmdCode : (NSString *)visitTime
 返回值: 成功返回字符串，失败返回nil
 其它: 规则 ：[0,15],[3,18],[5,12],[6,30],[11,20],[17,25]
 ******************************************************************************/
+ (NSString *)getEncodeConfusionKey : (NSString *)key
{
    if((key == nil) || ([key length] != 32))
    {
        return nil;
    }
    
    
    //    char *key_char = (char *)[key UTF8String];
    //    char c;
    //    c = key_char[0];
    //    key_char[0] = key_char[15];
    //    key_char[15] = c;
    //    c = key_char[3];
    //    key_char[3] = key_char[18];
    //    key_char[18] = c;
    //    c = key_char[5];
    //    key_char[5] = key_char[12];
    //    key_char[12] = c;
    //    c = key_char[6];
    //    key_char[6] = key_char[30];
    //    key_char[30] = c;
    //    c = key_char[11];
    //    key_char[11] = key_char[20];
    //    key_char[20] = c;
    //    c = key_char[17];
    //    key_char[17] = key_char[25];
    //    key_char[25] = c;
    //    return [NSString stringWithFormat:@"%s", key_char];
    
    NSString *src = key;
    src = [self switchNSStringValueWithKey : src startIndex: 0 endIndex: 15];
    src = [self switchNSStringValueWithKey : src startIndex: 3 endIndex: 18];
    src = [self switchNSStringValueWithKey : src startIndex: 5 endIndex: 12];
    src = [self switchNSStringValueWithKey : src startIndex: 6 endIndex: 30];
    src = [self switchNSStringValueWithKey : src startIndex: 11 endIndex: 20];
    src = [self switchNSStringValueWithKey : src startIndex: 17 endIndex: 25];
    //    FLDDLogVerbose(@"key = %@, src = %@, length = %lu", key, src, (unsigned long)key.length);
    return src;
}

/*****************************************************************************
 函数:      (NSString *)getEncodeKeyWithVisitTime:(NSString *)visitTime
 描述:      产生客户端加密key
 调用:      无
 被调用:
  返回值: 成功返回字符串，失败返回nil
 其它:
 ******************************************************************************/
+ (NSString *)getEncodeKeyWithVisitTime:(NSString *)visitTime
{
    if((nil == [BITSingleObject sharedInstance].token) || ![[BITSingleObject sharedInstance].token isKindOfClass:[NSString class]] || ([[BITSingleObject sharedInstance].token isEqualToString:@""]) || (nil == visitTime) || ![visitTime isKindOfClass:[NSString class]] || ([visitTime isEqualToString:@""]))
    {
        return @"";
    }
    
    NSString *key = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@", g_softkey1, [BITSingleObject sharedInstance].token, visitTime]];
    if((nil == key) || ([key isEqualToString:@""]))
    {
        return @"";
    }
    NSString *softKey = [self md5:key];
    
    return [self getEncodeConfusionKey:softKey];
}
+ (NSString *)getEncodeKeyWithVisitTime:(NSString *)visitTime paramsDic:(NSMutableDictionary *)paramsDic
{
    if(isBITSingleObjectEmptyString([BITSingleObject sharedInstance].token) || isBITSingleObjectEmptyString(visitTime) || (!paramsDic) || ![paramsDic isKindOfClass:[NSDictionary class]])
    {
        return @"";
    }
//    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
//    for(NSUInteger i = 0; i < paramsDic.allKeys.count; i++)
//    {
//        [tempDic setValue:paramsDic.allKeys[i] forKey:paramsDic.allValues[i]];
//    }
//    [paramsDic removeAllObjects];
//    for(NSUInteger i = 0; i < tempDic.allKeys.count; i++)
//    {
//        [paramsDic setValue:tempDic.allKeys[i] forKey:tempDic.allValues[i]];
//    }
//    NSString *sign = @"";
//    for(NSUInteger i = 0; i < paramsDic.allKeys.count; i++)
//    {
//        if(sign.length == 0)
//        {
//            sign = [NSString stringWithFormat:@"%@%@=%@", [BITSingleObject sharedInstance].token, paramsDic.allKeys[i], getisBITSingleObjectNotNilString(paramsDic.allValues[i])];
//        }
//        else
//        {
//            sign = [NSString stringWithFormat:@"%@&%@=%@", sign, paramsDic.allKeys[i], getisBITSingleObjectNotNilString(paramsDic.allValues[i])];
//        }
//    }
    NSString *sign = @"";
    sign = [NSString stringWithFormat:@"%@%@", [BITSingleObject sharedInstance].token,[self stringWithDict:paramsDic]];
    
    
    NSLog(@"token:%@         ;paramsDic:%@         ;sign:%@", [BITSingleObject sharedInstance].token, paramsDic, sign);
    sign = [NSString stringWithFormat:@"%@293ee30f8c3008f8", sign];
    NSLog(@"token:%@         ;paramsDic:%@         ;sign:%@       ; result:%@", [BITSingleObject sharedInstance].token, paramsDic, sign, [self commonMd5:sign]);
    return [self commonMd5:sign];
}

+(NSString*)stringWithDict:(NSDictionary*)dict{
    
    NSArray*keys = [dict allKeys];
    
    NSArray*sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1,id obj2) {
        return[obj1 compare:obj2 options:NSNumericSearch];//正序
    }];
    
    NSString*str =@"";
    
    for(NSString*categoryId in sortedArray) {
        
        id value = [dict objectForKey:categoryId];
        
        if([value isKindOfClass:[NSDictionary class]]) {
            
            value = [self stringWithDict:value];
            
        }
        
        if([str length] !=0) {
            
            str = [str stringByAppendingString:@"&"];
            
        }
        
        str = [str stringByAppendingFormat:@"%@=%@",categoryId,value];
        
    }
    NSLog(@"str:%@",str);
    return str;
}
/*****************************************************************************
 函数:      (NSString *)getDecodeConfusionKey : (NSString *)key
 描述:      产生的服务端key字符串混淆加密算法
 调用:      无
 被调用:    (NSString *)getDecodeKey : (NSString *)phoneId : (NSString *)cmdCode : (NSString *)visitTime
 返回值: 成功返回字符串，失败返回nil
 其它: rule：[5,16],[6,17],[9,19],[13,28],[15,21],[18,29]
 ******************************************************************************/
+ (NSString *)getDecodeConfusionKey : (NSString *)key
{
//    FLDDLogDebug("key:%@,lenght%d", key, [key length]);
    if((key == nil) || ([key length] != 32))
    {
        return @"";
    }
//    char *key_char = (char *)[key UTF8String];
//    char c;
//    c = key_char[5];
//    key_char[5] = key_char[16];
//    key_char[16] = c;
//    c = key_char[6];
//    key_char[6] = key_char[17];
//    key_char[17] = c;
//    c = key_char[9];
//    key_char[9] = key_char[19];
//    key_char[19] = c;
//    c = key_char[13];
//    key_char[13] = key_char[28];
//    key_char[28] = c;
//    c = key_char[15];
//    key_char[15] = key_char[21];
//    key_char[21] = c;
//    c = key_char[18];
//    key_char[18] = key_char[29];
//    key_char[29] = c;
//
//    return [[NSString alloc] initWithString:[NSString stringWithFormat:@"%s", key_char]];
    
    
    NSString *src = key;
    
    src = [self switchNSStringValueWithKey : src startIndex: 5 endIndex: 16];
    src = [self switchNSStringValueWithKey : src startIndex: 6 endIndex: 17];
    src = [self switchNSStringValueWithKey : src startIndex: 9 endIndex: 19];
    src = [self switchNSStringValueWithKey : src startIndex: 13 endIndex: 28];
    src = [self switchNSStringValueWithKey : src startIndex: 15 endIndex: 21];
    src = [self switchNSStringValueWithKey : src startIndex: 18 endIndex: 29];
    //    FLDDLogVerbose(@"key = %@, src = %@, length = %lu", key, src, (unsigned long)key.length);
    return src;
}

/*****************************************************************************
 函数:  (NSString *)getDecodeKeyWithVisitTime:(NSString *)visitTime
 描述:   产生服务器加密key
 调用:   无
 被调用:
 返回值: 成功返回字符串，失败返回nil
 其它:
 ******************************************************************************/
+ (NSString *)getDecodeKeyWithVisitTime:(NSString *)visitTime
{
    if((nil == [BITSingleObject sharedInstance].token) || ![[BITSingleObject sharedInstance].token isKindOfClass:[NSString class]] || ([[BITSingleObject sharedInstance].token isEqualToString:@""]) || (nil == visitTime) || ![visitTime isKindOfClass:[NSString class]] || ([visitTime isEqualToString:@""]))
    {
        return @"";
    }
    
    NSString *key = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@%@%@", g_softkey2, [BITSingleObject sharedInstance].token, visitTime]];
    if((nil == key) || ([key isEqualToString:@""]))
    {
        return @"";
    }
//    FLDDLogDebug("key:%@,lenght%d", key, [key length]);
    NSString *softKey =  [self md5:key];
//    FLDDLogDebug("softKey:%@,lenght:%d", softKey, [softKey length]);
    FLDDLogDebug("softKey:%@", softKey);
    //FLDDLogDebug("key:%@", [self getConfusionKey:softKey]);
    return [self getDecodeConfusionKey:softKey];
}

+ (NSString *)md5:(NSString *)str
{
    
    if((nil == str) || ([str isEqualToString:@""]))
    {
        return nil;
    }
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15]];
}

+ (NSString *)commonMd5:(NSString *)str
{
    
    if((nil == str) || ([str isEqualToString:@""]))
    {
        return nil;
    }
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15]];
}


-(long long)getZoneTimeDifference
{
    NSDate *date = [NSDate date]; // 获得时间对象

    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区

    NSTimeInterval time = [zone secondsFromGMTForDate:date]*1000;// 以秒为单位返回当前时间与系统格林尼治时间的差
    return (long long)time;
}

-(long long)getNowTime
{
    long long nowTime = (long long)([[NSDate date] timeIntervalSince1970]*1000+[self getZoneTimeDifference])+self.localServerDifferenceTime + self.localServerDifferenceTimeZone;
    return nowTime;
}
-(long long)getStandardNowTime
{
    long long nowTime = (long long)([[NSDate date] timeIntervalSince1970]*1000+[self getZoneTimeDifference])+self.localServerDifferenceTime + self.localServerDifferenceTimeZone -8*3600*1000;
    return nowTime;
}

-(NSDate *)getDateNow
{
    NSDate *dateNow = [[NSDate date] dateByAddingTimeInterval:([self getZoneTimeDifference] + self.localServerDifferenceTime + self.localServerDifferenceTimeZone)/1000];// 然后把差的时间加上,就是当前系统准确的时间
    return dateNow;
}

-(NSDate *)getStandardDateNow
{
    NSDate *dateNow = [[NSDate date] dateByAddingTimeInterval:([self getZoneTimeDifference] + self.localServerDifferenceTime + self.localServerDifferenceTimeZone -8*3600*1000)/1000];//0时区的时间
    return dateNow;
}


-(long long)getNowTimeWithLocalServerDifferenceTime:(long long)localServerDifferenceTime
{
    long long nowTime = (long long)([[NSDate date] timeIntervalSince1970]*1000+[self getZoneTimeDifference])+localServerDifferenceTime;
    return nowTime;
}

-(NSDate *)getDateNowWithLocalServerDifferenceTime:(long long)localServerDifferenceTime
{
    NSDate *dateNow = [[NSDate date] dateByAddingTimeInterval:([self getZoneTimeDifference] + localServerDifferenceTime)];// 然后把差的时间加上,就是当前系统准确的时间
    return dateNow;
}

-(NSString*)getBundleIdentifier{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

-(NSString *)getMessageIDSnoWithKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    NSString *service = [self getBundleIdentifier];
    self.messageID = [[self getUICKeyChainStoreDataWithKey:key defaultValue:@"100000000000"] longLongValue];
    if(self.messageID < 100000000000 || self.messageID >= 999999999999)
    {
        self.messageID = 100000000000;
    }
    self.messageID++;
    NSString *str1 = [NSString stringWithFormat:@"%lld", self.messageID];
    [self storeWithKey:key value:str1];
    NSString *str2 = [self get6random];
    NSString *str = [NSString stringWithFormat:@"%@%@", str1, str2];
    return str;
}

-(NSString *)get6random
{
    //获取一个随机数范围在：[100000,999999]，包括100000，包括100000,999999
    long long y =100000 +  (arc4random() % 1000000);
    NSString *randStr = [NSString stringWithFormat:@"%lld", y];
    return randStr;
}


-(void)storeWithKey:(NSString *)key value:(NSString *)value
{
    NSString *service = [self getBundleIdentifier];
    if(isBITSingleObjectEmptyString(service) || isBITSingleObjectEmptyString(key))
    {
        return;
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:(isBITSingleObjectEmptyString(value)? @"" : value) forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    BGUICKeyChainStore *store = [BGUICKeyChainStore keyChainStoreWithService:service];
    [store bgSetString:(isBITSingleObjectEmptyString(value)? @"" : value) forKey:key];
    [store synchronizable];
}

//获取设备唯一标示符
- (NSString *)getUUID
{
    NSString *service = [self getBundleIdentifier];
    if(isBITSingleObjectEmptyString(service))
    {
        return nil;
    }
    
    NSString *deviceUUId = [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"];
//        FLDDLogDebug(@"str = %@",str);
    if (deviceUUId){
        return deviceUUId;
    }
    else
    {
        NSString *deviceUUId = [BGUICKeyChainStore bgStringForKey:@"uuid" service:service];
        
        if (deviceUUId) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:deviceUUId forKey:@"uuid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return deviceUUId;
        }
        else {
            CFUUIDRef puuid = CFUUIDCreate( nil );
            CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
            NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
            CFRelease(puuid);
            CFRelease(uuidString);
            BGUICKeyChainStore *store = [BGUICKeyChainStore keyChainStoreWithService:service];
            NSString *deviceUUID = [BITSingleObject commonMd5:result];

            [store bgSetString:deviceUUID forKey:@"uuid"];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:deviceUUId forKey:@"uuid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            //        [store synchronizable];
            FLDDLogDebug(@"store = %@ str = %@",store,deviceUUId);
            return deviceUUID;

        }
    }
    
    return nil;
}


//获取钥匙串数据
- (NSString *)getUICKeyChainStoreDataWithKey:(NSString *)key defaultValue:(NSString *)defaultValue
{
    NSString *service = [self getBundleIdentifier];
    if(isBITSingleObjectEmptyString(service) || isBITSingleObjectEmptyString(key))
    {
        return nil;
    }
    
    NSString *value = [[NSUserDefaults standardUserDefaults] objectForKey:key];
//        FLDDLogDebug(@"str = %@",str);
    if (!isBITSingleObjectEmptyString(value)){
        return value;
    }
    else
    {
        value = [BGUICKeyChainStore bgStringForKey:key service:service];
        
        if (!isBITSingleObjectEmptyString(value)) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:value forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
            return value;
        }
        else {
            BGUICKeyChainStore *store = [BGUICKeyChainStore keyChainStoreWithService:service];
            NSString *defaultStr = nil;
            if(!isBITSingleObjectEmptyString(defaultValue))
            {
                defaultStr = defaultValue;
            }

            [store bgSetString:defaultValue forKey:key];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:isBITSingleObjectEmptyString(defaultStr)?@"":defaultStr forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [store synchronizable];
//            FLDDLogDebug(@"store = %@ str = %@",store,defaultStr);
            return defaultStr;
        }
    }
    
    return nil;
}
@end
