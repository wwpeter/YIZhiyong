//
//  BITMacro.h
//  YXB
//
//  Created by huihui on 2022/3/31.
//

#ifndef BITMacro_h
#define BITMacro_h
//#import "AWJsWebEntity.h"
//hht
#define APPName   @"好汇推"
#define ChannelID   @"ios"//渠道号
#define AppCode     @"HHT"// HHT：好汇 YXB：优享 KC:快充
#define  PUSHKEY   @"6c2d131b10e3f36277a8437b"
//yxb
//#define  PUSHKEY   @"c973ec0e22f09d69be40eb59"
//#define APPName    @"优享呗"
//#define ChannelID   @"iosu"//渠道号
//#define AppCode     @"YXB"// HHT：好汇 YXB：优享 KC:快充

//#define AppCompany  ([AppCode isEqualToString:@"YXB"])?@"杭州紫荆花互动广告有限公司":@"杭州紫荆花互动广告有限公司"

//高德地图
#define kGuidiKey @"5dfc28b1c6e9280f892deda199e9107a"

#define PHONE_LENGHT  11
#define MD5_KEY   @"a8D0c92a6c81aA13"

#define PHONE_Num  @"0571-22930077"

//RSA 秘钥
#define PrivateKey @"MIIBOgIBAAJBAMfnMMXYp6EGUF2TiWMGvSC4f6hYt0NC+2GQaxeXOjv+y7MH4DFKwKv6v+pd6kQGDII6rsr5Xnr2a4jGYvV99I0CAwEAAQJBAMe8PkVQpp0DvATjx2BEeXBaKGNC0UnJgXcIX5igp7UMqtWhJWHUv/gtmd6aLVUJ+RNThUszkJyFOkpQ6/asjYECIQDjHO9TvFe2C9v1zLhfwct6T+LyrAs0AvOyrIs42SmXEQIhAOFURK7BNP68rz6KAFm6uS7KEyUIVoqsN+VEDdpF5J29AiBYAfpsBGwoy2etVGuOD9b9yr8zMqAUw6AT+PDqUpzfQQIgS5FyU1VSi5gGAahQg8c+cbWtg/7u3yTwvf/70VcdW9UCIG+4wWFD/mAJU1boQIBrDJROzz23QzhyOEEZZ04OLokt"

#define YXBURL(url)[NSString stringWithFormat:@"%@%@",kBaseURL,url]
#define testToken @"39799299A04D9D67E1A3EEB8903A3B92"
//com.sx.haohuitui
#define LICENCE2 @"fm1RqLjVEBNswBYXAB2OXFxaZhPnzn3l11MKJRH+mQN0X+cnDcvpuRCEykhPseq0XJJcW7CDXBsMC+5ku5pXEEYKVtFXmZxMKpL66zWpvjUeFnHzDzKn202aQzTYK87viWRGYoC2X1oqx70gyNqlZ3Pkx/mwhq5mAaOMfLcaWt+bXe+H6Ehn4FuHSMa3V0RnK7Y6/DGm5dI3JPiLQEN/MiVEtkWk3itSAsywwEOLYT7LH9HRybUMglRE1uaYUHcJ7Kq1AIh3XZBfaoynnAW3b4qeGVvFCZJuVM6k3pBPuxfCFKGLPmKJ2aDfQ5JILsi7sOuZ+bPU9SoW24wdUwKJNA=="
//com.zm.jiuchun
#define LICENCE @"soBmiRM2YdV/lJGEEcnopRgaty4fiQc9EsD4XKGsdnq82olaEqHgaiHSRko6MDLJxYCFiotZHtWrm9VnZSbzyFXSj3bLe1urk6K6uhuyp/rzl/rHceLEX72VSo6Kfzu/H9vM0esrt4bgDWERWmaDNzSRYjVKth9iiniXWQbcH1xXeFYzb0IyBBrApW99yZKmhXzterwhcajUk+dw4GVZ556GdkNVWVOnUlURqg5+kX2KldUoI3TtJbYGA0GLele/hlGGLIqKCnMDn9PCsp2R4W0sVComCKwQ04JduHhkFTO/qkeG+GQu4Q8iHRC1s5RaMjMCMJqw5KXXKBpC3/q2oQ=="
//com.sx.zuwuzu
#define LICENCE3 @"Htuepku7O2uJwyahijoZJrJArKvSokapw+BNQDWc7jxSChK0QCgCiBL/0xJPHursgTBh2LZpVdUEs+2XNh+MP7vGajrkx8MWPG5vP66aHbfGaxABc7C1ZHQkHE+2xzhEwdbDvVDRiaWFsno8CoGYTdeyYB6c/nwJNkmr/9l4H8QWIgsM8JzC4A67VkxegfILITh9QPg0F+DNXxyhjBU+5V5OazSN2GyQ4ahFbhMS0mKUzU3vcW/ShmG6JG+OdEWugiHzyr66DBEyzYZPealxCfh2Mf75FUqcT+wSGmHno8dnJ9gdM7WnPn+rS2HkAQXYXJMrXEl/oEVGR+XIhqjq+Q=="

#define isEmptyString(str) ([str isKindOfClass:[NSNull class]] || str == nil || ![str isKindOfClass:[NSString class]] || [str length] < 1)

//判断数组是否为空
#define isEmptyArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//判断字典是否为空
//#define isEmptyDict(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys.count == 0)
#define isEmptyDict(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || !dic.count)

#ifndef UIColorHex
#define UIColorHex(_hex_)   [UIColor colorWithHexString:((__bridge NSString *)CFSTR(#_hex_))]
#endif
#define COLOR_WITH_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16)) / 255.0 green:((float)((hexValue & 0xFF00) >> 8)) / 255.0 blue:((float)(hexValue & 0xFF)) / 255.0 alpha:1.0f]

#define isLogin    [[NSUserDefaults standardUserDefaults] boolForKey:@"isLogin"]
#define Token      [[NSUserDefaults standardUserDefaults] valueForKey:@"token"]
#define PhoneNum   [[NSUserDefaults standardUserDefaults] valueForKey:@"phone"]
#define isSuperVipFlag   [[NSUserDefaults standardUserDefaults] valueForKey:@"superVipFlag"]
#define UNId      [[NSUserDefaults standardUserDefaults] valueForKey:@"unId"]
#define AppChannel      [[NSUserDefaults standardUserDefaults] valueForKey:@"appChannel"]
#define FundLimitSwitch  [[NSUserDefaults standardUserDefaults] valueForKey:@"fundLimitSwitch"]


#define isNoNet   ([BITSingleObject sharedInstance].networkStatus == 0)

#define UrlToken(URL)  [NSString stringWithFormat:@"%@/%@",URL,Token]

#define LCNotificationCenterRefresh                        @"RefreshYXBRepayChildVC"//确认还款返回刷新还款页面
#define LCNotificationCenterShowHHTPrivacyHubView          @"ShowHHTPrivacyHubView "//显示隐私协议弹框

#define LCNotificationCenterRefreshMember                        @"RefreshYXBMemberVC"//刷新会员页面
#define LCNotificationCenterRefreshRepayVC                  @"RefreshYXBRepayVC"//tab刷新还款页面

#define APPLYBTNGIF                  @"APPLYBTNGIF"//applybtngif

#define RELOAdPHSH @"ReLoadPush"

#define wts_IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]) || ([(_ref) isEqual:@"<null>"])|| ([(_ref) isEqual:@"(null)"]))

//注意服务器返回数字类型的key-value的value值，若当字符串判断，结果为非字符串
static inline NSString *getNotNilString(id thing) {
    
    if(thing == nil || [thing isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    NSString *str = [NSString stringWithFormat:@"%@", thing];
    return [NSString stringWithFormat:@"%@",str];
}
//金额
static inline NSString *getNotNilMoneyString(id thing) {
    if(thing == nil)
    {
        return @"0";
    }
    NSString *str = [NSString stringWithFormat:@"%@", thing];
    return [NSString stringWithFormat:@"%@",str];
}
//轮播顺序
static inline NSString *getNotNilIndexString(id thing) {
    if(thing == nil)
    {
        return @"0";
    }
    NSString *str = [NSString stringWithFormat:@"%@", thing];
    return [NSString stringWithFormat:@"%@",str];
}
//金额0.00
static inline NSString *getNotNilMoney2String(id thing) {
    if(thing == nil)
    {
        return @"0";
    }
    NSString *str = [NSString stringWithFormat:@"%@", thing];
    return [NSString stringWithFormat:@"%@",str];
}

/**
 过滤器/ 将.2f格式化的字符串，去除末尾0
 @param numberStr .2f格式化后的字符串
 @return 去除末尾0之后的
 */
static inline NSString *getRemoveSuffixMoneyNumberStr(NSString *numberStr){
    if (numberStr.length > 1) {
        
        if ([numberStr componentsSeparatedByString:@"."].count == 2) {
            NSString *last = [numberStr componentsSeparatedByString:@"."].lastObject;
            if ([last isEqualToString:@"00"]) {
                numberStr = [numberStr substringToIndex:numberStr.length - (last.length + 1)];
                return numberStr;
            }else{
                if ([[last substringFromIndex:last.length -1] isEqualToString:@"0"]) {
                    numberStr = [numberStr substringToIndex:numberStr.length - 1];
                    return numberStr;
                }
            }
        }
        return numberStr;
    }else{
        return nil;
    }
}


#define IsEmptyString(str)      (!str || [str isEqual:[NSNull null]] || [str isEqualToString : @""])

#define bg_dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

//************************** 公共block定义 **************************//

typedef void(^VoidBlock)(void);
typedef void(^StringBlock)(NSString *string);
typedef void(^IntergerBlock)(NSInteger integer);
typedef void(^BoolBlock)(BOOL booL);
typedef void(^ArrayBlock)(NSArray *array);
typedef void(^DictionaryBlock)(NSDictionary *params);
typedef void(^ImageBlock)(UIImage *image);

typedef void(^ObjectBlock)(id object);
typedef void(^ObjectAndObjectBlock)(id object,id object2);




#endif /* BITMacro_h */
