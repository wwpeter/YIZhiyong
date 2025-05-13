//
//  AppDelegate+Jump.swift
//  DigitalSleep
//
//  Created by ww on 2021/11/30.
//
//  入口切换

import Foundation
import SafariServices

extension AppDelegate {

    static var shared: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func checkLoginStatus() {
        let token = getUserDefault(key: "token")
        if token.isEmpty {
            goLogin()
            return
        }
        goTabBar()
    }
    
    /// 跳转登录
    func goLogin() {
        guard !(UIApplication.sx.getCurrentViewController() is LoginVC) else { return }
        let vc = LoginVC()
        let niv = NavigationController.init(rootViewController: vc)
        niv.modalPresentationStyle = .fullScreen
        go(with: niv)
    }
    /// 跳转登录新
    @objc func goLoginNew() {
        guard !(UIApplication.sx.getCurrentViewController() is LoginVC) else { return }
        let vc = LoginVC()
        let niv = NavigationController.init(rootViewController: vc)
        niv.modalPresentationStyle = .fullScreen
        
        DHRouterUtil.getCurrentVc()?.present(niv, animated: true, completion: {
            printLog("进入登录！")
        })
    }
    
    /// 退出
    func signOut() {
        // 清楚本地缓存
        removeAllStroage()
        // 跳转登录
        go(with: LoginVC())
    }
    
    func removeAllStroage() {
        // 清楚本地缓存
//        CacheManage.shared.removeAllStorage()
    }
    

    func goTabBar() {
        go(with: TabBarController())
    }
    
    
    // 跳转web页
    func goWebView() {
//        go(with: DsWebController())
    }
    
    /// 跳转指定页面
    /// - Parameter controller: controller
    func go(with controller: UIViewController) {
        window?.sx.switchRootViewController(to: controller)
        window?.makeKeyAndVisible()
    }
}
