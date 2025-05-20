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

class SXABannerModel {
//    5苏宁微商贷2金城-金企贷4浦发银行-浦金贷
    var img: String = ""
    var name: String = ""
    var productId = ""
}



struct SXACompanyModel: HandyJSON {
    var id = ""
    var name = ""
    var url = ""
    var productNum = 0 //可贷产品
    var loanAmount = ""//预估额度
    var rate = "" //参考年息
    var list = [SXACompanyProductModel]()
}

struct SXACompanyProductModel: HandyJSON {

    var productId = ""
    var repayType = ""
    var access = ""
    var productName = ""
    var url = ""
    var loanAmount = ""
    var credit = ""
    var loanTime = ""
    var forbidden = ""
    var rate = ""
    var status = "00" //00 上架 其他下架
    var require = ""
    var collect = false
}


struct SXALoanHistoryModel: HandyJSON {

    var productName = ""
    /// 可贷金额
    var loanAmount = ""
    ///logo
    var logo = ""
    ///机构名称
    var name = ""
    ///订单id
    var orderId = ""
    ///利率
    var rate = ""
    /// 投递状态 UNCONFIRMED:未确认 PENDING：审核中
    var status = ""
    /// 期限
    var loanTime = ""
    ///创建时间
    var createTime = ""

}
