//
//  ProtocolVC.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

class ProtocolVC: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sourceData = ["用户协议", "隐私协议", "个人信息共享授权协议", "注销协议"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    func initViews() {
        view.backgroundColor = kBF8
        SX_navTitle = "用户协议".sx_T
        
        ProtocolCell.registerCell(tableView: myTableView)
        view.addSubview(myTableView)
    }
    

    //MARK: - initialize
    lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: CGRectMake(0, 0, kSizeScreenWidth, kSizeScreenHight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.backgroundColor = kBF4F5F9
      
        
        return tableView
    }()
}
