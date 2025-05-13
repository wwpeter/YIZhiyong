//
//  ZlNotificationKey.swift
//  Sleep
//
//  Created by 王威 on 2022/10/20.
//
//项目中 所有的通知中心的key值 维护中心。

import Foundation

let kZLNotificationnetWork: String = "kZLNotificationnetWork"
//登录之后刷新首页
let kZLNotificationLogin: String = "kZLNotificationLogin"
///绑定成功之后跳转
let kZLNotificationBindDeviceSul = "kZLNotificationBindDeviceSul"

// 在用户切换语言后发送通知
let languageDidChangeNotification = Notification.Name("LanguageDidChange")

///添加问题之后刷新
let kAddProblemAfterNotification =  Notification.Name("kAddProblemAfterNotification")

/// 更新当前设备列表
let kRefreshDevicelistNotification = Notification.Name("kRefreshDevicelistNotification")

/// 更新设备详情
let kRefreshDeviceDetailNotification = Notification.Name("kRefreshDeviceDetailNotification")

// 登录失效通知
let kLoginOutNotification = Notification.Name("kLoginOutNotification")
