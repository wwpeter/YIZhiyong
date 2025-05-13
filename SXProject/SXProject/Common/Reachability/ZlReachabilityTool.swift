//
//  ZlReachabilityTool.swift
//  Sleep
//
//  Created by 王威 on 2022/10/19.
//
//  实时网络监测

import UIKit
import Alamofire
//import Reachability

enum JhNetworkStatus {
    /// 未知网络
    case unknown
    /// 无网络
    case notReachable
    /// 手机网络
    case wwan
    // WIFI网络
    case ethernetOrWiFi
}

class ZlReachabilityTool {
    
    static let shared = ZlReachabilityTool()
    
//    static let reachability = try? Reachability()
    static let networkManager = NetworkReachabilityManager(host: "www.apple.com")
    
//    /// 监听网络变化 - ReachabilitySwift
//    static func monitorNetworkStatus1(status: @escaping(JhNetworkStatus) -> Void) {
//        // 网络可用或切换网络类型时执行
//        reachability?.whenReachable = { reachability in
//            if reachability.connection == .wifi {
//                printLog("WiFi")
//                status(.ethernetOrWiFi)
//            } else {
//                printLog("蜂窝移动网络")
//                status(.wwan)
//            }
//        }
//
//        // 网络不可用时执行
//        reachability?.whenUnreachable = { reachability in
//            printLog("无网络连接")
//            status(.notReachable)
//        }
//
//        do {
//            // 开始监听，停止监听调用reachability.stopNotifier()即可
//            try reachability?.startNotifier()
//        } catch {
//            printLog("Unable to start notifier")
//        }
//    }
    
    /// 监听网络变化 - Alamofire
    static func monitorNetworkStatus2(status: @escaping(JhNetworkStatus) -> Void) {
        networkManager?.startListening(onUpdatePerforming: { statusT in
               switch statusT {
               case .notReachable:
                   print("暂时没有网络连接")
                   status(.notReachable)
               case .unknown:
                   print("网络状态未知")
                   status(.unknown)
               case .reachable(.ethernetOrWiFi):
                   print("以太网或者wifi")
                   status(.ethernetOrWiFi)
               case .reachable(.cellular):
                   print("蜂窝数据")
                   status(.wwan)
               }
           })
    }
}
