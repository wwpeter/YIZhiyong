//
//  BindingExtensions.swift
//  DigitalSleep
//
//  Created by sx on 2021/11/25.
//

import Foundation
//import RxSwift
import UIKit

//extension Reactive where Base: UILabel {
//    // 验证提示文字
//    var validationResult: Binder<ValidationResult> {
//        return Binder(base) { label, result in
//            label.textColor = result.color
//            label.text = result.description
//        }
//    }
//}
//
//extension Reactive where Base: UIButton {
//    
//    // 登录按钮是否可用
//    var available: Binder<Bool> {
//        return Binder(base) { button, result in
//            button.isEnabled = result
//            button.backgroundColor = result ? AssetColors.b9D2872.color : AssetColors.bacafb9.color
//        }
//    }
//    
//    // 验证码状态
//    var verificationCodeStatus: Binder<ValidationBtnState> {
//        return Binder(base) { button, btnState in
//            let strleNormal = Style {
//                $0.color = AssetColors.t777.color
//                $0.font = UIFont.sx.font_t16
//            }
//            let strleSpecial = Style {
//                $0.color = AssetColors.t9D2872.color
//                $0.font = UIFont.sx.font_t16
//            }
//            switch btnState {
//            case .normal:
//                button.isEnabled = true
//                button.setAttributedTitle("获取验证码".set(style: strleSpecial), for: .normal)
//            case .secondReading(let content):
//                button.isEnabled = false
//                button.setAttributedTitle("已发送验证码 ".set(style: strleNormal) + (content + "秒").set(style: strleSpecial), for: .normal)
//            }
//        }
//    }
//}
