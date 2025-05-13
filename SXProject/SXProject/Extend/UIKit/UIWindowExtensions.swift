//
//  UIWindowExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/3.
//

import UIKit

extension Box where Base: UIWindow {
    
    /// 切换根视图
    func switchRootViewController(
        to viewController: UIViewController,
        animated: Bool = true,
        duration: TimeInterval = 0.5,
        options: UIView.AnimationOptions = .transitionFlipFromRight,
        _ completion: (() -> Void)? = nil) {
        guard animated else {
            base.rootViewController = viewController
            completion?()
            return
        }

        UIView.transition(with: base, duration: duration, options: options, animations: {
            let oldState = UIView.areAnimationsEnabled
            UIView.setAnimationsEnabled(false)
            base.rootViewController = viewController
            UIView.setAnimationsEnabled(oldState)
        }, completion: { _ in
            completion?()
        })
    }
}
