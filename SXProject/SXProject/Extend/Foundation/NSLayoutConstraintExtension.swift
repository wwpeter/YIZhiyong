//
//  NSLayoutConstraintExtension.swift
//  Sleep
//
//  Created by zyz on 2022/12/19.
//

import Foundation

extension NSLayoutConstraint {
     // 扩展等比属性
    @IBInspectable
    var adapterScreen: Bool {
        set {
            self.constant = CGFloat(sxDynamic(self.constant))
        }
        get { true }
    }
}
