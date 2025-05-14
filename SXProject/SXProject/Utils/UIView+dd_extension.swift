//
//  UIView+extension.swift
//  FFToolModule
//
//  Created by 郑强飞 on 2017/4/19.
//  Copyright © 2017年 郑强飞. All rights reserved.
//

import Foundation
import UIKit
import CoreFoundation

public extension UIView {
    
    func setCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setCorner(_ radius: CGFloat,_ boardColor:UIColor = .clear, _ borderWidth:CGFloat = 0.5) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = boardColor.cgColor
    }
    
    
    func setCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIWindow {
    
  class func getKeyWindow()->UIWindow? {
        for window in UIApplication.shared.windows {
            if window.isKeyWindow {
                return window
            }
        }
        return nil
    }
}

extension UIView {
    // .x
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var rect = self.frame
            rect.origin.x = newValue
            self.frame = rect
        }
    }
    
    // .y
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    // .maxX
    public var maxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    // .maxY
    public var maxY: CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    // .centerX
    public var centerX: CGFloat {
        get {
            return self.center.x
        }
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
    }
    
    // .centerY
    public var centerY: CGFloat {
        get {
            return self.center.y
        }
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
    }
    
    // .width
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set {
            var rect = self.frame
            rect.size.width = newValue
            self.frame = rect
        }
    }
    
    // .height
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set {
            var rect = self.frame
            rect.size.height = newValue
            self.frame = rect
        }
    }
    public var bottom: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        set {
            var rect = self.frame
            rect.origin.y = newValue - self.frame.size.height
            self.frame = rect
        }
    }
    
    public var top: CGFloat {
        get {
            return self.frame.origin.y
        }
        set {
            var rect = self.frame
            rect.origin.y = newValue
            self.frame = rect
        }
    }
    
    public var right: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set {
            let delta = newValue - (self.frame.origin.x + self.frame.size.width);
            var newframe = self.frame;
            newframe.origin.x += delta ;
            self.frame = newframe;
        }
    }
}


extension Double {
    
    // MARK: - 用法 let myDouble = 1.234567  println(myDouble.format(".2") .2代表留2位小数点
    /**用法 let myDouble = 1.234567  println(myDouble.format(".2") .2代表留2位小数点*/
    public func format(_ f: String) -> String {
        return NSString(format: "%\(f)f" as NSString, self) as String
    }
    
    //MARK:金额格式化 12.00
    /**金额格式化 12.00*/
    public func toRMBBalanceFormat() -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .currency
        nf.currencySymbol = "￥"
        return nf.string(from: NSNumber(value: self))!
    }
    
    //MARK:金额格式化
    /**金额格式化*/
    public func toBalanceFormat() -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        return nf.string(from: NSNumber(value: self))!
    }
    
    //MARK:金额格式化
    /**金额格式化*/
    public func toIntFormat() -> String {
        return String(format: "%.0f",self)
        
    }
    
}
