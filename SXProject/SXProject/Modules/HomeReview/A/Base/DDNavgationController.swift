//
//  DDNavgationController.swift
//  LangHuaStage
//
//  Created by 王大力 on 2017/11/28.
//  Copyright © 2017年 LangHuaStage. All rights reserved.
//

import UIKit
/** 基类导航控制器
 */
public class DDNavgationController: UINavigationController, UIGestureRecognizerDelegate {

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
        self.interactivePopGestureRecognizer?.delegate = self;
    }
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.children.count==1) {
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated)
    }
    public override func popViewController(animated: Bool) -> UIViewController? {
       let vc = super.popViewController(animated: animated)
        if self.children.count == 2 {
            self.children.last?.hidesBottomBarWhenPushed = true
        }
        return vc
    }
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.children.count > 1;
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
      }
    
}
