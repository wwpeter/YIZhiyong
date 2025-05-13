//
//  BITCommonUnitKeys.h
//  Pods
//
//  Created       on 2019/8/2.
//  Copyright © 2019年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BITLogMacro.h"
#import <BITCategories/BITFDCategories.h>

#pragma 数字常量

//常用字体高度
extern const NSInteger sCommonUnitFontHeight;
//常用粗字体高度
extern const NSInteger sCommonUnitBoldFontHeight;
//常用边距
extern const NSInteger sCommonUnitEdgeDistance;
//蓝牙请求超时时间,单位：毫秒
extern const NSInteger sBluetoothRequestTimeOut;
//通用定时器最大定时间隔,单位：秒
extern const NSInteger sCommonTimerWaitTimeIntervaltMax;

#define MESSAGE_MAX_LEN                       512      //管道消息字符串最大长度
#define CONNECT_MAX_WAIT_TIME                 10       //创建socket连接失败，前三次后的最大等待时间,单位为秒

#pragma 字符串常量
//自定义定时器空闲
extern NSString *const commonTimerIdle;
//自定义定时器小时级定时
extern NSString *const commonTimerHourInterval;
// 自定义定时器Socket心跳间隔定时
//自定义定时器分钟级定时
extern NSString *const commonTimerSocketHeartBeatInterval;
//自定义定时器分钟级定时
extern NSString *const commonTimerMinuteInterval;
//自定义定时器秒级定时
extern NSString *const commonTimerSecondInterval;
//自定义定时器100毫秒定时
extern NSString *const commonTimerScanSecondInterval;
//自定义定时器停止
extern NSString *const commonTimerStop;
//发送消息，秒级定时
extern NSString *const commonTimerSendMessage;
//接收消息，秒级定时
extern NSString *const commonTimerReceiveMessage;
//蓝牙锁连接成功并且可通道可写后，立即发送寻找网络请求，秒级定时
extern NSString *const commonTimerSendFindNetwork;
//收到蓝牙寻找网络请求响应立即发送申请入网请求，秒级定时
extern NSString *const commonTimerSendAppleNetwork;
//读取时间
extern NSString *const commonTimerSendBitLockReadTime;
//读取开门记录，收到蓝牙开门等请求响应立即主动向蓝牙锁发起的读取开门记录，秒级定时
extern NSString *const commonTimerSendBitLockOpenRecordUpload;
extern NSString *const commonTimerSendBitLockDeviceConfiguration;
extern NSString *const commonTimerSendBitLockBackListW;
extern NSString *const commonTimerSendBitLockKeyboardPwdTable;
extern NSString *const commonTimerSendBitLockAuthorizedList;
//定时器定时间隔到通知
extern NSString *const commonTimerIntervalNotification;
/**
 发现网络
 */
extern NSString *const kFindNetwork;

/**
 申请入网
 */
extern NSString *const kAppleNetwork;

//厂商代码
extern NSString *const kBitManufacturerCode;

#pragma 枚举类型
typedef NS_ENUM(short, BITCommonTimerType)
{
    BITCommonTimerTypeIdle = 0,//停止计时，永远阻塞
    BITCommonTimerTypeHour = 1,//每小时计时一次
    BITCommonTimerTypeMinute = 2, //精确到分钟，每10秒钟计时一次
    BITCommonTimerTypeSecond = 3, //每秒钟计时一次
    BITCommonTimerTypeSocketHeartBeat = 4, //每15秒钟计时一次
    BITCommonTimerTypeScanSecond = 5, //每100毫秒计时一次
    BITCommonTimerTypeSendMessage = 6, //发送消息，每1秒计时一次
    BITCommonTimerTypeReceiveMessage = 7 //接收消息，每1秒计时一次
//    BITCommonTimerTypeBlueConnectSuccessMessage = 8 //蓝牙连接成功消息，每1秒计时一次
};

typedef NS_ENUM(NSInteger, BITLoginStatus)
{
    BITLoginStatusLogout = 0,//退出登陆或未登录状态
    BITLoginStatusRegisterAppSuccess = 1,//调用登录接口成功状态，调用registerApp函数成功，但是需要进一步确认是否需要刷脸登录
    BITLoginStatusRegisterAppSuccessLoginOtherDevice = 2, //待刷脸登录状态，注册app成功检测到在其他设备登录，需要刷脸登录
    BITLoginStatusRegisterSuccessNoLockList = 3,//登陆成功无锁列表状态，由于没有获取成功锁列表，不能进行锁相关的操作（带锁mac参数的处理）
    BITLoginStatusLogin = 4,//登录成功，已经获取成功锁列表，可以进行正常操作
    BITLoginStatusLoginOtherDevice = 5 //在其他设备登录状态，在调用登录接口成功状态或登陆成功无锁列表状态或登录成功时，检查到用户在其他设备登录
};


//typedef NS_ENUM(NSInteger,handleType)
//{
//    handleTypeNone=0, //不需要handle
//    handleTypeOne=1,  //一次handle
//    handleTypeTwo=2,   //两次嵌套handle
//};

#pragma 内联函数

//屏幕宽度
static inline CGFloat sCommonUnitFullWidth(void) {
    return [[UIScreen mainScreen] bounds].size.width;
}

//屏幕高度
static inline CGFloat sCommonUnitFullHeight(void) {
    return [[UIScreen mainScreen] bounds].size.height;
}

//判断字符串为空
static inline BOOL isCommonUnitEmptyString(NSString *str) {
    return ([str isKindOfClass:[NSNull class]] || str == nil || ![str isKindOfClass:[NSString class]] || [str length] < 1);
}

//判断数组是否为空
static inline BOOL isCommonUnitEmptyArray(NSArray *array) {
    return (array == nil || [array isKindOfClass:[NSNull class]] || ![array isKindOfClass:[NSArray class]]  || array.count == 0);
}

//判断字典是否为空
static inline BOOL isCommonUnitEmptyDict(NSDictionary *dic) {
    return (dic == nil || [dic isKindOfClass:[NSNull class]] || ![dic isKindOfClass:[NSDictionary class]] || dic.allKeys.count == 0);
}

//判断是否为空
static inline BOOL isCommonUnitEmpty(id thing) {
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) || [([NSString stringWithFormat:@"%@", thing]) isEqualToString:@"<null>"] ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

//字体
static inline UIFont *sCommonUnitFont(CGFloat fontSize) {
    return [UIFont systemFontOfSize:fontSize];
}

//字体
static inline UIFont *sCommonUnitDefaultFont(void) {
    return [UIFont systemFontOfSize:sCommonUnitFontHeight];
}

//粗字体
static inline UIFont *sCommonUnitBoldFont(CGFloat fontSize) {
    return [UIFont boldSystemFontOfSize:fontSize];
}

//背景色颜色
static inline UIColor *sCommonUnitBackgroudColor(void) {
    return [UIColor colorWithHexValue:0xF3F3F3];
}

//线颜色
static inline UIColor *sCommonUnitLineColor(void) {
    return [UIColor colorWithHexValue:0xC7C7C7];
}
//常用字体颜色
static inline UIColor *sCommonUnitFontColor(void) {
    return [UIColor colorWithHexValue:0x0A0A0A];
}
//淡字体颜色
static inline UIColor *sCommonUnitLightFontColor(void) {
    return [UIColor colorWithHexValue:0xB5B5B6];
}

//辅助颜色
static inline UIColor *sCommonUnitAssistColor(void) {
    return [UIColor colorWithHexValue:0x8A9399];
}

//1像素
static inline CGFloat sCommonUnit1PX(void) {
    return (1.0f / [UIScreen mainScreen].scale);
}

//获取文档目录路径
static inline NSString *getPathOfDocument(void) {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

@interface BITCommonUnitKeys : NSObject

@end

