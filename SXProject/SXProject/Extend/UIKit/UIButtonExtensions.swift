//
//  UIButtonExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/6.
//

import UIKit

extension Box where Base == UIButton {
    var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }

    ///  Set image for all states.
    ///
    /// - Parameter image: UIImage.
    func setImageForAllStates(_ image: UIImage) {
        states.forEach { base.setImage(image, for: $0) }
    }

    ///  Set title color for all states.
    ///
    /// - Parameter color: UIColor.
    func setTitleColorForAllStates(_ color: UIColor) {
        states.forEach { base.setTitleColor(color, for: $0) }
    }

    ///  Set title for all states.
    ///
    /// - Parameter title: title string.
    func setTitleForAllStates(_ title: String) {
        states.forEach { base.setTitle(title, for: $0) }
    }

    ///  Center align title text and image.
    /// - Parameters:
    ///   - imageAboveText: set true to make image above title text, default is false, image on left of text.
    ///   - spacing: spacing between title text and image.
    func centerTextAndImage(spacing: CGFloat, imageAboveText: Bool = false) {
        if imageAboveText {
            // https://stackoverflow.com/questions/2451223/#7199529
            guard
                let imageSize = base.imageView?.image?.size,
                let text = base.titleLabel?.text,
                let font = base.titleLabel?.font else { return }

            let titleSize = text.size(withAttributes: [.font: font])

            let titleOffset = -(imageSize.height + spacing)
            base.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: titleOffset, right: 0.0)

            let imageOffset = -(titleSize.height + spacing)
            base.imageEdgeInsets = UIEdgeInsets(top: imageOffset, left: 0.0, bottom: 0.0, right: -titleSize.width)

            let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
            base.contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
        } else {
            let insetAmount = spacing / 2
            base.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            base.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            base.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }
    
    /// 调整按钮中图片和文字的相对位置
    /// - Parameters:
    ///   - anImage: 按钮图片
    ///   - title: 按钮标题
    ///   - titlePosition: .top:上图下文；left:左图右文 .bottom: 上文下图.right: 左文右图
    ///   - additionalSpacing: 图片和文字间距，仅在left和right 有效
    ///   - state: 按钮状态
    
    func adjustLabelAndImagePosition(image anImage: UIImage?, title: String,
                   titlePosition: UIView.ContentMode, additionalSpacing: CGFloat, state: UIControl.State) {
        
//        base.imageView?.backgroundColor = UIColor.gray
        base.imageView?.contentMode = .center
        base.setImage(anImage, for: state)
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
//        base.titleLabel?.backgroundColor = UIColor.red
        base.titleLabel?.contentMode = .center
        base.setTitle(title, for: state)
    }
    
    private func positionLabelRespectToImage(title: String, position: UIView.ContentMode, spacing: CGFloat) {
        var imageSize : CGSize = CGSize(width: 0, height: 0)
        var titleSize: CGSize = CGSize(width: 0, height: 0)
        var titleInsets: UIEdgeInsets = base.titleEdgeInsets
        var imageInsets: UIEdgeInsets = base.imageEdgeInsets
        let localSpace = spacing / 2.0
        
        if let localImageSize = base.imageView?.bounds.size {
            imageSize = localImageSize
        }
        if let localTitleSize = base.titleLabel?.bounds.size {
            titleSize = localTitleSize
        }
        switch position {
            //左图片右边文字
        case .left:
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: localSpace)
            titleInsets = UIEdgeInsets(top: 0, left: localSpace, bottom: 0, right: 0)
            //左文字右图片
        case .right:
            imageInsets = UIEdgeInsets(top: 0, left: titleSize.width + localSpace, bottom: 0, right: -(titleSize.width + localSpace))
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width + localSpace), bottom: 0, right: imageSize.width + localSpace)
            //上文下图
        case .bottom:
            titleInsets = UIEdgeInsets(top: -titleSize.height / 2, left: -(imageSize.width / 2), bottom: titleSize.height / 2, right:imageSize.width / 2)
            imageInsets = UIEdgeInsets(top: imageSize.height / 2, left: titleSize.width / 2.0, bottom: -imageSize.height / 2, right: -titleSize.width / 2.0 )
        //上图下字
        case .top:
            
            imageInsets = UIEdgeInsets(top: -imageSize.height / 2.0, left: titleSize.width / 2.0, bottom: imageSize.height / 2.0, right: -titleSize.width / 2.0)
            titleInsets = UIEdgeInsets(top:titleSize.height / 2.0,
                                        left: -imageSize.width / 2.0, bottom: -titleSize.height / 2.0, right: imageSize.width / 2.0)
        default:
            break
        }
        
        base.titleEdgeInsets = titleInsets
        base.imageEdgeInsets = imageInsets
    }
}
