//
//  enums.swift
//  Sleep
//
//  Created by slan-ww on 2023/2/8.
//

import Foundation

enum Gender: Int, Codable {
    case unknown
    case man
    case women
    
    var name: String {
        switch self {
        case .unknown:
            return "未知"
        case .man:
            return "男"
        case .women:
            return "女"
        }
    }
}

enum Judge: Int, Codable {
    case zFalse
    case zTrue
    
    var value: Bool {
        switch self {
        case .zTrue:
            return true
        case .zFalse:
            return false
        }
    }
}

enum TreatmentEffect: String, Codable {
    case none = ""
    case nice = "优"
    case good = "良"
    case poor = "差"
}
