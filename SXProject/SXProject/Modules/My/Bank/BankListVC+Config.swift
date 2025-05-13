//
//  BankListVC+Config.swift
//  SXProject
//
//  Created by 王威 on 2025/3/28.
//

import UIKit

extension BankListVC {
    /// 获取银行卡列表
    func getBankList() {
        let userId = UserSingleton.shared.getUserId()
        let param = ["userId": userId]
        Toast.showWaiting()
        NetworkRequestManager.sharedInstance().requestPath(kQueryBankCardList, withParam: param) { [weak self] result in
            printLog(result)
            self?.sourceData.removeAll()
            if let arr = JSONHelper.jsonArrayToModel(result, BankCardModel.self) {
                if arr.count > 0 {
                    self?.dealEmpty(empty: false)
                } else {
                    self?.dealEmpty(empty: true)
                }
                self?.sourceData.append(contentsOf: arr)
            }
            
            self?.myTableView.reloadData()
           
        } failure: { error in
//            Toast.showInfoMessage("".sx_T)
        }
    }
    
    /// 删除
    func delBankitem(id: String) {
    
        let param = ["id": id]
        NetworkRequestManager.sharedInstance().requestPath(kDdeleteCard, withParam: param) { [weak self] result in
            printLog(result)
            
            self?.getBankList()
           
        } failure: { error in
//            Toast.showInfoMessage("".sx_T)
        }
    }
}
