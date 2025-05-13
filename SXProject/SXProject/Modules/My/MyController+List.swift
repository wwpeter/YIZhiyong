//
//  MyController+List.swift
//  SXProject
//
//  Created by 王威 on 2024/5/15.
//

import UIKit

extension MyController {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: MyItemCell.cellID()) as?  MyItemCell {
            
            cell.setTitle(title: sourceData[indexPath.row], icon: sourceImg[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MyItemCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            let vc = BankListVC()
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.row == 1) {
            let vc = ProtocolVC()
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else if (indexPath.row == 2) {
            ZlAlertTool.showSystemAlert(title: "联系客服", message: "0571-22930325", actionTitles: ["确定"], cancelTitle: "取消") { index in
                if index == 0 {
                   
                } else if index == 1 {
                    self.callPhoneNumber("0571-22930325")
                }
            }
        } else if (indexPath.row == 3) {
            let vc = SettingVC()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func callPhoneNumber(_ number: String) {
        // 清理号码中的非法字符（如空格、括号）
        let cleanedNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        // 构造拨号 URL
        guard let url = URL(string: "telprompt://\(cleanedNumber)") else {
            print("无效的电话号码")
            return
        }
        
        // 检查设备是否支持拨号
        guard UIApplication.shared.canOpenURL(url) else {
            print("设备不支持拨号功能")
            return
        }
        
        // 跳转到拨号界面
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
