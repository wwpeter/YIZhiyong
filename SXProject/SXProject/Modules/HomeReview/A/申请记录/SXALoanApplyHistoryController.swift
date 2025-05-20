//
//  SXALoanApplyHistoryController.swift
//  SXProject
//
//  Created by Felix on 2025/5/20.
//

import UIKit
import MJRefresh

class SXALoanApplyHistoryController: DDBaseViewController {
    
    fileprivate lazy var mTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style:.plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        tableView.estimatedRowHeight = 50
        tableView.isHidden = true
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.register(SXALoanApplyHistoryCell.self, forCellReuseIdentifier: "SXALoanApplyHistoryCell")
        let footherView = UIView(frame: CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: 30))
        footherView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footherView
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    private lazy var emptyView: EmptyView = {
        let view = EmptyView()
        view.isHidden = true
        view.subTitle.text = "暂无申请记录"
        view.frame = CGRectMake((kSizeScreenWidth - sxDynamic(120)) / 2, sxDynamic(182), sxDynamic(120), sxDynamic(150))
        
        return view
    }()
    
    fileprivate var dataArray = [SXALoanHistoryModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchHistoryList()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    fileprivate func fetchHistoryList() {
        
        let param = ["pageNum":1, "pageSize": 100] as [String : Any]
        NetworkRequestManager.sharedInstance().requestPath(kproductLoanHistory, withParam: param) { [weak self] result in
            print("记录=====\(result)")
            //            if let arr = JSONHelper.jsonArrayToModel(result, SXALoanHistoryModel.self) as? [SXALoanHistoryModel]{
            //                self?.dataArray = arr
            //            }
            
            if let mode = JSONHelper.jsonToModel(result, SXALoanHistoryModel.self) as? SXALoanHistoryModel {
                self?.dataArray.append(mode)
            }
            
            self?.reloadViews()
            
        } failure: { error in
        }
    }
    
    fileprivate func reloadViews() {
        self.emptyView.isHidden = self.dataArray.count > 0
        self.mTableView.isHidden = self.dataArray.count == 0
        self.mTableView.reloadData()
    }
    
    @objc func pushToConstructionController() {
        print("方案说明=====")
        self.navigationController?.pushViewController(SXAProductExplainRuleController(), animated: true)
    }
    
    private func setupUI() {
        self.topNavView.backgroundColor = .white
        self.title = "申请记录"
        self.view.addSubview(mTableView)
        self.view.addSubview(emptyView)
        mTableView.snp.makeConstraints { make in
            make.top.equalTo(kTopBarHeight)
            make.left.right.bottom.equalTo(0)
        }
    }
}

extension SXALoanApplyHistoryController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "SXALoanApplyHistoryCell") as? SXALoanApplyHistoryCell
        if cell == nil {
            cell = SXALoanApplyHistoryCell(style: .default, reuseIdentifier: "SXALoanApplyHistoryCell")
        }
        cell?.selectionStyle = .none
        let model = self.dataArray[indexPath.row]
        cell?.updateCellWithModel(model)
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
}
