//
//  Record+Config.swift
//  SXProject
//
//  Created by 王威 on 2025/4/9.
//

import UIKit
import MJRefresh

extension RecordVC {
    
    /// 
    @objc func historyList() {//total\":44,\"list
        self.refresh()
        self.pageNum = 1
        let param = ["pageNum":self.pageNum, "pageSize": pageSize] as [String : Any]
        NetworkRequestManager.sharedInstance().requestPath(kQueryOrdersHistoryPageApp, withParam: param) { [weak self] result in
         
            let resultDic = JSONHelper.exchangeDic(jsonStr: result)
            if let listArr = resultDic["dataList"] {
                let total = resultDic["total"] as! Int / (self?.pageSize ?? 10)
                if self?.pageNum ?? 0 > total {
                    self?.myTableView.mj_footer = nil
                } else {
                    self?.refresh()
                }
            
                do {
                    // 将数组转换为 JSON 数据
                    let jsonData = try JSONSerialization.data(withJSONObject: listArr, options: .prettyPrinted)
                    
                    // 将 JSON 数据转换为字符串 (可选)
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        if let arr = JSONHelper.jsonArrayToModel(jsonString, RecordModel.self) {
                            self?.listData.removeAll()
                            self?.listData.append(contentsOf: arr)
                            if arr.count > 0 {
                                self?.dealEmpty(empty: false)
                            } else {
                                self?.dealEmpty(empty: true)
                            }
                            
                            self?.myTableView.reloadData()
                            self?.finishTable()
                        }
                    }
                } catch {
                    print("Error converting array to JSON: \(error.localizedDescription)")
                }
            
            }
            
            
        } failure: { error in
            
        }
    }
    
    func finishTable() {
        self.myTableView.mj_header?.endRefreshing()
        self.myTableView.mj_footer?.endRefreshing()
    }
    
    func refresh() {
        self.myTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(getMoreListData))
    }
    
    /// 上啦加载更多
    @objc func getMoreListData() {
        self.pageNum += 1

        let param = ["pageNum":self.pageNum, "pageSize": pageSize] as [String : Any]
        Toast.showWaiting()
        NetworkRequestManager.sharedInstance().requestPath(kQueryOrdersHistoryPageApp, withParam: param) { [weak self] result in
          
            let resultDic = JSONHelper.exchangeDic(jsonStr: result)
            if let listArr = resultDic["list"] {
                let total = (resultDic["total"] as? Int ?? 0) / (self?.pageSize ?? 10)
                if self?.pageNum ?? 0 > total {
                    self?.myTableView.mj_footer = nil
                } else {
                    self?.refresh()
                }
            

                do {
                    // 将数组转换为 JSON 数据
                    let jsonData = try JSONSerialization.data(withJSONObject: listArr, options: .prettyPrinted)
                    
                    // 将 JSON 数据转换为字符串 (可选)
                    if let jsonString = String(data: jsonData, encoding: .utf8) {
                        if let arr = JSONHelper.jsonArrayToModel(jsonString, RecordModel.self) {
                            self?.listData.append(contentsOf: arr)
                            if arr.count > 0 {
                                self?.dealEmpty(empty: false)
                            } else {
                                self?.dealEmpty(empty: true)
                            }
                            
                            self?.myTableView.reloadData()
                            self?.finishTable()
                        }
                    }
                } catch {
                    print("Error converting array to JSON: \(error.localizedDescription)")
                }
            }
           
        
        } failure: { error in
            
        }
    }
}
