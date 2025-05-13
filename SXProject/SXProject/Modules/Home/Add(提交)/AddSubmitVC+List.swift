//
//  AddSubmitVC+List.swift
//  SXProject
//
//  Created by 王威 on 2025/3/29.
//

import UIKit

extension AddSubmitVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: SelItemAssetCell.cellID()) as?  SelItemAssetCell {
                
                cell.assetBlock = { [weak self] selArr in
                    self?.assetSelArr.removeAll()
                    self?.assetSelArr.append(contentsOf: selArr)
                }
                cell.refreshTableView(selArr: self.assetSelArr)
                
                
                return cell
            }
        } else if indexPath.section == 3 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: SelItemOtherCell.cellID()) as?  SelItemOtherCell {
                cell.indexBlock = { [weak self] zhimaIndex, zhiyeIndex in
                    self?.zhimaIndex = zhimaIndex
                    self?.zhiyeIndex = zhiyeIndex
                }
                
                cell.refreshTableView(zhima: zhimaIndex, zhiye: zhiyeIndex)
                
                return cell
            }
        } else if indexPath.section == 1 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: SelItemCellT.cellID()) as?  SelItemCellT {
                cell.indexBlock = { [weak self] index in
                    self?.userTimeIndex = index
                }
                cell.refreshTableView(selIndex: userTimeIndex)
                
                return cell
            }
        } else if indexPath.section == 4 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: BottomCell.cellID()) as?  BottomCell {
                
                return cell
            }
        }
        if let cell = tableView.dequeueReusableCell(withIdentifier: SelItemCell.cellID()) as?  SelItemCell {
            cell.indexBlock = { [weak self] index in
                self?.limitIndex = index
            }
            cell.refreshTableView(selIndex: limitIndex)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 3 {
            return sxDynamic(320)
        } else if indexPath.section == 2 {
            return sxDynamic(240)
        } else if indexPath.section == 1 {
            return sxDynamic(75)
        } else if indexPath.section == 4 {
            return sxDynamic(330)
        }
        return sxDynamic(75)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 4 {
            return 0
        }
        return sxDynamic(30)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleStr = titleArr[section]
        let view = UIView.init(frame: CGRectMake(0, 0, kSizeScreenWidth, sxDynamic(30)))
        view.backgroundColor = .white
        let titleLabel = CreateBaseView.makeLabel(titleStr, UIFont.sx.font_t16Blod, kT333, .left, 1)
        titleLabel.frame = CGRect(x: sxDynamic(20), y: sxDynamic(5), width: sxDynamic(300), height: sxDynamic(20))
        view.addSubview(titleLabel)
        
        return view
    }
}
