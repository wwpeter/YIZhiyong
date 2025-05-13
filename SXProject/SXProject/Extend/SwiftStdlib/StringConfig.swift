//
//  StringConfig.swift
//  SXProject
//
//  Created by 王威 on 2024/4/24.
//

import Foundation

extension NSObject {
    ///密码有效性判断
    func isPasswordValid_sx(password: String) -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        return passwordPredicate.evaluate(with: password)
    }
    
    ///判断是不是只有数字
    func isStringOnlyDigits_sx(string: String) -> Bool {
        let digits = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        
        return characterSet.isSubset(of: digits)
    }
    
}
