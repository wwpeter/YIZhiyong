//
//  UIBarButtonItemExtensions.swift
//  Sleep
//
//  Created by 王威 on 2022/10/19.
//

import Foundation

public extension Box where Base: UIBarButtonItem {
    
    //和H5交互需要的method
    @MainActor static func createBarItem(_ text: String?, _ icon: String?) -> UIButton {
        let settingBtn = UIButton()
        settingBtn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        settingBtn.contentMode = .scaleAspectFit
//        settingBtn.tag = 1000 + index
        
        let rightTitle = text ?? ""
        let rightIcon = icon ?? ""
        if rightTitle.isEmpty {
            if let url = URL(string: icon) {
                settingBtn.kf.setImage(with: url, for: .disabled)
            }
        } else {
            if rightIcon.isEmpty {
                settingBtn.setTitle(text, for: .normal)
                settingBtn.contentMode = .scaleAspectFit
                settingBtn.titleLabel?.font = UIFont.sx.font_t15
                settingBtn.setTitleColor(AssetColors.t666.color, for: .normal)
            } else {
                if let url = URL(string: icon) {
                    settingBtn.kf.setImage(with: url, for: .normal)
                }
            }
        }
        
        return settingBtn
    }
    
    /**
    *  根据图片生成UIBarButtonItem
    *
    * @实际值：
    * @使用场景:创建文字icon
    */
    static func imageItem(imageName:String, target:AnyObject, action:Selector) -> UIBarButtonItem {
        return customItem(title: "", titleColor: UIColor.white, imageName: imageName, target: target, action: action, contentHorizontalAlignment: .center)
    }
    
    /**
    *  根据文字生成UIBarButtonItem
    *
    * @实际值：
    * @使用场景:创建UIBarButtonItem
    */
    static func textItem(title:String, titleColor:UIColor, target:AnyObject, action:Selector) -> UIBarButtonItem {
        return customItem(title: title, titleColor: titleColor, imageName: "", target: target, action: action, contentHorizontalAlignment: .center)
    }
    /**
    *  返回按钮 带箭头的
    *
    * @实际值：
    * @使用场景:
    */
 
    static func backItem(imageName: String, target: AnyObject, action: Selector) -> UIBarButtonItem {
        return customItem(title: "", titleColor: UIColor.white, imageName: imageName, target: target, action: action, contentHorizontalAlignment: .left, isBack: true)
    }
    
    /// 快速初始化一个UIBarButtonItem，内部是按钮
    static func customItem(title:String,
                           titleColor: UIColor,
                           imageName: String,
                           target: AnyObject,
                           action: Selector,
                           contentHorizontalAlignment: UIControl.ContentHorizontalAlignment, isBack: Bool = false) -> UIBarButtonItem {
        let button = UIButton()
        if !title.isEmpty {
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        }
        if !imageName.isEmpty {
            button.setImage(UIImage(named: imageName), for: .normal)
            button.setImage(UIImage(named: imageName), for: .highlighted)
        }
        button.setTitleColor(titleColor, for: .normal)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .highlighted)
        button.setTitleColor(titleColor.withAlphaComponent(0.5), for: .disabled)
        button.addTarget(target, action: action, for: .touchUpInside)
     
        if isBack {
            button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        } else {
            button.sizeToFit()
        }
        button.contentHorizontalAlignment = contentHorizontalAlignment
        return UIBarButtonItem(customView: button)
    }
}
