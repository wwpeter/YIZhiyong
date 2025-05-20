//
//  SendCodeVC+Config.swift
//  SXProject
//
//  Created by 王威 on 2025/3/27.
//

import UIKit

extension SendCodeVC {
    
    /// 埋点
    func burialPoint() {
        let manager = BurialPointManager()
        
        manager.burialPoint(type: BurialPoint.LOGIN)
    }
    /// 登录
    func goLogin() {
        if  self.startCode.isEmpty {
            Toast.showInfoMessage("请输入验证码")
            return
        }
        let osVersion = UIDevice.current.systemVersion
        var IP =  GetAddressIPManager.sharedInstance().getMyIP()
        if IP.isEmpty {
            let wifiIP = GetDeviceIP.getCurrentWiFiIPAddress()
            GetAddressIPManager.sharedInstance().ip = wifiIP ?? ""
            IP = wifiIP ?? ""
        }
        let param = ["telephone": self.telephone, "validateCode":startCode,"ip":IP, "osType":"iOS", "osVersion":osVersion,
                     "channelCode":"appstore", "channelUserId":"AppStore"]
        NetworkRequestManager.sharedInstance().requestPath(kLogin, withParam: param) { [weak self] result in
            printLog(result)
            
            self?.burialPoint() /// 埋点
            
            let dic = JSONHelper.exchangeDic(jsonStr: result)
          
            
            if let tokenT = dic["token"] as? String {
                setUserDefault(key: "token", value:  tokenT)
            }
            if let hhtPageUrl = dic["hhtPageUrl"] as? String {
                setUserDefault(key: "hhtPageUrl", value:  hhtPageUrl)
            }
            
            if let hjfqPageUrl = dic["hjfqPageUrl"] as? String {
                setUserDefault(key: "hjfqPageUrl", value:  hjfqPageUrl)
            }
            
            if let showHhtPage = dic["showHhtPage"] as? String {
                setUserDefault(key: "showHhtPage", value:  showHhtPage)
            }
            
            if let userId = dic["userId"] as? String {
                setUserDefault(key: "userId", value:  userId)
            }
            
            setUserDefault(key: "phone", value:  self?.telephone ?? "")
            
            UserSingleton.shared.getUser()
            
            self?.dismiss(animated: true)
            
            AppDelegate.shared?.goTabBar()
        } failure: { error in
            //            Toast.showInfoMessage("".sx_T)
        }
    }
}
