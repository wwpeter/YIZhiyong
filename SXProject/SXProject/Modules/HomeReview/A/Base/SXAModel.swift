//
//  SXAModel.swift
//  SXProject
//
//  Created by Felix on 2025/5/16.
//

import Foundation

/// 还款明细结构体
struct SXALoadPaymentDetailModel {
    let month: Int       // 第几个月
    let principal: Double // 本月还本金
    let interest: Double  // 本月还利息
    let remaining: Double // 剩余本金
}


class SXAProudectExplainModel {
    var title: String = ""
    var decrilbelText: String = ""
}


struct SXACompanyModel: HandyJSON {

    var id = ""
    var name = ""    
}
