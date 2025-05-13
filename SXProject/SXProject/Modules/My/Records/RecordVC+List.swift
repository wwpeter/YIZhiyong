//
//  RecordVC+list.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

extension RecordVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: RecordJKCell.cellID()) as?  RecordJKCell {
            
            if let modelT = listData[indexPath.row] as? RecordModel {
                cell.setDataSource(model: modelT)
            }
            
           
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return RecordJKCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
