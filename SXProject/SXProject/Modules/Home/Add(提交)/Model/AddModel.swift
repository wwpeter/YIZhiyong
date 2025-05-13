//
//  AddModel.swift
//  SXProject
//
//  Created by 王威 on 2025/4/8.
//

import UIKit

struct AddModel: HandyJSON {
    /// 身份证号
    var idCardNo = ""
    /// 用户姓名
    var name = ""
    /// 城市
    var city = 330100
    var cityName = ""
    
    ///借款金额(借多少) I  J  K
    var loan = ""
    /// 借款时间(借多久) L  O  P
    var loanTime = ""
    
    
    /// 社保 Z  BB 无社保
    var socialSecurity = ""
    /// 公积金DD  FF无
    var providentFund = ""
    /// 房产HH(不抵押)  II 无房产 GG(抵押)
    var estate = ""
    /// 房产类型EEE 商品房
    var estateType = "FFF"
    
    /// 车产 KK （不抵押） LL 无车 JJ（有车 抵押可以）
    var car = ""
    /// 车产类型GGG 全款车  HHH贷款车
    var carType = "HHH"
    /// 微粒贷借款额度 SS UU (无)  TT(5000以上 不用)
    var wldLoan = ""
    /// 信用卡MMM   WW(无信用卡)     NNN
    var creditCard = ""
    
    /// 个人保险 KKK(6月以下)  NN(无)   LLL(>6)
    var personalInsurance = ""
    /// 京东白条 OOO(<5000)  QQQ(无)  PPP(>5000)
    var jdWhite = ""
    /// 花呗 RRR(<5000) TTT(无) SSS(>5000)
    var aliBei = ""
    
    /// 信用记录 YY （无逾期） AAA(没有选就是逾期)
    var creditRecord = ""
    /// 文化程度 X(本科)   V(专科一下)
    var education = ""
    
    ///芝麻分 OO PP DDD QQ  RR
    var creditScore = ""
    
    /// 职业身份 A B C BS  CS
    var profession = ""
    //二级
    var condition = ""
}


struct Profession: HandyJSON {
    var name = ""
    var condition = ""
    var code = ""
}

struct CreditScore: HandyJSON {
    var code = ""
    var id = ""
    var createTime = ""
    var type = ""
    var name = ""
    var updateTime = ""
}

