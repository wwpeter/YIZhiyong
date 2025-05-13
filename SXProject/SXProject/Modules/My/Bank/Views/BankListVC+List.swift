//
//  BankListVC+List.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

extension BankListVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sourceData.count > 0 {
            return sourceData.count + 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if sourceData.count > 0 {
            if indexPath.row == sourceData.count {
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: AddCardListCell.cellID()) as?  AddCardListCell {
                
                    cell.blockClick = { [weak self] in
                        self?.addBankCard()
                    }
                    
                    return cell
                }
            }
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: ListCardCell.cellID()) as?  ListCardCell {
            if let model = self.sourceData[indexPath.row] as?  BankCardModel {
                cell.setTitle(model: model)
            }
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == sourceData.count {
            return sxDynamic(90)
        }
        return RecordJKCell.cellHeight()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    //开启编辑 删除 左滑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 执行删除操作
            // 更新数据源
            // 更新UITableView的显示
            if let model = self.sourceData[indexPath.row] as? BankCardModel {
                self.delBankitem(id: model.id)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "删除") { (_, indexPath) in
            // 执行删除操作
            // 更新数据源
            // 更新UITableView的显示
            if let model = self.sourceData[indexPath.row] as? BankCardModel {
                self.delBankitem(id: model.id)
            }
        }
        deleteAction.backgroundColor = AssetColors.bf16363.color // 设置按钮的背景色
//        deleteAction.titleTextColor = UIColor.white // 设置按钮文字的颜色
        
        return [deleteAction]
    }
}
