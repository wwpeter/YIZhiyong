//
//  RecordVC.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit
import MJRefresh

class RecordVC: ViewController , UITableViewDelegate, UITableViewDataSource {
    
    /// 分页信息
    var pageNum: Int = 1
    var pageSize = 10
    var listData = [HandyJSON?]()
    
    /// 借款还是还款0 借款 1 还款
    var recordType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
    }
    
    // 网络请求

    func initViews() {
        view.backgroundColor = kBF8
        if recordType == 0 {
            SX_navTitle = "借款记录"
            historyList()
            
            myTableView.mj_header = MJRefreshStateHeader(refreshingTarget: self, refreshingAction:  #selector(historyList))
            myTableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(getMoreListData))
        } else  {
            SX_navTitle = "还款记录"
            emptyView.exchange(title: "暂无还款记录", icon: "hk_record")
        }
   
        
        RecordJKCell.registerCell(tableView: myTableView)
        
        view.addSubview(myTableView)
        
        dealEmpty(empty: true)
        
    }
    
    //处理空数据问题
    func dealEmpty(empty: Bool) {
        if empty {
            myTableView.addSubview(emptyView)
            emptyView.isHidden = false
        } else {
            emptyView.isHidden = true
            emptyView.removeFromSuperview()
        }
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
    private lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.isHidden = true
        view.frame = CGRectMake((kSizeScreenWidth - sxDynamic(120)) / 2, sxDynamic(182), sxDynamic(120), sxDynamic(150))
        
        return view
    }()
    
}
