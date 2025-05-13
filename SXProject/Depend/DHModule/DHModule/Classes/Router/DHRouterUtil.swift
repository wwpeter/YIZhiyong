//
//  DHRouterUtil.swift
//  LCPushMessageModule
//
//  Created by jiangbin on 2021/10/20.
//

import UIKit

@objc public class DHRouterUtil: NSObject {
    
    /// 获取App视图所在window
    /// - Returns: UIWindow
    @objc public static func getAppWindow() -> UIWindow? {
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != .normal {
            let windows = UIApplication.shared.windows
            for windowTemp in windows {
                if windowTemp.windowLevel == .normal {
                    window = windowTemp
                    break
                }
            }
        }
        
        return window
    }
    
    /// 获取当前视图
    /// - Returns: UIViewController
    @objc public static func getCurrentVc() -> UIViewController? {
        let rootVc = getAppWindow()?.rootViewController
        return recursiveTopViewController(rootVc)
    }
    
    //MARK: - Private
    /// 递归获取controller的最顶部视图
    /// - Parameter controller: 当前vc
    /// - Returns: UIViewController
    private static func recursiveTopViewController(_ controller: UIViewController?) -> UIViewController? {
        if controller == nil {
            return nil
        }
        
        if let presentVc = controller?.presentedViewController {
            return recursiveTopViewController(presentVc)
        } else if let tabVc = controller as? UITabBarController {
            return recursiveTopViewController(tabVc.selectedViewController)
        } else if let naviVc = controller as? UINavigationController {
            return recursiveTopViewController(naviVc.visibleViewController)
        }
        
        return controller
    }
}
