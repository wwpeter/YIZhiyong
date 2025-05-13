//
//  CreateBaseView.swift
//  Sleep
//
//  Created by 王威 on 2022/12/26.
//
// 控件快速创建的 公共函数

import UIKit

public class CreateBaseView: UIView {
 
    /**
     * 创建UIimageView
     *
     * @实际值：
     * @使用场景:创建IMG
     */
    static public func makeIMG(_ image: String, _ modeT: ContentMode) -> UIImageView {
        let imageView: UIImageView = UIImageView()
        imageView.image = UIImage(named: image)
        imageView.contentMode = modeT
        
        return imageView
    }
    
    /**
     * 建UIimageView 带圆角
     *
     * @实际值：
     * @使用场景:建UIimageView 带圆角
     */
   static public  func makeIMG(_ image: String, _ mode: ContentMode, _ cornerRadius: CGFloat) -> UIImageView {
        let imageView: UIImageView = UIImageView().then {
            $0.image = UIImage.init(named: image)
            $0.contentMode = mode
            $0.layer.cornerRadius = cornerRadius
        }
        
        return imageView
    }
    
    /**
     * 创建UIbutton
     *
     * @实际值：
     * @使用场景: 创建UIbutton
     */
    static public func makeBut(_ title: String, _ bgColor: UIColor, _ titleColor: UIColor, _ font: UIFont) -> UIButton {
        let button: UIButton = UIButton(type: .custom).then {
            $0.setTitle(title, for: .normal)
            $0.setTitleColor(titleColor, for: .normal)
            $0.titleLabel?.font = font
            $0.backgroundColor = bgColor
        }
        
        return button
    }
    
    /**
     * 创建UIbutton
     *
     * @实际值：
     * @使用场景: 创建UIbutton
     */
    static public func makeBut(_ imgStr: String) -> UIButton {
        let button: UIButton = UIButton(type: .custom).then {
            $0.setImage(UIImage.init(named: imgStr), for: .normal)
        }
        
        return button
    }
    
    /**
     * 快速创建UILabel
     *
     * @实际值：
     * @使用场景: 创建UILabel
     */
    static public func makeLabel(_ title: String, _ font: UIFont, _ titleColor: UIColor, _ alignment: NSTextAlignment, _ numberOfLines: NSInteger) -> UILabel {
        let label: UILabel = UILabel().then {
            $0.font = font
            $0.text = title
            $0.textColor = titleColor
            $0.textAlignment = alignment
            $0.numberOfLines = numberOfLines
        }
        return label
    }
}
