//
//  TrackerManager.swift
//  Sleep
//
//  Created by 王威 on 2022/10/26.
//

import UIKit
//import ZLTracker

class TrackerManager: NSObject {
    
    ///初始化芝兰埋点SDK
    static func initTracker(_ launchOptions: [String: Any]) {
        let URLString: String = "https://md-yf.vongihealth.com/api/v2/save/info"//预发
        //@"https://md.vongihealth.com/api/v2/save/info"; 正式
//        WJBPoint.sharedInstance().config().baseUrl = URLString
//        WJBPoint.sharedInstance().config().app_id = "test"
//        WJBPoint.sharedInstance().config().distinctID = "100"
    }
    
    ///跟踪用户 标识用户
    static func configTrackerInfoWithId(_ userId: String, _ property: NSDictionary) {
//        WJBPoint.sharedInstance().config().distinctID = userId
    }
    
    /// 记录事件
    static func trackEvent(_ eventName: String, _ property: NSDictionary) {
        
//        WJBPoint.sharedInstance().track(eventName, properties: property as? [AnyHashable : Any])
    }
    
    ///记录时长开始
    static func startTrackTime(_ eventName: String) {
//        WJBPoint.sharedInstance().startTrack(eventName)
    }
    
    ///记录时长结束
    static func endTrackTime(_ eventName: String, _ property: NSDictionary) {
//        WJBPoint.sharedInstance().endTrack(eventName, properties: property as? [AnyHashable : Any])
    }
}
