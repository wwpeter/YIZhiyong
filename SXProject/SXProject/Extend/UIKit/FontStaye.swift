//
//  FontStaye.swift
//  Sleep
//
//  Created by 王威 on 2023/2/10.
//

import UIKit
import SwiftRichString

extension Box where Base: UIView {
    ///
    /// 属性字符串全局扩展
    ///
    func getStale(font: CGFloat, color: UIColor) -> Style {
         let style = Style {
             $0.font = SystemFonts.PingFangSC_Medium.font(size: font) // just pass a string, one of the SystemFonts or an UIFont
             $0.color = AssetColors.t333.color // you can use UIColor or HEX string!
             $0.underline = (.patternDot, color)
             $0.alignment = .center
         }
         return style
     }
}

extension UIView {
    ///
    /// 属性字符串全局扩展
    ///
    func getStale(font: CGFloat, color: UIColor) -> Style {
         let style = Style {
             $0.font = SystemFonts.PingFangSC_Medium.font(size: font) // just pass a string, one of the SystemFonts or an UIFont
             $0.color = AssetColors.t333.color // you can use UIColor or HEX string!
             $0.underline = (.patternDot, color)
             $0.alignment = .center
         }
         return style
     }
}
