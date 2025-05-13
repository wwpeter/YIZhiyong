//
//  RecordModel.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

struct RecordModel: HandyJSON {

    //展位id
    var boothId = ""
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
