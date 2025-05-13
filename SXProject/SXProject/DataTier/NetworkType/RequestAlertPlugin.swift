//
//  RequestAlertPlugin.swift
//  Sleep
//
//  Created by slan-ww on 2023/1/24.
//

import Foundation
/*
class RequestAlertPlugin: PluginType {
    
    private let showActivity: Bool
    
    init(showActivity: Bool) {
        self.showActivity = showActivity
    }
    
    func willSend(_ request: RequestType, target: TargetType) {
        guard let requestURLString = request.request?.url?.absoluteString else { return }
        //create alert view controller with a single action
        printLog("开始请求\(requestURLString)")
        if showActivity {
            Toast.showWaiting()
        }
    }
    
    func didReceive(_ result: Swift.Result<Moya.Response, MoyaError>, target: TargetType) {
        //only continue if result is a failure
        printLog("didReceive请求")
        switch result {
        case .success(let success):
            
            switch success.statusCode {
                // 重新登录
            case 401:
                AppDelegate.shared?.signOut()
                // 请求成功
            case 200...299:
                if let model = try? JSONDecoder().decode(BaseModel<Bool>.self, from: success.data), model.code != 200 {
                    Toast.showInfoMessage(model.msg)
                } else {
                    Toast.dismissWithCompletion {}
                }
            default:
                Toast.showInfoMessage("网络异常，稍后重试")
            }
            printLog("successCode\(success.statusCode)")
        case .failure:
            Toast.showInfoMessage("网络异常，稍后重试")
        }
    }
}
*/
