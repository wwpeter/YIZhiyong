//
//  UIImageExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/6.
//

import UIKit

extension Box where Base: UIImage {
    /// UIImage with rounded corners.
    ///
    /// - Parameters:
    ///   - radius: corner radius (optional), resulting image will be round if unspecified.
    /// - Returns: UIImage with all corners rounded.
    func withRoundedCorners(radius: CGFloat? = nil) -> UIImage? {
        let maxRadius = min(base.size.width, base.size.height) / 2
        let cornerRadius: CGFloat
        if let radius = radius, radius > 0, radius <= maxRadius {
            cornerRadius = radius
        } else {
            cornerRadius = maxRadius
        }

        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)

        let rect = CGRect(origin: .zero, size: base.size)
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).addClip()
        base.draw(in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    /// UIImage filled with color
    ///
    /// - Parameter color: color to fill image with.
    /// - Returns: UIImage filled with given color.
    func filled(withColor color: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(base.size, false, base.scale)
        color.setFill()
        guard let context = UIGraphicsGetCurrentContext() else { return base }

        context.translateBy(x: 0, y: base.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        context.setBlendMode(CGBlendMode.normal)

        let rect = CGRect(x: 0, y: 0, width: base.size.width, height: base.size.height)
        guard let mask = base.cgImage else { return base }
        context.clip(to: rect, mask: mask)
        context.fill(rect)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    static func image(color: UIColor) -> Base {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        color.set()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext() as? Base
        UIGraphicsEndImageContext()
        return image!
    }
    
    /// 纯色图颜色重绘（更改图片颜色）
    /// - Parameter color: 目标颜色
    /// - Returns: 重绘颜色后的Image
    public func imageWithTintColor(_ tintColor : UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(base.size, false, 0.0)
        tintColor.setFill()
        let bounds = CGRect.init(x: 0, y: 0, width: base.size.width, height: base.size.height)
        UIRectFill(bounds)
        base.draw(in: bounds, blendMode: CGBlendMode.destinationIn, alpha: 1.0)
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tintedImage!
    }
    
    /// 创建指定颜色的图像
    static func imageWithColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
