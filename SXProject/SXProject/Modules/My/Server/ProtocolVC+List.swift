//
//  ProtocolVC+List.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

extension ProtocolVC {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         4
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if let cell = tableView.dequeueReusableCell(withIdentifier: ProtocolCell.cellID()) as?  ProtocolCell {
             
             cell.setTitle(title: sourceData[indexPath.row], icon: "")
             
             return cell
         }
         
         return UITableViewCell()
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return ProtocolCell.cellHeight()
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         var urlT = ""
         if indexPath.row == 0 {
//             let vc = UserProtocolVC()
//             
//             self.navigationController?.pushViewController(vc, animated: true)
             urlT = String.init(format: "%@%@", kWebUrlBase, kUserAgreement)
         } else if indexPath.row == 1 {
             urlT = String.init(format: "%@%@", kWebUrlBase, kPrivacyAgreement)
         } else if indexPath.row == 2 {
             urlT = String.init(format: "%@%@", kWebUrlBase, kAgreementShare)
         } else if indexPath.row == 3 {
             urlT = String.init(format: "%@%@", kWebUrlBase, kSignoutAgreement)
         }
         
         let dsweb = DsWebController()
    
         dsweb.url = urlT
         self.navigationController?.pushViewController(dsweb, animated: true)
     }
}
