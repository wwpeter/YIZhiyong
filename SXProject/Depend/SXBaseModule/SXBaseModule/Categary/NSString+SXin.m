//
//  NSString+SXin.m
//  SXBaseModule
//
//  Created by 王威 on 2024/1/2.
//

#import "NSString+SXin.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import "Categories.h"
#import "NSString+MD5.h"
#import "NSData+AES.h"

@implementation NSString (SXin)

- (NSString*)sx_T {
    //仿单例, 待翻译的语言文件
    static NSBundle *bundle = nil;
    //默认的翻译语言文件，支持多语言时为英文
    static NSBundle *defaultBundle = nil;
    
    //保证只执行一次
    if(bundle == nil) {
        //支持当前语言
        if ([self isSupportCurrentLanguage] == false) {
            //设置默认语言为英语
            bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]];
        }
        
        if (bundle == nil) {
            // 避免小语种，在部分系统无法生成en.lproj
            bundle = NSBundle.mainBundle;
        }
    }

    NSString *result = [bundle localizedStringForKey:self value:@"" table:nil];
    
    if ([result isEqualToString:self]) {
        
        if (defaultBundle == nil) {
            // 如果当前语言没有key,就取英文的key
            defaultBundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"]];
        }
        
        result = [defaultBundle localizedStringForKey:self value:@"" table:nil];
    }
    
    return result == nil ? self : result;
}

- (BOOL)isSupportCurrentLanguage {
    NSString *currentLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSArray *supportLanguages = @[@"en", @"zh-Hans", @"zh-Hant", @"ko", @"es", @"vi", @"pt", @"nl", @"cs", @"bg", @"de", @"ru", @"it", @"sr", @"da", @"nb", @"sv", @"fi", @"tr", @"pl", @"hu", @"fr", @"no", @"ja", @"tw", @"sk", @"th", @"ro", @"ar", @"uk", @"he", @"id",@"id-ID"];
    
    for (NSString *supportLanguage in supportLanguages) {
        if ([currentLanguage hasPrefix:supportLanguage]) {
            return true;
        }
    }
    return false;

}

+ (NSString *)isoLocalizeLanguageString {
    NSLocale *local = [NSLocale autoupdatingCurrentLocale];
    NSString *area = [local objectForKey:NSLocaleCountryCode];
    NSString *language = [NSLocale preferredLanguages].firstObject;
    NSString *currentLanguage = @"";
    //【*】这里有个问题，当APP新增语言时，旧版本不支持该语言，这个时候获取到的本地语言是语言列表中所APP支持的第一个语言。故这里需要保证获取到的语言是列表中的第一个语言。同时拼接地区。
    if ([language containsString:@"zh-Hant"]) {
        currentLanguage = @"zh_TW";
    } else if(area != nil) {
        currentLanguage = [language componentsSeparatedByString:@"-"].firstObject;
        currentLanguage = [currentLanguage stringByAppendingFormat:@"_%@",area];
    } else {
        currentLanguage = language;
    }
    
    return currentLanguage;
}

- (NSString *)dh_decryptSK {
    NSString *key = [@"DAHUAKEY" lc_MD5Digest].lowercaseString;
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSData *decData = [data lc_AES256CBCDecryptWithKey:key iv:@"0a52uuEvqlOLc5TO"];
    NSString *result = [[NSString alloc]initWithData:decData encoding:NSUTF8StringEncoding];
    return result;
}

- (NSString *)dh_urlAppendParmDic:(NSDictionary<NSString *,NSString *> *)dic
{

//    NSString *srcUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    __block NSString *srcUrl = self;

    if([srcUrl componentsSeparatedByString:@"?"].count<=1) {
        srcUrl = [srcUrl stringByAppendingString:@"?"];
    }
    else{
        srcUrl = [srcUrl stringByAppendingString:@"&"];
    }
    
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        srcUrl = [srcUrl stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", key, obj]];
    }];
    
    if([dic count] > 0){
        return  [srcUrl substringToIndex:([srcUrl length]-1)];//去掉最后一个字符串如", ."
    }else{
        return srcUrl;
    }
}

+ (BOOL)isEmpty:(NSString *)str{
    if (str == nil || [str isKindOfClass:[NSNull class]] || str.length == 0) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [str stringByTrimmingCharactersInSet:set];

    return trimmedStr.length == 0;
}

- (NSUInteger)charactorNumber
{
//    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    return [self charactorNumberWithEncoding:NSUTF8StringEncoding];
}

- (NSUInteger)charactorNumberWithEncoding:(NSStringEncoding)encoding
{
    NSUInteger strLength = 0;
    char *p = (char *)[self cStringUsingEncoding:encoding];
    
    NSUInteger lengthOfBytes = [self lengthOfBytesUsingEncoding:encoding];
    for (int i = 0; i < lengthOfBytes; i++) {
        if (*p) {
            p++;
            strLength++;
        }
        else {
            p++;
        }
    }
    return strLength;
}

@end
