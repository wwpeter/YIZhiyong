//
//  CommonRequestApi.swift
//  SXProject
//
//  Created by 王威 on 2024/4/22.
//

import UIKit

class CommonRequestApi: NSObject {

    static let shared = CommonRequestApi() // 声明一个静态的共享实例
        
    private override init() {
            // 私有化构造函数，防止外部创建实例
    }
        
//        // 单例的其他属性和方法
//    func getNetApi(ApiPath: String, Params: [String: Any]) -> BITRequestApi{
//            // 执行操作
//        let reqApi = BITRequestApi()
//        reqApi.setBaseURL(String.init(format: "%@", kBaseURL.url))
////        reqApi.apiPath = ApiPath
//        
//        
//        return reqApi
//    }
}
