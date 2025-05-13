// BITSingleObject.h
//  Pods
//
//  Created by huihui on 2017/8/2.
//  Copyright © 2017年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BITLogMacro.h"
#import "AFNetworking.h"
#import "BITNetWorking.h"
//#if MAKE_STATIC_LIBRARY
//#import "BITAFNetworking.h"
//#else
//#import <BITAFNetworking/BITAFNetworking.h>
//#endif

static const NSString *g_softkey1 = @"hjweiusdkjhywngy75ky4fw43as874ht";
static const NSString *g_softkey2 = @"asdf896kjhhrih495sjgcbr75jvks5as";

//注意服务器返回数字类型的key-value的value值，若当字符串判断，结果为非字符串
static inline NSString *getisBITSingleObjectNotNilString(id thing) {
    if(thing == nil)
    {
        return @"";
    }
    NSString *str = [NSString stringWithFormat:@"%@", thing];
    return [NSString stringWithFormat:@"%@",str];
}

//判断字符串是否为空
#define isBITSingleObjectEmptyString(str) ([str isKindOfClass:[NSNull class]] || str == nil || ![str isKindOfClass:[NSString class]] || [str length] < 1)
//判断数组是否为空
#define isBITSingleObjectEmptyArray(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

extern NSUInteger bitLogLevel;

typedef NS_ENUM(NSInteger, BGNetworkReachabilityStatus)
{
    BGNetworkReachabilityStatusUnknown = -1,
    BGNetworkReachabilityStatusNotReachable = 0,
    BGNetworkReachabilityStatusReachableViaWWAN = 1,
    BGNetworkReachabilityStatusReachableViaWiFi = 2,
    BGNetworkReachabilityStatusReachableViaWWAN3G = 3,
    BGNetworkReachabilityStatusReachableViaWWAN4G = 4,
    BGNetworkReachabilityStatusReachableViaWWAN5G = 5,
    BGNetworkReachabilityStatusReachableViaWWAN2G = 6 //  6G目前为猜测结果
};

@interface BITSingleObject : NSObject
@property (nonatomic, copy) void(^crashBlock)(void);
@property (nonatomic,strong) NSString *phoneType;
@property (nonatomic,assign) BGNetworkReachabilityStatus networkStatus;
/**服务器时间**/
@property(nonatomic, assign) long long serverTime;

/**本地时间与服务器的差异，获取到服务器时间的本地时间减去获取到的服务器时间，当为负值或大于300毫秒时，说明本地时间不准确**/
@property(nonatomic, assign) long long localServerDifferenceTime;
@property(nonatomic, assign) long long localServerDifferenceTimeZone;
@property(nonatomic,assign) BOOL isUpateLocalServerDifferenceTime;
@property(nonatomic, assign) long long messageID;

@property (nonatomic, assign) long long versionSnoClearUseInfo;
//token失效，需要跳到登录页面
@property (nonatomic, assign) long long logoutErrorCode;
//需要传递token，但是由于token被清空，导致没有传递token，需要跳到登录页面
@property (nonatomic, assign) long long noTokenErrorCode;
@property (nonatomic,strong) NSString *logoutPageAddress;
@property(nonatomic,assign) BOOL isLoginPage;
@property(nonatomic,assign) BOOL isInRoomPage;

@property(nonatomic,assign) BOOL bPersonalHotspotConnected;
@property(nonatomic,assign) BOOL isInitializeLog;
@property (nonatomic,strong) NSString *token;
@property (nonatomic, copy) NSString *pay_order_id;

@property (nonatomic, assign)  NSInteger businessHeadType;

+ (BITSingleObject *)sharedInstance;

//请注意：该函数只有在显示状态栏的页面才能获取到2G/3G/4G网络
- (BGNetworkReachabilityStatus)getNetWorkStatesWithStatus : (AFNetworkReachabilityStatus)status;

//+ (NSString *)passwordGetDecodeConfusionKey : (NSString *)key;
//+ (NSString *)getEncodeConfusionKey : (NSString *)key;
+ (NSString *)switchNSStringValueWithKey : (NSString *)key startIndex:(NSUInteger)startIndex endIndex:(NSUInteger)endIndex;

+ (NSString *)getDecodeKeyWithVisitTime:(NSString *)visitTime;
+ (NSString *)getEncodeKeyWithVisitTime:(NSString *)visitTime;
+ (NSString *)md5:(NSString *)str;
+ (NSString *)commonMd5:(NSString *)str;

+ (NSString *)getEncodeKeyWithVisitTime:(NSString *)visitTime paramsDic:(NSMutableDictionary *)paramsDic;


-(long long)getZoneTimeDifference;
-(long long)getNowTime;
-(NSDate *)getDateNow;
-(long long)getNowTimeWithLocalServerDifferenceTime:(long long)localServerDifferenceTime;
-(NSDate *)getDateNowWithLocalServerDifferenceTime:(long long)localServerDifferenceTime;
-(NSDate *)getStandardDateNow;
-(long long)getStandardNowTime;

-(NSString *)getMessageIDSnoWithKey:(NSString *)key defaultValue:(NSString *)defaultValue;
-(NSString *)get6random;

//获取设备唯一标示符
- (NSString *)getUUID;
//获取钥匙串数据
- (NSString *)getUICKeyChainStoreDataWithKey:(NSString *)key defaultValue:(NSString *)defaultValue;
-(void)storeWithKey:(NSString *)key value:(NSString *)value;
@end
