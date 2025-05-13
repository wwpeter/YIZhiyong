//
//  LoginVC+Config.swift
//  SXProject
//
//  Created by 王威 on 2025/3/26.
//

import UIKit

extension LoginVC {
    /// 获取验证码
    func getPhoneCode() {
        if let telephone = self.textField.text {
            if telephone.isEmpty {
                Toast.showInfoMessage("请输入手机号")
                return
            }
            let param = ["telephone": telephone, "appCode":"HHT","channelCode":"ios"]
            NetworkRequestManager.sharedInstance().requestPath(kSendValidateCode, withParam: param) { [weak self] result in
                printLog(result)
                
                
                let dic = JSONHelper.exchangeDic(jsonStr: result)
              
               
                let vc = SendCodeVC()
                vc.telephone = self?.textField.text ?? ""
                
                self?.navigationController?.pushViewController(vc, animated: true)
                
            } failure: { error in
                //            Toast.showInfoMessage("".sx_T)
            }
        }
    }
    
    // MARK: - Delegate 键盘
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        // 获取输入框的最新文本
        let updatedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        let textLength = text.count + string.count - range.length
        
        return textLength <= 11
        
    
    }
}
