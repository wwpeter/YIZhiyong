//
//  CheaterGuideBV+Config.swift
//  SXProject
//
//  Created by 王威 on 2025/3/27.
//

import UIKit

extension CheaterGuideBV {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TopGuideCell.cellID()) as?  TopGuideCell {
            
            let tempDic = dataDic[indexPath.row]
            cell.setDataSource(dic: tempDic)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return sxDynamic(200)
        } else if indexPath.row == 1 {
            return sxDynamic(200)
        }
        return sxDynamic(110)
    }
}
