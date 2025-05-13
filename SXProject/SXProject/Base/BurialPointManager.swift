//
//  BurialPointManager.swift
//  SXProject
//
//  Created by 王威 on 2025/3/29.
//
/// 埋点管理

import UIKit

class BurialPointManager: NSObject {

    /*
     * ACTIVATION:激活数,
     * REGISTER_PAGE_VIEW:注册页浏览,
     * LOGIN:登录,
     * POST_ORDER:提交订单,
     * LOAN_PAGE_VIEW:填写借款信息浏览,
     /hht/h5/userPoint/add
     */
    /// 埋点 1
    func burialPoint(type: BurialPoint) {
        let IP = GetAddressIPManager.sharedInstance().getMyIP()
        let param = ["action": type.rawValue, "channelCode":"appStore", "ip":IP]// "scene":"", "value":""
        NetworkRequestManager.sharedInstance().requestPath(kPointAdd, withParam: param) { [weak self] result in
            printLog(result)
        
           
        } failure: { error in
//            Toast.showInfoMessage("".sx_T)
        }
    }
    
    /// 埋点 2  增加渠道用户转化埋点
    func burialPointTwo(type: BurialPoint) {
        let IP = GetAddressIPManager.sharedInstance().getMyIP()
        let param = ["event": type.rawValue, "channelCode":"appStore", "ip":IP, "page":""]
        NetworkRequestManager.sharedInstance().requestPath(kAddTransformPoint, withParam: param) { [weak self] result in
            printLog(result)
      
        } failure: { error in
//            Toast.showInfoMessage("".sx_T)
        }
    }
}
