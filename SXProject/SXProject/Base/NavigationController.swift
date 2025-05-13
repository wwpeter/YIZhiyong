//
//  NavigationController.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/2.
//
//  根Navigation控制器

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        weak var weakSekf = self
        if responds(to: #selector(getter: interactivePopGestureRecognizer)) {
            interactivePopGestureRecognizer?.delegate = weakSekf
        }
    }
    
    func setUp() {
        if #available(iOS 15.0, *) {
            // 获取导航的外观 （13.0的方法）
            let appearance = UINavigationBarAppearance()
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: AssetColors.b000.color,
                NSAttributedString.Key.font: UIFont.sx.font_t17
            ]
            
            appearance.backgroundImage = AssetImages.write.image
            appearance.shadowImage = UIImage()
            // 可滑动页面的设置
            navigationBar.scrollEdgeAppearance = appearance
            // 普通的页面设置
            navigationBar.standardAppearance = appearance
        } else {
            navigationBar.backgroundColor = AssetColors.bfff.color
            navigationBar.barTintColor = AssetColors.t000.color
            navigationBar.setBackgroundImage(AssetImages.write.image, for: .default)
            navigationBar.shadowImage = UIImage()
        }
        navigationBar.isTranslucent = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if !children.isEmpty {
            
            let backBtn = UIButton(type: .custom)
            // 设置图片
            backBtn.sx.setImageForAllStates(AssetImages.navigationBack.image)
            // 内部按钮左对齐
            backBtn.contentHorizontalAlignment = .left
            backBtn.addTarget(self, action: #selector(backAction), for: .touchUpInside)
            // 设置按钮大小
            backBtn.frame = CGRect(origin: .zero, size: CGSize(width: 30, height: 30))
            // 距离左边偏移量
            backBtn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            let item = UIBarButtonItem(customView: backBtn)
            viewController.navigationItem.leftBarButtonItem = item
            
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc
    func backAction() {
        popViewController(animated: true)
    }
}

// MARK: UIGestureRecognizerDelegate
extension NavigationController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // 如果是根视图禁用侧滑
        if gestureRecognizer == interactivePopGestureRecognizer,
           viewControllers.count < 2,
           visibleViewController == viewControllers.first {
            return false
        }
        return true
    }
}
