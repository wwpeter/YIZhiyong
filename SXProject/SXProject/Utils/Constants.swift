//
//  Constant.swift
//  DigitalSleep
//
//  Created by ww on 2021/11/18.
//
//  常量文件
//  用途：用来描述应用中通用的数据

import UIKit

// MARK: - 屏幕尺寸
// 屏幕宽
let kSizeScreenWidth = UIScreen.main.bounds.width
// 屏幕高
let kSizeScreenHight = UIScreen.main.bounds.height
//动态缩放
let kDynamic = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) / 375
//
public func sxDynamic(_ size: CGFloat) -> CGFloat {
    return size * CGFloat(kDynamic)
}

//常用颜色
let kGradientStart = AssetColors.blogin1.color
let kGradientEnd = AssetColors.blogin2.color

//字体颜色
let kT333 = AssetColors.t333.color
let kT777 = AssetColors.t777.color
let kTBlue = AssetColors.t2564ff.color
let kTaaa = AssetColors.taaa.color

//背景颜色
let kBF2 = AssetColors.bf2.color
let kBF8 = AssetColors.bf8.color
let kBF4F5F9 = AssetColors.bf4F5F9.color
let kRoom1 = AssetColors.broom1.color
let kRoom2 = AssetColors.broom2.color
let kRoom3 = AssetColors.broom3.color
let kRoom4 = AssetColors.broom4.color
let kGroundColor = AssetColors.bf4F5F9.color
let kWhite = AssetColors.bfff.color


///公用的 电话 官网等
let kHotLine = "400-3445-3445"
let kOfficialWebsite = "https://www.booleancloud.cn/"

//状态栏高度

let kStatusBarHeight = (CGFloat)(kSizeScreenHight >= 812.0 ? 44 : 20)

//top高度
let kTopBarHeight = (CGFloat)(kStatusBarHeight + 44)

//iPhone X 底部安全距离：34
let kBottomSafeBarHeight = (CGFloat)(kSizeScreenHight >= 812.0 ? 34 : 0)

//tabbar
let kTabbarHeight = (CGFloat)(kSizeScreenHight >= 812.0 ? 34 : 0) + 49

// MARK: - 应用
/// App 显示名称
let kAppDisplayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] ?? ""
/// App BundleName
let kAppName = Bundle.main.infoDictionary![kCFBundleNameKey as String] ?? ""
/// App BundleID
let kAppBundleID = Bundle.main.bundleIdentifier ?? ""
/// App 版本号
let kAppVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] ?? ""
/// App BuildNumber
let kAppBuildNumber = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) ?? ""
/// 手机系统
let kDeviceSystem = UIDevice.current.systemVersion


/// App Language en
let kSXAPPLanguage = NSLocale.preferredLanguages[0]
let kSXApplication = UIApplication.shared
let kSXKeyWindow = UIApplication.shared.windows
let kSXAppDelegate = UIApplication.shared.delegate
let kSXUserDefaults = UserDefaults.standard
let kSXNotificationCenter = NotificationCenter.default

//第一次安装
let kFirstInstallation = "kFirstInstallation"


// MARK: - 读取图片
public func DDSImage(_ name:String ) -> UIImage? {
    return UIImage(named: name)
}

public func DDSFont(_ size:CGFloat) -> UIFont {
    UIFont.systemFont(ofSize:size)
}

public func DDSFont_B(_ size:CGFloat) -> UIFont {
    UIFont.systemFont(ofSize:size, weight: .semibold)
}

public func DDSFont_M(_ size:CGFloat) -> UIFont {
    UIFont.systemFont(ofSize:size, weight: .medium)
}
