//
//  AppDelegate+config.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/2.
//
//  配置启动时第三方初始化

import Foundation
import AVFAudio
import UIKit
//import Bugly
import SnapKit
import AppTrackingTransparency
import AdSupport

extension AppDelegate {
    func config() {
        
        // 登录失效的通知
        NotificationCenter.default.addObserver(self, selector: #selector(goLoginNew), name: kLoginOutNotification, object: nil)
        
        let iqKeyboardManager = IQKeyboardManager.shared
        // 是否开启
        iqKeyboardManager.enable = true
        // 控制点击背景是否收起键盘
        iqKeyboardManager.shouldResignOnTouchOutside = true
        // 是否显示工具条
        iqKeyboardManager.enableAutoToolbar = false
        
        //初始化配置loading
        Toast.swiftload()
        
        //初始化路由
        initializeRouter()
        //网络可达性
        monitorNetwork()
        ///初始化埋点
        tracker()
        ///bug统计
        bugly()
        ///初始化网络配置
        initNetWorkConfig()
        /// 获取ip
        getIPAdress()
  
        /// 跟踪
        requestTrackingPermission()
        /// 第一次安装
//        firstApp()

        // 设置后并激活后台播放
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.playback)
        try? session.setActive(true)
        // 允许应用程序接收远程控制
        UIApplication.shared.beginReceivingRemoteControlEvents()
        becomeFirstResponder()
    
    }

    // 第一次安装
    func firstApp() {
        //第一次安装
        let firstIns = UserDefaults.standard.bool(forKey: kFirstInstallation)
        if !firstIns {
           /// 弹出隐私协议 弹窗
            let alertView = AlertViewFirstApp()
            
            alertView.show()
        }
    }
    
    /// 追踪权限
    func requestTrackingPermission() {
        // 1. 检查追踪权限状态
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    print("授权成功，IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
                case .denied:
                    print("用户拒绝追踪")
                case .notDetermined:
                    print("未做出选择")
                case .restricted:
                    print("设备限制")
                @unknown default:
                    break
                }
            }
        } else {
            // iOS 14 以下直接获取 IDFA
//            print("旧版 IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
        }
    }
    
    // MARK: - ip获取
    func getIPAdress() {
        GetAddressIPManager.sharedInstance().getAddressIp()
    }
   
    // MARK: - bugly
    func bugly() {
//        Bugly.start(withAppId: "此处替换为你的AppId")
    }
    
    // MARK: - 初始化网络配置
    func initNetWorkConfig() {
        //初始化配置
        RequestConfigManager.requestConfig()
    }
    
    // MARK: - 初始化埋点
    func tracker() {
        //initZhuge:launchOptions
        TrackerManager.initTracker(["launchOptions":"launchOptions"]) //暂时不需要launchOptions  需要时候在传入
    }
    
    // MARK: - 初始化路由
    func initializeRouter() {//
//        let appName: String = (Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String)!
//        let mineModule = String.init(format: "%@.ZLMineModule", appName)//我的模块
//        let reportModule = String.init(format: "%@.ReportRouter", appName)//我的报告
//        
//        DHModule.load(byNameArray: [mineModule, reportModule])
    }
    // MARK: - 实时网络监测
    func monitorNetwork() {
        ZlReachabilityTool.monitorNetworkStatus2 { status in
            var message = ""
            switch status {
            case .unknown:
                message = "未知网络"
                kSXNotificationCenter.post(name:NSNotification.Name(rawValue: "kZLNotificationnetWork"), object: ["network": false])
            case .notReachable:
                message = "无网络连接"
                kSXNotificationCenter.post(name:NSNotification.Name(rawValue: "kZLNotificationnetWork"), object: ["network": false])
            case .wwan:
                message = "蜂窝移动网络"
                kSXNotificationCenter.post(name:NSNotification.Name(rawValue: "kZLNotificationnetWork"), object: ["network": true])
            case .ethernetOrWiFi:
                message = "WiFi"
                kSXNotificationCenter.post(name:NSNotification.Name(rawValue: kZLNotificationnetWork), object: ["network": true])
            }
            printLog("当前网络状态===：\(message)")
        }
    }
    
    // MARK: 锁屏交互相关
    override var canBecomeFirstResponder: Bool {
        true
    }
    // 锁屏界面用户交互
    override func remoteControlReceived(with event: UIEvent?) {
        guard let event = event else {
            return
        }
        if event.type == .remoteControl {
            switch event.subtype {
            case .none:
                printLog("none")
            case .motionShake:
                printLog("motionShake")
            case .remoteControlPlay:
                printLog("remoteControlPlay")
            case .remoteControlPause:
                printLog("remoteControlPause")
            case .remoteControlStop:
                printLog("remoteControlStop")
            case .remoteControlTogglePlayPause:
                printLog("remoteControlTogglePlayPause")
            case .remoteControlNextTrack:
                printLog("remoteControlNextTrack")
            case .remoteControlPreviousTrack:
                printLog("remoteControlPreviousTrack")
            case .remoteControlBeginSeekingBackward:
                printLog("remoteControlBeginSeekingBackward")
            case .remoteControlEndSeekingBackward:
                printLog("remoteControlEndSeekingBackward")
            case .remoteControlBeginSeekingForward:
                printLog("remoteControlBeginSeekingForward")
            case .remoteControlEndSeekingForward:
                printLog("remoteControlEndSeekingForward")
            @unknown default: printLog("unknown")
            }
        }
    }
}
