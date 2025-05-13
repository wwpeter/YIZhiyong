//
//  SettingVC.swift
//  SXProject
//
//  Created by 王威 on 2025/3/28.
//

import UIKit

class SettingVC: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataSource = [["title":"账号注销", "sub":""] ,["title":"版本号", "sub":"v1.0.0"]]

    
    @objc func loginOut() {
        ZlAlertTool.showSystemAlert(title: "退出登录".sx_T, actionTitles: ["确定".sx_T], cancelTitle: "取消".sx_T) { index in
            if index == 0 {
              
            } else if index == 1 {
                self.logout()
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        initViews()
    }
    
    func initViews() {
        SX_navTitle = "设置"
        SettingCell.registerCell(tableView: myTableView)
        view.addSubview(self.myTableView)
        view.addSubview(loginOutBut)
    }
    

    //MARK: - getter
    lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: CGRectMake(0, 0, kSizeScreenWidth, kSizeScreenHight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.backgroundColor = kBF4F5F9
        tableView.layer.cornerRadius = sxDynamic(8)
    
        
        return tableView
    }()
    
    
    
    private lazy var loginOutBut: UIButton = {
        let but = CreateBaseView.makeBut("退出登录", kTBlue, .white, UIFont.sx.font_t16Blod)
        but.frame = CGRectMake(sxDynamic(20), kSizeScreenHight - sxDynamic(170), kSizeScreenWidth - sxDynamic(40), sxDynamic(50))
        but.layer.cornerRadius = sxDynamic(25)
        but.addTarget(self, action: #selector(loginOut), for: .touchUpInside)
        
        return but
    }()
}
