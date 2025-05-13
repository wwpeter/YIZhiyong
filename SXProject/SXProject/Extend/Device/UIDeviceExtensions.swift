//
//  UIDevice+Hardware.swift
//  Sleep
//
//  Created by 王威 on 2022/10/18.
//

import UIKit

// MARK: - 设备的型号
extension Box where Base: UIDevice {
    static var wwff: String {
        return "ww"
    }
}

extension Box where Base: UIDevice {
    /// 具体的设备的型号
     static var deviceType: String {
        
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        
         let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
            
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone SE"
        case "iPhone9,1":                               return "iPhone 7"
        case "iPhone9,2":                               return "iPhone 7 Plus"
        case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
        case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
        case "iPhone10,3", "iPhone10,6":                return "iPhone X"
        case "iPhone11,2":                              return "iPhone Xs"
        case "iPhone11,4", "iPhone11,6":                return "iPhone Xs Max"
        case "iPhone11,8":                              return "iPhone XR"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3", "AppleTV6,2":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
}

// MARK: - 手机系列判断
extension Box where Base: UIDevice {
    /// 是否是iPhone系列
     static var iPhoneSeries: Bool {
        return Base.current.userInterfaceIdiom == .phone
    }
    
    /// 是否是iPad系列
     static var iPadSeries: Bool {
        return Base.current.userInterfaceIdiom == .pad
    }
    
    /// 是否是iPhone 4.7系列手机
     static  var isPhone4_7Serier: Bool {
        return UIScreen.main.bounds.width == 375.0
    }
    
    /// 是否是iPhone 5.5系列手机
     static var isPhone5_5Series: Bool {
        return UIScreen.main.bounds.width == 414.0
    }
    
    /// 是否是iPhone X手机
     static var isPhoneXSerise: Bool {
        return deviceType == UIDevice.Info.iPhoneX
    }
    
    /// 是否是全屏系列 目前可以通过状态栏的高度为20 或者 44来判断 为后面的新的全屏机做准备
    static var isFullScreenSerise: Bool {
        return DeviceInfo.statusBarHeight == 44.0
    }
}

// MARK: - 手机信息
extension Box where Base: UIDevice {
    /// uudi 注意其实uuid并不是唯一不变的
    static var uuid: String? {
        return Base.current.identifierForVendor?.uuidString
    }
    
    /// 设备系统名称
    static var deviceSystemName: String {
        return Base.current.systemName
    }
    
    /// 设备名称
    static var deviceName: String {
        return Base.current.name
    }
    
    /// 设备版本
    static var deviceSystemVersion: String {
        return Base.current.systemVersion
    }
    
    /// 设备版本的Float类型, 如果等于-1了那么就说明转换失败了
    static var deviceFloatSystemVersion: Float {
        return Float(deviceSystemVersion) ?? -1.0
    }
}

// MARK: - 字符串常量化
extension UIDevice {
     struct Info {
        public static let iPodTouch5 = "iPod Touch 5"
        
        public static let iPodTouch6 = "iPod Touch 6"
        
        public static let iPhone4 = "iPhone 4"
        
        public static let iPhone4s = "iPhone 4s"
        
        public static let iPhone5 = "iPhone 5"
        
        public static let iPhone5c = "iPhone 5c"
        
        public static let iPhone5s = "iPhone 5s"
        
        public static let iPhone6 = "iPhone 6"
        
        public static let iPhone6Plus = "iPhone 6 Plus"
        
        public static let iPhone6s = "iPhone 6s"
        
        public static let iPhone6sPlus = "iPhone 6s Plus"
        
        public static let iPhoneSE = "iPhone SE"
        
        public static let iPhone7 = "iPhone 7"
        
        public static let iPhone7Plus = "iPhone 7 Plus"
        
        public static let iPhone8 = "iPhone 8"
        
        public static let iPhone8Plus = "iPhone 8 Plus"
        
        public static let iPhoneX = "iPhone X"
        
        public static let iPhoneXs = "iPhone Xs"
        
        public static let iPhoneXsMax = "iPhone Xs Max"
        
        public static let iPhoneXR = "iPhone XR"
        
        public static let iPad2 = "iPad 2"
        
        public static let iPad3 = "iPad 3"
        
        public static let iPad4 = "iPad 4"
        
        public static let iPadAir = "iPad Air"
        
        public static let iPadAir2 = "iPad Air 2"
        
        public static let iPadMini = "iPad Mini"
        
        public static let iPadMini2 = "iPad Mini 2"
        
        public static let iPadMini3 = "iPad Mini 3"
        
        public static let iPadMini4 = "iPad Mini 4"
        
        public static let iPadPro = "iPad Pro"
        
        public static let AppleTV = "Apple TV"
        
        public static let Simulator = "Simulator"
    }
}

// MARK: - iOS版本判断
extension Box where Base: UIDevice {
    enum Versions: Float {
        case five = 5.0
        case six = 6.0
        case seven = 7.0
        case eight = 8.0
        case nine = 9.0
        case ten = 10.0
        case eleven = 11.0
    }
    
    static func isVersion(_ version: Versions) -> Bool {
        return UIDevice.sx.deviceFloatSystemVersion >= version.rawValue && UIDevice.sx.deviceFloatSystemVersion < (version.rawValue + 1.0)
    }
    
    static func isVersionOrLater(_ version: Versions) -> Bool {
        return UIDevice.sx.deviceFloatSystemVersion >= version.rawValue
    }
    
    static func isVersionOrEarlier(_ version: Versions) -> Bool {
        return UIDevice.sx.deviceFloatSystemVersion < (version.rawValue + 1.0)
    }
}
