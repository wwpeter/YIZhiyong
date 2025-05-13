//
//  SettingVC+Config.swift
//  SXProject
//
//  Created by 王威 on 2025/3/28.
//

import UIKit

extension SettingVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.cellID()) as?  SettingCell {
            if indexPath.row == 1 {
                cell.hiddenIcon(hidden: true)
            } else {
                cell.hiddenIcon(hidden: false)
            }
            
            let dic = dataSource[indexPath.row]
            cell.setDataSource(dic: dic)
            
            return cell
        }
     
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            ZlAlertTool.showSystemAlert(title: "注销账号".sx_T, actionTitles: ["确定".sx_T], cancelTitle: "取消".sx_T) { index in
                if index == 0 {
                  
                } else if index == 1 {
                    self.cancelAccount()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        SettingCell.cellHeight()
    }
    
    /// 注销账号
    func cancelAccount() {
        let token = getUserDefault(key: "access_token")
        let param = ["token": token]
        NetworkRequestManager.sharedInstance().requestPath(UserOrderInfo, withParam: param) { [weak self] result in
            printLog(result)
            self?.goLoginBase()
        } failure: { error in
//            Toast.showInfoMessage("".sx_T)
        }
    }
    
    /// 退出登录/hht/h5/account/
    func logout() {
        let token = getUserDefault(key: "access_token")
        let param = ["token": token]
        NetworkRequestManager.sharedInstance().requestPath(kLogout, withParam: param) { [weak self] result in
            printLog(result)
            self?.goLoginBase()
           
        } failure: { error in
//            Toast.showInfoMessage("".sx_T)
        }
    }
}
