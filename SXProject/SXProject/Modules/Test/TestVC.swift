//
//  TestVC.swift
//  SXProject
//
//  Created by 王威 on 2024/3/6.
//

import UIKit
import Foundation
import CryptoKit

class TestVC: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViews()
        let dsweb = DsWebController()
//        let url = tempModel.content
//        dsweb.url = url
        self.navigationController?.pushViewController(dsweb, animated: true)
    }

    //MARK: - 视图创建
    func initViews() {
        
        
        
      /**
       UIFont.zs.font_t17Blod,  字体
       AssetColors.t283349.color  颜色全局 管理
       
       AssetImages.iconFlodRight.image  图片全局管理
       */
        
        /**
         tableView.estimatedRowHeight = 100 // 设置一个估算的行高
         tableView.rowHeight = UITableView.automaticDimension // 使用自动计算的行高
         */
        
        /**
         if let swiftDict = result {
             if let dic = swiftDict["data"] as? [String : String] {
                 
             }
         }
         */
    }
}
