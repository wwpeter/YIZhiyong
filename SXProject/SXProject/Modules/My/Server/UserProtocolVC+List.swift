//
//  UserProtocolVC+List.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

extension UserProtocolVC {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         2
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if indexPath.row == 1 {
             if let cell = tableView.dequeueReusableCell(withIdentifier: UserProtocolCell.cellID()) as?  UserProtocolCell {
                 
                 return cell
             }
         }
         
         if let cell = tableView.dequeueReusableCell(withIdentifier: ProtocolCell.cellID()) as?  ProtocolCell {
             
             cell.setTitle(title: "注销账号", icon: "")
             
             return cell
         }
         
         return UITableViewCell()
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return ProtocolCell.cellHeight()
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
     }
}
