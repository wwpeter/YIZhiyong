//
//  JKHelpVC.swift
//  SXProject
//
//  Created by 王威 on 2025/2/14.
//

import UIKit

class JKHelpVC: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sourceData = [["如何查看借款进度？","A：点击“还款”即可查看借款进度。"], ["借款途中是否会收取其他费用？", "A：申请过程中，无需任何费用。"], ["借款成功后，如何还款？", "A：借款成功后工作人员会与你联系，通过指定的方式进行还款。"], ["借款有没有门槛？", "A：年龄要求18周岁-55周岁之间"], ["借款额度如何生成？", "A：由系统多维度评估，进行综合评估后计算得出。"]]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
       
    }
    
    func initViews() {
        
        SX_navTitle = "借款帮助"
        HelpJkCell.registerCell(tableView: myTableView)
        
        view.addSubview(myTableView)
      
    }
    
    //MARK: - initialize
    lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: CGRectMake(0, 0, kSizeScreenWidth , kSizeScreenHight), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.backgroundColor = kBF4F5F9
        tableView.layer.cornerRadius = sxDynamic(8)
        
        return tableView
    }()

}
