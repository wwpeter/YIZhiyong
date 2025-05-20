//
//  DDBaseViewController.swift
//  LangHuaStage
//
//  Created by 王大力 on 2017/11/28.
//  Copyright © 2017年 LangHuaStage. All rights reserved.
//

import UIKit

typealias DDBaseViewBlock = (Any?)->()

///基类控制器
class DDBaseViewController: UIViewController {
    
    var success:DDBaseViewBlock?
    var cancel:DDBaseViewBlock?
    
    public lazy var topNavView: DDCustNavView = { ()->DDCustNavView in
        let navview = DDCustNavView(frame: CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: kTopBarHeight))
        return navview
    }();
  
    
    /**导航栏标题*/
    override open var title: String? {
        get{
            return self.topNavView.title
        }
        set {
            self.topNavView.title = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.setUpUI()
        self.view.backgroundColor = kBF2
        
        if #available(iOS 13.0, *) {
            UITextField.appearance().overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        //导航
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.foregroundColor:kT333] //中间文本
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().barTintColor = .clear
        
        UITabBar.appearance().tintColor = UIColor.black
        UIToolbar.appearance().tintColor = UIColor.black
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        } else {
        }
    }
    
    /**是否隐藏导航*/
    public func hideNavgationBar(isHide:Bool) {
        topNavView.isHidden = isHide
    }
    
    /**隐藏返回键*/
    public func hideBackButton() {
        self.topNavView.leftButton.isHidden = true
    }
    
//    public override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    
    /**返回按键*/
    @objc public dynamic func leftButtonClicked() {
        if let action = self.cancel {
            action(nil)
        } else {
            _ =  self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    fileprivate func setUpUI() {
        self.view.addSubview(topNavView)
        topNavView.leftButton.addTarget(self, action: #selector(leftButtonClicked), for: .touchUpInside)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    // 支持哪些屏幕方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
