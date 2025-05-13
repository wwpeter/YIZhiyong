//
//  UINavigationBarExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/6.
//

import UIKit

extension Box where Base: UINavigationBar {
    ///  Set Navigation Bar title, title color and font.
    ///
    /// - Parameters:
    ///   - font: title font.
    ///   - color: title text color (default is .black).
    func setTitleFont(_ font: UIFont, color: UIColor = .black) {
        var attrs = [NSAttributedString.Key: Any]()
        attrs[.font] = font
        attrs[.foregroundColor] = color
        base.titleTextAttributes = attrs
    }

    ///  Make navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    func makeTransparent(withTint tint: UIColor = .white) {
        base.isTranslucent = true
        base.backgroundColor = .clear
        base.barTintColor = .clear
        base.setBackgroundImage(UIImage(), for: .default)
        base.tintColor = tint
        base.titleTextAttributes = [.foregroundColor: tint]
        base.shadowImage = UIImage()
    }

    ///  Set navigationBar background and text colors.
    ///
    /// - Parameters:
    ///   - background: background color.
    ///   - text: text color.
    func setColors(background: UIColor, text: UIColor) {
        base.isTranslucent = false
        base.backgroundColor = background
        base.barTintColor = background
        base.setBackgroundImage(UIImage(), for: .default)
        base.tintColor = text
        base.titleTextAttributes = [.foregroundColor: text]
    }
}
