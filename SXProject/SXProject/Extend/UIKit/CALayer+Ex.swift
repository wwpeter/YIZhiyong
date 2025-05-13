//
//  CALayer+Ex.swift
//  Sleep
//
//  Created by 王威 on 2023/2/10.
//

import UIKit

extension CALayer {
    
    var zlWidth: CGFloat {
        get {
            return self.frame.width
        }
        
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    
    var zlHeight: CGFloat {
        get {
            return self.frame.height
        }
        
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    
    var zlx: CGFloat {
        get {
            return self.frame.origin.x
        }
        
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var zly: CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    
    var zlSize: CGSize {
        get {
            return self.frame.size
        }
        
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    
    /// 删除所有子图层
    func zlRemoveAllSublayer() {
        if let sublayers = self.sublayers {
            
            for sublayer in sublayers {
                sublayer.removeFromSuperlayer()
            }
        }
    }
}
