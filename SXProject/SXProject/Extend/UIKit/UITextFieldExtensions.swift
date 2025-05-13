//
//  UITextFieldExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/6.
//

import UIKit

extension Box where Base: UITextField {
    /// UITextField text type.
    ///
    /// - emailAddress: UITextField is used to enter email addresses.
    /// - password: UITextField is used to enter passwords.
    /// - generic: UITextField is used to enter generic text.
    enum TextType {
        /// SwifterSwift: UITextField is used to enter email addresses.
        case emailAddress

        /// SwifterSwift: UITextField is used to enter passwords.
        case password

        /// SwifterSwift: UITextField is used to enter generic text.
        case generic
    }
    
    /// Set textField for common text types.
    var textType: TextType {
        get {
            if base.keyboardType == .emailAddress {
                return .emailAddress
            } else if base.isSecureTextEntry {
                return .password
            }
            return .generic
        }
        set {
            switch newValue {
            case .emailAddress:
                base.keyboardType = .emailAddress
                base.autocorrectionType = .no
                base.autocapitalizationType = .none
                base.isSecureTextEntry = false
                base.placeholder = "Email Address"

            case .password:
                base.keyboardType = .asciiCapable
                base.autocorrectionType = .no
                base.autocapitalizationType = .none
                base.isSecureTextEntry = true
                base.placeholder = "Password"

            case .generic:
                base.isSecureTextEntry = false
            }
        }
    }
    /// Set placeholder text color.
    ///
    /// - Parameter color: placeholder text color.
    func setPlaceHolderTextColor(_ color: UIColor) {
        guard let holder = base.placeholder, !holder.isEmpty else { return }
        base.attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }

    ///  Add padding to the left of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the left of the textfield rect.
    func addPaddingLeft(_ padding: CGFloat) {
        base.leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: base.frame.height))
        base.leftViewMode = .always
    }

    /// Add padding to the right of the textfield rect.
    ///
    /// - Parameter padding: amount of padding to apply to the right of the textfield rect.
    func addPaddingRight(_ padding: CGFloat) {
        base.rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: base.frame.height))
        base.rightViewMode = .always
    }

    /// Add padding to the left of the textfield rect.
    ///
    /// - Parameters:
    ///   - image: left image.
    ///   - padding: amount of padding between icon and the left of textfield.
    func addPaddingLeftIcon(_ image: UIImage, padding: CGFloat) {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        base.leftView = iconView
        base.leftViewMode = .always
    }

    /// Add padding to the right of the textfield rect.
    ///
    /// - Parameters:
    ///   - image: right image.
    ///   - padding: amount of padding between icon and the right of textfield.
    func addPaddingRightIcon(_ image: UIImage, padding: CGFloat) {
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        base.rightView = iconView
        base.rightViewMode = .always
    }
}
