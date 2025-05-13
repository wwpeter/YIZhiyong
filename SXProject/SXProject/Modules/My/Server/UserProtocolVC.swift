//
//  UserProtocolVC.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

class UserProtocolVC: ViewController , UITableViewDelegate, UITableViewDataSource {
    
    var sourceData = [RecordModel]()
    /// 借款还是还款0 借款 1 还款
    var recordType = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    func initViews() {
        view.backgroundColor = kBF8
     
        SX_navTitle = "用户协议"
        
        ProtocolCell.registerCell(tableView: myTableView)
        UserProtocolCell.registerCell(tableView: myTableView)
        
        view.addSubview(myTableView)
        view.addSubview(loginOutBut)
        
    }
    
    @objc func loginOut() {
        
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
    
    private lazy var loginOutBut: UIButton = {
        let but = CreateBaseView.makeBut("退出登录", kTBlue, .white, UIFont.sx.font_t16Blod)
        but.frame = CGRectMake(sxDynamic(20), kSizeScreenHight - sxDynamic(110), kSizeScreenWidth - sxDynamic(40), sxDynamic(50))
        but.layer.cornerRadius = sxDynamic(25)
        but.addTarget(self, action: #selector(loginOut), for: .touchUpInside)
        
        return but
    }()
}
