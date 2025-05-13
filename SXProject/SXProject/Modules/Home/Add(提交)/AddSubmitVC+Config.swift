//
//  AddSubmitVC+Config.swift
//  SXProject
//
//  Created by 王威 on 2025/3/26.
//

import UIKit

extension AddSubmitVC {
    /// 埋点 填写借款信息浏览,
    func burialPoint() {
        let manager = BurialPointManager()
        
        manager.burialPoint(type: BurialPoint.LOAN_PAGE_VIEW)
    }
    
    /// 埋点 提交订单,
    func burialPointT() {
        let manager = BurialPointManager()
        
        manager.burialPoint(type: BurialPoint.POST_ORDER)
    }
    
    ///  首次退出弹窗,
    func burialPointCommon(type: BurialPoint) {
        let manager = BurialPointManager()
        
        manager.burialPoint(type: type)
    }
    // 信息回显
    func userOrderInfo() {
     
        let param = ["": ""]
        NetworkRequestManager.sharedInstance().requestPath(kQueryUserOrderInfo, withParam: param) { [weak self] result in
            printLog(result)
            if let model = JSONHelper.jsonToModel(result, AddModel.self) as? AddModel {
                if !model.idCardNo.isEmpty {
                    self?.addModel = model
                }
               
            }
            if let cityName = self?.addModel.cityName {
                if !cityName.isEmpty {
                    self?.headerView.setCity(city: cityName)
                }
              
            }
            
            self?.dealHXUI()
            
        } failure: { error in
//            Toast.showInfoMessage("".sx_T)
        }
    }
    /// 处理回显
    func dealHXUI() {
        if self.addModel.loan == "I" {
            self.limitIndex = 0
        } else if self.addModel.loan == "J" {
            self.limitIndex = 1
        } else if self.addModel.loan == "K" {
            self.limitIndex = 2
        }
        
        if self.addModel.loanTime == "L" {
            userTimeIndex = 0
        } else if self.addModel.loan == "O" {
            userTimeIndex = 1
        } else if self.addModel.loan == "P" {
            userTimeIndex = 2
        }
        // 资产处理
        if self.addModel.socialSecurity == "Z" {
            self.assetSelArr[0] = true
        }
        if self.addModel.providentFund == "DD" {
            self.assetSelArr[1] = true
        }
        if self.addModel.estate == "HH" {
            self.assetSelArr[2] = true
        }
        if self.addModel.car == "KK" {
            self.assetSelArr[3] = true
        }
        if self.addModel.wldLoan == "SS" {
            self.assetSelArr[4] = true
        }
        if self.addModel.creditCard == "MMM" {
            self.assetSelArr[5] = true
        }
        
        if  self.addModel.personalInsurance == "KKK" {
            self.assetSelArr[6] = true
        }
        if  self.addModel.jdWhite == "OOO" {
            self.assetSelArr[7] = true
        }
        if  self.addModel.aliBei == "RRR" {
            self.assetSelArr[8] = true
        }
        if self.addModel.creditRecord == "YY" {
            self.assetSelArr[9] = true
        }
        if  self.addModel.education == "X" {
            self.assetSelArr[10] = true
        }
        
        var tempBool = false
        assetSelArr.forEach { result in
            if result == true {
                tempBool = true
            }
        }
        
        if !self.addModel.idCardNo.isEmpty {
            self.assetSelArr[11] = !tempBool
        }
       
       
        
        //芝麻分 - 这里可以修改成功 网络数据 OO PP DDD QQ  RR
        if self.addModel.creditScore == "OO" {
            zhimaIndex = 0
        } else if self.addModel.creditScore == "PP" {
            zhimaIndex = 1
        } else if self.addModel.creditScore == "DDD" {
            zhimaIndex = 2
        } else if self.addModel.creditScore == "QQ" {
            zhimaIndex = 3
        } else if self.addModel.creditScore == "RR" {
            zhimaIndex = 4
        }
        ///  /// 职业  A B C BS  CS
        if self.addModel.profession == "A" {
            zhiyeIndex = 0
        } else if self.addModel.profession == "B" {
            zhiyeIndex = 1
        } else if self.addModel.profession == "C" {
            zhiyeIndex = 2
        } else if self.addModel.profession == "BS" {
            zhiyeIndex = 3
        } else if self.addModel.profession == "CS" {
            zhiyeIndex = 4
        }
        self.myTableView.reloadData()
        
        self.headerView.setDataSource(model: self.addModel)
    }

    
    /// 获取填写资料需要的数据
    func getAddDataSource() {
        let param = ["code": "0"]
        NetworkRequestManager.sharedInstance().requestPath(kQueryListByType, withParam: param) { [weak self] result in
            printLog(result)
            
        } failure: { error in
            //            Toast.showInfoMessage("".sx_T)
        }
    }
    
    func getAddDataSourceOne() {
        let param = ["code": "1"]
        NetworkRequestManager.sharedInstance().requestPath(kQueryListByType, withParam: param) { [weak self] result in
            printLog(result)
            
        } failure: { error in
            //            Toast.showInfoMessage("".sx_T)
        }
    }
    
    /// 转义
    func transferMeaning() {
        if limitIndex == 0 {
            self.addModel.loan = "I"
        } else if limitIndex == 1 {
            self.addModel.loan = "J"
        } else if limitIndex == 2 {
            self.addModel.loan = "K"
        }
        
        if userTimeIndex == 0 {
            self.addModel.loanTime = "L"
        } else if userTimeIndex == 1 {
            self.addModel.loanTime = "O"
        } else if userTimeIndex == 2 {
            self.addModel.loanTime = "P"
        }
        
        // 资产处理
        self.assetSelArr.enumerated().map { index, result in
            if index == 0 {
                if result ==  true {//Z  BB 无社保
                    self.addModel.socialSecurity = "Z"
                } else {
                    self.addModel.socialSecurity = "BB"
                }
            } else if index == 1 {/// 公积金DD  FF无
                if result ==  true {
                    self.addModel.providentFund = "DD"
                } else {
                    self.addModel.providentFund = "FF"
                }
            } else if index == 2 {//房产HH(不抵押)  II 无房产 GG(抵押)
                if result ==  true {
                    self.addModel.estate = "HH"
                    self.addModel.estateType = "FFF"
                } else {
                    self.addModel.estate = "II"
                    self.addModel.estateType = ""
                }
            } else if index == 3 {//KK （不抵押） LL 无车 JJ（有车 抵押可以）
                if result ==  true {
                    self.addModel.car = "KK"
                    self.addModel.carType = "HHH"
                } else {
                    self.addModel.car = "LL"
                    self.addModel.carType = ""
                }
            } else if index == 4 {// SS UU (无)  TT(5000以上 不用)
                if result ==  true {
                    self.addModel.wldLoan = "SS"
                } else {
                    self.addModel.wldLoan = "UU"
                }
            } else if index == 5 {
                if result ==  true {//MMM   WW(无信用卡)     NNN
                    self.addModel.creditCard = "MMM"
                } else {
                    self.addModel.creditCard = "WW"
                }
            }  else if index == 6 {// KKK(6月以下)  NN(无)   LLL(>6)
                if result ==  true {
                    self.addModel.personalInsurance = "KKK"
                } else {
                    self.addModel.personalInsurance = "NN"
                }
            } else if index == 7 {//京东白条 OOO(<5000)  QQQ(无)  PPP(>5000)
                if result ==  true {
                    self.addModel.jdWhite = "OOO"
                } else {
                    self.addModel.jdWhite = "QQQ"
                }
            } else if index == 8 {/// 花呗 RRR(<5000) TTT(无) SSS(>5000)
                if result ==  true {
                    self.addModel.aliBei = "RRR"
                } else {
                    self.addModel.aliBei = "TTT"
                }
            } else if index == 9 {/// 信用记录 YY （无逾期） AAA(没有选就是逾期)
          
                if result ==  true {
                    self.addModel.creditRecord = "YY"
                } else {
                    self.addModel.creditRecord = "AAA"
                }
            } else if index == 10 {//文化程度 X(本科)   V(专科一下)
                if result ==  true {
                    self.addModel.education = "X"
                } else {
                    self.addModel.education = "V"
                }
            }
        }
        
        //芝麻分 - 这里可以修改成功 网络数据 OO PP DDD QQ  RR
        if zhimaIndex == 0 {
            self.addModel.creditScore = "OO"
        } else if zhimaIndex == 1 {
            self.addModel.creditScore = "PP"
        } else if zhimaIndex == 2 {
            self.addModel.creditScore = "DDD"
        } else if zhimaIndex == 3 {
            self.addModel.creditScore = "QQ"
        } else if zhimaIndex == 4 {
            self.addModel.creditScore = "RR"
        }
        
        /// 职业  A B C BS  CS
        if zhiyeIndex == 0 {
            self.addModel.profession = "A"
        } else if zhiyeIndex == 1 {
            self.addModel.profession = "B"
        } else if zhiyeIndex == 2 {
            self.addModel.profession = "C"
        } else if zhiyeIndex == 3 {
            self.addModel.profession = "BS"
        } else if zhiyeIndex == 4 {
            self.addModel.profession = "CS"
        }
        if zhiyeIndex < self.condition.count {
            self.addModel.condition = self.condition[zhiyeIndex]
        }
       
    }
    
    /// 校验完整性
    func checkSul() {
        if self.agreement == false {
            Toast.showInfoMessage("请同意协议")
            return
        }
        let name = self.headerView.getName()
        let card = self.headerView.getCard()
        if name.isEmpty {
            Toast.showInfoMessage("请输入姓名")
            return
        }
        if card.isEmpty {
            Toast.showInfoMessage("请输入身份证号")
            return
        }
        self.addModel.name = name
        self.addModel.idCardNo = card
        
        if self.addModel.loan.isEmpty {
            Toast.showInfoMessage("请选择申请额度")
            return
        }
        if self.addModel.loanTime.isEmpty {
            Toast.showInfoMessage("请选择使用时间")
            return
        }
        
        var tempBoolT = false
        self.assetSelArr.forEach { result in
            if result == true {
                tempBoolT = true
            }
        }
        if tempBoolT == false {
            Toast.showInfoMessage("请选择资产信息")
            return
        }
        
        if self.addModel.creditScore.isEmpty {
            Toast.showInfoMessage("请选择芝麻分")
            return
        }
        if self.addModel.profession.isEmpty {
            Toast.showInfoMessage("请选择职业身份")
            return
        }
        checkBlacklist()
    }
    /// 黑名单
    func checkBlacklist() {
        
        let param = ["idCardNo": self.addModel.idCardNo, "phone":UserSingleton.shared.getPhone()]
        NetworkRequestManager.sharedInstance().requestPath(kQueryBlackUserIdCard, withParam: param) { [weak self] result in
            let dic = JSONHelper.exchangeDic(jsonStr: result)
            if let code = dic["code"] as? Int {
                if code == 1 {
                    self?.realName()
                } else {
                    let alertView = AlertViewSystem()
                    
                    alertView.show()
                }
            }
          
            
        } failure: { error in
          
        }
    }
    /// 实名认证
    func realName() {
        
        let param = ["idCardNo": self.addModel.idCardNo, "name":self.addModel.name]
        NetworkRequestManager.sharedInstance().requestPath(kIdCardCredit, withParam: param) { [weak self] result in
            let dic = JSONHelper.exchangeDic(jsonStr: result)
            let userId = dic["userId"]
            
            let vc = UnderReviewVC()
            vc.addModel = self?.addModel ?? AddModel()
            
            self?.navigationController?.pushViewController(vc, animated: true)
            
            self?.submitPOP = true
        } failure: { error in
          
        }
    }
    
    /// 提交资料
    /// 提交信息流程
//    1.判断黑名单，返回//1是正常0是黑名单
//    2.正常用户，去实名认证---到审核等待页面提交信息---等待返回--成功失败
//    3.黑名单用户直接提示窗（通好汇推的黑名单提示窗）
    func submitInfo() {
       
        let jsonDictionary = JSONHelper.modelToDictionary(addModel)
        Toast.showWaiting()
        //kLogin
        NetworkRequestManager.sharedInstance().requestPath(kLoanInformation, withParam: jsonDictionary) { [weak self] result in
//            let dic = JSONHelper.exchangeDic(jsonStr: result)
        
        } failure: { error in
           
            
        }
    }
 
}
