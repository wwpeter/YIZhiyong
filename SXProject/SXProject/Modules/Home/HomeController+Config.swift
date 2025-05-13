//
//  HomeController+Config.swift
//  SXProject
//
//  Created by 王威 on 2025/1/17.
//

import UIKit

extension HomeController {
    func getAllowance() { /// 提交审核
        let vc = AddSubmitVC()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func helpClick() {
        let vc = JKHelpVC()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func guideClick() {
        let vc = CheaterGuideBV()
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func notificate() {
        
    }
    
    ///
    func appPageInfo() {
        
        let param = ["": ""]
        NetworkRequestManager.sharedInstance().requestPath(kAppPageInfo, withParam: param) { [weak self] result in
            printLog(result)
            let dic = JSONHelper.exchangeDic(jsonStr: result)
            if let rate = dic["rate"] as? String, let rate = dic["loanTime"] as? String {
//                self?.topView.setRate(rate: rate, loanTime: rate)
            }
            
       
          
        } failure: { error in
            //            Toast.showInfoMessage("".sx_T)
        }
    }
}
