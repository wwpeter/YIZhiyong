//
//  BITCommonUnitKeys.m
//  Pods
//
//  Created       on 2019/1/2.
//  Copyright © 2019年 Hangzhou BitInfo Technology Co., Ltd. All rights reserved.
//

#import "BITCommonUnitKeys.h"

#pragma 数字常量

//常用字体高度
const NSInteger sCommonUnitFontHeight = 13;
//常用粗字体高度
const NSInteger sCommonUnitBoldFontHeight = 18;
//常用边距
const NSInteger sCommonUnitEdgeDistance = 15;
//蓝牙请求超时时间,单位：毫秒
const NSInteger sBluetoothRequestTimeOut = 5000;
//通用定时器最大定时间隔,单位：秒
const NSInteger sCommonTimerWaitTimeIntervaltMax = 60;

#pragma 字符串常量
//自定义定时器空闲
NSString *const commonTimerIdle  = @"commonTimerIdleInterval, ";
//自定义定时器小时级定时
NSString *const commonTimerHourInterval = @"commonTimerHourInterval, ";
// 自定义定时器Socket心跳间隔定时
//自定义定时器分钟级定时
NSString *const commonTimerSocketHeartBeatInterval = @"commonTimerSocketHeartBeatInterval, ";
//自定义定时器分钟级定时
NSString *const commonTimerMinuteInterval = @"commonTimerMinuteInterval, ";
//自定义定时器秒级定时
NSString *const commonTimerSecondInterval = @"commonTimerSecondInterval, ";
//自定义定时器100毫秒定时
NSString *const commonTimerScanSecondInterval  = @"commonTimerScanSecondInterval, ";
//自定义定时器停止
NSString *const commonTimerStop  = @"commonTimerStop, ";
//发送消息，秒级定时
NSString *const commonTimerSendMessage = @"commonTimerSendMessage, ";
//接收消息，秒级定时
NSString *const commonTimerReceiveMessage = @"commonTimerReceiveMessage;";
//蓝牙锁连接成功并且可通道可写后，立即发送寻找网络请求，秒级定时
NSString *const commonTimerSendFindNetwork = @"commonTimerSendFindNetwork, ";
//收到蓝牙寻找网络请求响应立即发送申请入网请求，秒级定时
NSString *const commonTimerSendAppleNetwork = @"commonTimerSendAppleNetwork, ";
//读取时间
NSString *const commonTimerSendBitLockReadTime = @"commonTimerSendBitLockReadTime, ";
//读取开门记录，收到蓝牙开门等请求响应立即主动向蓝牙锁发起的读取开门记录，秒级定时
NSString *const commonTimerSendBitLockOpenRecordUpload = @"commonTimerSendBitLockOpenRecordUpload, ";
NSString *const commonTimerSendBitLockDeviceConfiguration = @"commonTimerSendBitLockDeviceConfiguration, ";
NSString *const commonTimerSendBitLockBackListW = @"commonTimerSendBitLockBackListW, ";
NSString *const commonTimerSendBitLockKeyboardPwdTable = @"commonTimerSendBitLockKeyboardPwdTable, ";
NSString *const commonTimerSendBitLockAuthorizedList = @"commonTimerSendBitLockAuthorizedList, ";

////蓝牙连接成功消息
//NSString *const commonTimerBlueConnectSuccessMessage = @"commonTimerBlueConnectSuccessMessage, ";
//定时器定时间隔到通知
NSString *const commonTimerIntervalNotification = @"commonTimerIntervalNotification";
/**
 发现网络
 */
NSString *const kFindNetwork = @"01110000";

/**
 申请入网
 */
NSString *const kAppleNetwork = @"02110000";

//厂商代码
NSString *const kBitManufacturerCode = @"4254";

@implementation BITCommonUnitKeys

@end

