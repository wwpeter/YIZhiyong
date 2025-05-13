//
//  JKHelpVC+List.swift
//  SXProject
//
//  Created by 王威 on 2025/2/14.
//

import UIKit

extension JKHelpVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HelpJkCell.cellID()) as?  HelpJkCell {
            
            let tempArr = sourceData[indexPath.row]
            cell.setTitle(title: tempArr[0], sub: tempArr[1])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return sxDynamic(130)
        }
        return HelpJkCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = UserProtocolVC()
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
