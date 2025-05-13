//
//  UIViewExtensions.swift
//  DigitalSleep
//
//  Created by ww on 2021/12/6.
//

import UIKit

extension Box where Base: UIView {
    /// Take screenshot of view (if applicable).
    var screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(base.layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        base.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    /// Get view's parent view controller
    var parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = base
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
    
    ///设置部分或所有角的视图半径。
    ///
    /// -Parameters:
    /// - corners:要更改的角的数组(例如:[.])bottomLeft .topRight])。
    /// - radius:所选角的半径。
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: base.bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        base.layer.mask = shape
    }
    
    ///淡出视野。
    ///
    /// -Parameters:
    /// -duration:动画持续时间，单位为秒(默认为1秒)。
    /// -completion:可选的完成处理程序，与动画完成一起运行(默认为nil)。
    func fadeIn(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if base.isHidden {
            base.isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            base.alpha = 1
        }, completion: completion)
    }

    ///淡出视图。
    ///
    ///  -Parameters:
    ///  -duration:动画持续时间，单位为秒(默认为1秒)。
    ///  -completion:可选的完成处理程序，与动画完成一起运行(默认为nil)。
    func fadeOut(duration: TimeInterval = 1, completion: ((Bool) -> Void)? = nil) {
        if base.isHidden {
            base.isHidden = false
        }
        UIView.animate(withDuration: duration, animations: {
            base.alpha = 0
        }, completion: completion)
    }
    
    /// 渐变色
    ///
    ///  -Parameters:
    ///  -startColor:开始颜色
    ///  -endColor:结束颜色
    ///  -startPoint:-endPoint 起始点、结束点。
    public func gradientColor(_ startColor: UIColor, _ endColor: UIColor, _ startPoint: CGPoint, _ endPoint: CGPoint) {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = base.bounds
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        base.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    ///添加部分圆角（自动布局情况下，要在布局后使用）
    ///
    ///  -Parameters:
    ///  -conrners:设置圆角left right--等等
    ///
    ///  -radius:-圆角大小
     func addCorner(conrners: UIRectCorner, radius: CGFloat) {
         base.layoutIfNeeded()
         let maskPath = UIBezierPath(roundedRect: base.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
         let maskLayer = CAShapeLayer()
         maskLayer.frame = base.bounds
         maskLayer.path = maskPath.cgPath
         base.layer.mask = maskLayer
     }
    
    public var x: CGFloat {
        get {
            return base.frame.origin.x
        }
        set(newValue) {
            var frame = base.frame
            frame.origin.x = newValue
            base.frame = frame
        }
    }
    
    public var y: CGFloat {
        get {
            return base.frame.origin.y
        }
        set(newValue) {
            var frame = base.frame
            frame.origin.y = newValue
            base.frame = frame
        }
    }
    
    public var width: CGFloat {
        get {
            return base.frame.size.width
        }
        set(newValue) {
            var frame = base.frame
            frame.size.width = newValue
            base.frame = frame
        }
    }
    
    public var height: CGFloat {
        get {
            return base.frame.size.height
        }
        set(newValue) {
            var frame = base.frame
            frame.size.height = newValue
            base.frame = frame
        }
    }
    
    public var centerX: CGFloat {
        get {
            return base.center.x
        }
        set(newValue) {
            var center = base.center
            center.x = newValue
            base.center = center
        }
    }
    
    public var centerY: CGFloat {
        get {
            return base.center.y
        }
        set(newValue) {
            var center = base.center
            center.y = newValue
            base.center = center
        }
    }
    
    public var maxX: CGFloat {
        get {
            return base.frame.maxX
        }
        set(newValue) {
            printLog(newValue)
        }
    }
    
    public var maxY: CGFloat {
        get {
            return base.frame.maxY
        }
        set(newValue) {
            printLog(newValue)
        }
    }
    
    public var midX: CGFloat {
        get {
            return base.frame.midX
        }
        set(newValue) {
            printLog(newValue)
        }
    }
    
    public var midY: CGFloat {
        get {
            return base.frame.midY
        }
        set(newValue) {
            printLog(newValue)
        }
    }
    
    public var size: CGSize {
        get {
            return base.frame.size
        }
        set(newValue) {
            var frame = base.frame
            frame.size = newValue
            base.frame = frame
        }
    }
    
    public var origin: CGPoint {
        get {
            return base.frame.origin
        }
        set(newValue) {
            var frame = base.frame
            frame.origin = newValue
            base.frame = frame
        }
    }
    
    public var left: CGFloat {
        get {
            return base.frame.origin.x
        }
        set(newValue) {
            var frame = base.frame
            frame.origin.x = newValue
            base.frame = frame
        }
    }
    
    public var top: CGFloat {
        get {
            return base.frame.origin.y
        }
        set(newValue) {
            var frame = base.frame
            frame.origin.y = newValue
            base.frame = frame
        }
    }
    
    public var right: CGFloat {
        get {
            return base.frame.origin.x + base.frame.size.width
        }
        set(newValue) {
            var frame = base.frame
            frame.origin.x = newValue - frame.size.width
            base.frame = frame
        }
    }
    
    public var bottom: CGFloat {
        get {
            return base.frame.origin.y + base.frame.size.height
        }
        set(newValue) {
            var frame = base.frame
            frame.origin.y = newValue - frame.size.height
            base.frame = frame
        }
    }
}

extension UIView {

    @IBInspectable var xCornerRadius: CGFloat {
        set { layer.cornerRadius = newValue }
        get { layer.cornerRadius }
    }
    
    @IBInspectable var xBorderWidth: CGFloat {
        set { layer.borderWidth = newValue }
        get { layer.borderWidth }
    }
    
    @IBInspectable var xBorderColor: UIColor? {
        set { layer.borderColor = newValue?.cgColor }
        get { UIColor(cgColor: self.layer.borderColor!) }
    }
}
