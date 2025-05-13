//
//  UIButtonEx.swift
//  SXProject
//
//  Created by 王威 on 2024/3/12.
//

import UIKit

enum LCButtonEdgeInsetsStyle {
    case top
    case left
    case bottom
    case right
}


extension UIButton {
    func layoutButton(with style: LCButtonEdgeInsetsStyle, imageTitleSpace space: CGFloat) {
        let imageWidth = self.imageView?.image?.size.width ?? 0
        let imageHeight = self.imageView?.image?.size.height ?? 0
        
        var labelWidth: CGFloat = 0
        var labelHeight: CGFloat = 0
        if #available(iOS 8.0, *) {
            labelWidth = self.titleLabel?.intrinsicContentSize.width ?? 0
            labelHeight = self.titleLabel?.intrinsicContentSize.height ?? 0
        } else {
            labelWidth = self.titleLabel?.frame.size.width ?? 0
            labelHeight = self.titleLabel?.frame.size.height ?? 0
        }
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        switch style {
        case .top:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space/2, left: -labelWidth / 2, bottom: 0, right: -labelWidth - sxDynamic(20))
            if kSizeScreenWidth == 393.0 {
                imageEdgeInsets = UIEdgeInsets(top: -labelHeight - space/2, left: -labelWidth / 2, bottom: 0, right: -labelWidth)
            }
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth, bottom: -imageHeight - space/2, right: 0)
        case .left:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2, bottom: 0, right: space/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2, bottom: 0, right: -space/2)
        case .bottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight - space/2 , right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight - space/2, left: -imageWidth, bottom: 0, right: 0)
        case .right:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth + space/2, bottom: 0, right: -labelWidth - space/2)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space/2, bottom: 0, right: imageWidth + space/2)
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}
