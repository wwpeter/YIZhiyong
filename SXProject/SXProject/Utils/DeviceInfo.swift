//
//  DeviceInfo.swift
//  Sleep
//
//  Created by slan-sx on 2022/10/10.
//

import Foundation
import UIKit

struct DeviceInfo {
    static var statusBarHeight: Double {
        if #available(iOS 13.0, *) {
           let scene = UIApplication.shared.connectedScenes.first
           guard let windowScene = scene as? UIWindowScene else { return 0 }
           guard let statusBarManager = windowScene.statusBarManager else { return 0 }
           return Double(statusBarManager.statusBarFrame.height)
       } else {
           return Double(UIApplication.shared.statusBarFrame.size.height)
       }
    }
    static var screenWidth: Double {
       return UIScreen.main.bounds.size.width
    }
    static var screenHeight: Double {
        return UIScreen.main.bounds.size.height
    }
    static var toolbarHeight: Double {
        return 44.0
    }
    
    /// 底部安全区域
    ///
    /// - Returns: height
    static func bottomSafeAreaSpace() -> Float {
        return UIDevice.sx.isFullScreenSerise ? 34.0 : 0
    }
    
    /// tabbr高度
    ///
    /// - Returns: height
    static func tabBarHeight() -> Float {
        return bottomSafeAreaSpace() + 49.0
    }
    
    func getDeviceModel() -> String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        return identifier
    }

    func getDeviceType() -> String {
        let deviceModel = getDeviceModel()

        switch deviceModel {
        case "iPhone1,1": return "iPhone 2G"
        case "iPhone1,2": return "iPhone 3G"
        case "iPhone2,1": return "iPhone 3GS"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return "iPhone 4"
        case "iPhone4,1": return "iPhone 4S"
        case "iPhone5,1", "iPhone5,2": return "iPhone 5"
        case "iPhone5,3", "iPhone5,4": return "iPhone 5C"
        case "iPhone6,1", "iPhone6,2": return "iPhone 5S"
        case "iPhone7,2": return "iPhone 6"
        case "iPhone7,1": return "iPhone 6 Plus"
        case "iPhone8,1": return "iPhone 6S"
        case "iPhone8,2": return "iPhone 6S Plus"
        case "iPhone8,4": return "iPhone SE"
        case "iPhone9,1", "iPhone9,3": return "iPhone 7"
        case "iPhone9,2", "iPhone9,4": return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4": return "iPhone 8"
        case "iPhone10,2", "iPhone10,5": return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6": return "iPhone X"
        case "iPhone11,2": return "iPhone XS"
        case "iPhone11,4", "iPhone11,6": return "iPhone XS Max"
        case "iPhone11,8": return "iPhone XR"
        case "iPhone12,1": return "iPhone 11"
        case "iPhone12,3": return "iPhone 11 Pro"
        case "iPhone12,5": return "iPhone 11 Pro Max"
        case "iPhone12,8": return "iPhone SE (2nd generation)"
        case "iPhone13,1": return "iPhone 12 mini"
        case "iPhone13,2": return "iPhone 12"
        case "iPhone13,3": return "iPhone 12 Pro"
        case "iPhone13,4": return "iPhone 12 Pro Max"
        case "iPhone14,4", "iPhone14,5": return "iPhone 13 mini"
        case "iPhone14,2", "iPhone14,3": return "iPhone 13"
        case "iPhone14,4", "iPhone14,5": return "iPhone 13 Pro"
        case "iPhone14,4", "iPhone14,5": return "iPhone 13 Pro Max"
        default: return "Unknown"
        }
    }
}
