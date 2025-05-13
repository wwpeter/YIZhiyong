//
//  CommonTool.swift
//  SXProject
//
//  Created by 王威 on 2024/4/26.
//

import UIKit


///沙盒存储
func setUserDefault(key: String, value: String) {
    UserDefaults.standard.setValue(value, forKeyPath: key)
    UserDefaults.standard.synchronize()
}

///沙盒读取
func getUserDefault(key: String) -> String {
    guard let str = UserDefaults.standard.value(forKeyPath: key) as? String else { return "" }
    return str
}

///删除沙盒中的字段
func delUserDefault(key: String) {
    UserDefaults.standard.removeObject(forKey: key)
    UserDefaults.standard.synchronize()
}

///处理解包问题
func dealData(_ result: Dictionary<AnyHashable, Any>?) -> Dictionary<String, String> {
    if let swiftDict = result {
        if let dic = swiftDict["data"] as? [String : String] {
            return dic
        }
        return ["":""]
    }
    return ["":""]
}


