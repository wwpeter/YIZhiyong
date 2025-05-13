//
//  UIApplicationExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/6.
//

import UIKit

extension Box where Base: UIApplication {
    /// Application name (if applicable).
    static var displayName: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
    
    /// App current build number (if applicable).
    static var buildNumber: String? {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
    }

    /// App's current version number (if applicable).
    static var version: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    // getKeyWindow
    func getKeyWindow() -> UIWindow? {
        var keyWindow: UIWindow?
        var windowScene: UIWindowScene?
            
        for item in Base.shared.connectedScenes {
            if let temp = item as? UIWindowScene {
                windowScene = temp
            }
        }
        guard let wScene = windowScene else { return nil }
        
        for item in wScene.windows where item.isKeyWindow {
            keyWindow = item
        }
        return keyWindow
    }
    
    /// getCurrentViewController
    static func getCurrentViewController(base: UIViewController? = Base.shared.sx.getKeyWindow()?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getCurrentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return getCurrentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return getCurrentViewController(base: presented)
        }
        return base
    }
}
