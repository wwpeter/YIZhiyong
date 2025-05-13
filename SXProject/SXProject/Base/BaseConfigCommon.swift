//
//  BaseConfigCommon.swift
//  SXProject
//
//  Created by 王威 on 2024/4/25.
//
//扫地机项目中用到的 枚举

import UIKit

///验证码类型:0用于登录1用于注册2用于忘记密码3用于绑定4用于重置密码
enum CodeType: String, Codable {
    case login = "0"
    case regist = "1"
    case forget = "2"
    case bind = "3"
    case reset = "4"
}

///分组名称
enum EnumDeviceSettingGroup: String, Codable {
    ///外伸贴边设置
    case outward = "OUTWARD"
    ///地板清洁设置
    case floorClean = "FLOOR_CLEAN"
    ///外机器清洁设置
    case machineClean = "MACHINE_CLEAN"
    ///机器人设置
    case robot = "ROBOT"
    ///AI智能识别
    case aiIdentify = "AI_IDENTIFY"
    ///语音助手
    case voiceAssistant = "VOICE_ASSISTANT"
    ///勿扰模式
    case notDisturb = "NOT_DISTURB"
    ///固件
    case frimware = "FIRMWARE"
    
}
