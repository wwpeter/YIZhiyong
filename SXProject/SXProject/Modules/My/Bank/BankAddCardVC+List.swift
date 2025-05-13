//
//  BankAddCardVC+List.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

extension BankAddCardVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: AddCardCell.cellID()) as?  AddCardCell {
            cell.textblock = { [weak self] result in
                if indexPath.row == 0 {
                    self?.cardModel.name = result
                } else if indexPath.row == 1 {
                    self?.cardModel.cardNum = result
                } else if indexPath.row == 2 {
                    self?.cardModel.phone = result
                } else if indexPath.row == 3 {
                    self?.cardModel.bank = result
                }
                
            }
            if indexPath.row == 1 || indexPath.row == 2 {
                cell.exchangeField()
            }
            
            cell.setTitle(title: sourceData[indexPath.row], placeholder: placeholderData[indexPath.row])
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AddCardCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
