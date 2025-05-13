//
//  BankListVC.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

class BankListVC: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sourceData = [HandyJSON?]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getBankList()/// 获取银行卡列表
    }
    
    func initViews() {
        view.backgroundColor = kBF8
        SX_navTitle = "银行卡"
        
        AddCardListCell.registerCell(tableView: myTableView)
        ListCardCell.registerCell(tableView: myTableView)
        view.addSubview(myTableView)
//        view.addSubview(addView)
    }
    
    @objc func addBankCard() {
        let vc = BankAddCardVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    //处理空数据问题
    func dealEmpty(empty: Bool) {
        if empty {
            myTableView.addSubview(addView)
            addView.isHidden = false
        } else {
            addView.isHidden = true
            addView.removeFromSuperview()
        }
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

    /// 没有银行卡
    private lazy var addView: EmptyBankCardView = {
        let view = EmptyBankCardView()
        view.addCardBut.addTarget(self, action: #selector(addBankCard), for: .touchUpInside)
        view.frame = CGRectMake(0, sxDynamic(120), kSizeScreenWidth, sxDynamic(300))
        
        return view
    }()
   
}
