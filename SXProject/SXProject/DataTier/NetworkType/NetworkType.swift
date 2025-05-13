//
//  Network.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/3.
//

import Foundation
//import UIKit
//
//public protocol NetworkType: TargetType {}
//
//public extension NetworkType {
//    var baseURL: URL {
//        return URL(string: kBaseURL.url)!
//    }
//    var headers: [String : String]? {
//        let deviceModel = UIDevice.current.model
//        let deviceSystem = UIDevice.current.systemVersion
//        return [
//            // 应用唯一标识 iOS: 1 Android: 2
//            "HEADER_APP_ID": "1",
//            // 设备的模型 + 版本号
//            "HEADER_APP_MODEL": deviceModel + deviceSystem,
//            // 1: 患者 2: 医生
//            "HEADER_APP_TYPE": "1",
//            // app的版本号
//            "HEADER_APP_VER": UIApplication.sx.version ?? "",
//            // 设备的版本号
//            "DEVICE_SYSTEM": deviceSystem,
//            // 设备的模型
//            "DEVICE_MODEL": deviceModel,
//            // 用户的token
//            "Authorization": CacheManage.shared.accessToken() ?? "",
//            // 当前的语言
//            "ACCEPT_LANGUAGE": Localize.currentLanguage(),
//            // 可接收的类型
//            "Content-type": "application/json",
//            "time" : ""
//        ]
//    }
//    
//    //获取当前时间戳
//    func getCurrentTimestamp() -> TimeInterval {
//        let currentTime = Date().timeIntervalSince1970
//        return currentTime
//    }
//}
