//
//  BaseConfig.swift
//  Sleep
//
//  Created by 王威 on 2023/2/10.
//
//全局的 枚举定义 总和

import UIKit

//是否绑定呼吸机
enum BindVentilator: Int, Codable {
    case bindVentilator = 1 //绑定呼吸机
    case unbindVentilator = 0//未绑定呼吸机
}
///性别
enum GenderType: String {
    //（1男，2女，0未知）
    case man = "1"
    case women = "2"
    case other = "0"
}
//呼吸机 血氧仪切换
enum ReportType: String, Codable {
    //（1呼吸机，2血氧仪）
    case ventilator = "1"
    case oximeter = "2"
}
///电磁波动态颜色
enum StatusBarType: Int, Codable {
    //0 白色 1 黑色
    case barLight = 0
    case barBlack = 1
}
///全局的 是 或者否
enum SelectedType: String, Codable {
    //是否
    case yes = "是"
    case no = "否"
}


///睡眠类型
enum SleepType: Int, Codable {
    //0=清醒期 1=眼动期   2=浅睡期  3=深睡期
    case sober = 0
    case eyeMove = 1
    case lightSleep = 2
    case deepSleep = 3
}


/*
 //筛查结果 1-低风险 2-高风险 3- 重新筛查
 var screenResult: Int? = 1
 */

enum ScreenResultReport: Int, Codable {
    case none = 0
    case osaLow = 1
    case osaHight = 2
    case osaAgain = 3
    
    var osaReasonShow: String {
        switch self {
        case .osaLow:
            return "低风险"
        case .osaHight:
            return "高风险"
        case .osaAgain:
            return "重新筛查"
        case .none:
            return ""
        }
    }
}
