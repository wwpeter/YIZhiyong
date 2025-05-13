//
//  General.swift
//  Sleep
//
//  Created by slan-ww on 2023/2/14.
//

import Foundation

struct General {
    
    static func getChartHeight(maxHeight: Double, intervalCount: Double) -> Double {
            
        let arrayStr = "\(maxHeight)".components(separatedBy: ".")
        
        var y = 0
        
        if let tempStr = arrayStr.first {
            y = tempStr.count - 1
        }
        
        if y == 0 {
            return intervalCount * 3.0
        }
        
        let h = intervalCount * pow(10.0, Double(y - 1))
        
        var height = 0.0
    markTab: for index in 1... {
            height = h * Double(index)
            if height > maxHeight { break markTab }
        }
        return height
    }
}
