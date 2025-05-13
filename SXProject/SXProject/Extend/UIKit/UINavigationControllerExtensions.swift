//
//  UINavigationControllerExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/6.
//

import UIKit

extension Box where Base: UINavigationController {
    ///  Pop ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - animated: Set this value to true to animate the transition (default is true).
    ///   - completion: optional completion handler (default is nil).
    func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        base.popViewController(animated: animated)
        CATransaction.commit()
    }

    ///  Push ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - viewController: viewController to push.
    ///   - completion: optional completion handler (default is nil).
    func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        base.pushViewController(viewController, animated: true)
        CATransaction.commit()
    }

    ///  Make navigation controller's navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    func makeTransparent(withTint tint: UIColor = .white) {
        base.navigationBar.setBackgroundImage(UIImage(), for: .default)
        base.navigationBar.shadowImage = UIImage()
        base.navigationBar.isTranslucent = true
        base.navigationBar.tintColor = tint
        base.navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
}
