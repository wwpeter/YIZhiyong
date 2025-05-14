//
//  SXASXALoanCalculatorDetailController.swift
//  SXProject
//
//  Created by Felix on 2025/5/14.
//

import UIKit
import SnapKit
import MJRefresh


class SXASXALoanCalculatorDetailController: DDBaseViewController {
    
    var principal:Double = 0  // 贷款本金10万元
    var annualRate:Double = 0      // 年利率5%
    var month = 0            // 贷款期限1年
    var payType = 0 //还款方式
    
    fileprivate lazy var topTabView:SXALoanDetailCategoryView = {
        let tempView = SXALoanDetailCategoryView()
        weak var weakSelf = self
        tempView.finishBlock = { (aIndex) in
            weakSelf?.changeLoadTabIndex(aIndex)
        }
        return tempView
    }()
    
    fileprivate lazy var mTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style:.plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.register(SXALoanDetailDataCell.self, forCellReuseIdentifier: "SXALoanDetailDataCell")
        tableView.register(SXALoanDetailTopCell.self, forCellReuseIdentifier: "SXALoanDetailTopCell")
        tableView.register(SXALoanDetailTitleCell.self, forCellReuseIdentifier: "SXALoanDetailTitleCell")
        let footherView = UIView(frame: CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: 30))
        footherView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footherView
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    
    fileprivate var monthDay = 10 //fixme remove
    fileprivate var dataArray = [SXALoadPaymentDetailModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMineViews()
        updateViewAfterGetData()
        
        changeLoadTabIndex(payType)
        topTabView.showDefaultSelextIndex(payType)
    }
    
    fileprivate func changeLoadTabIndex(_ adIndex:Int) {
        print("切换=====\(adIndex)")
        dataArray.removeAll()
        
        if adIndex == 0 {
            print("================ 等额本息 ================")
            self.dataArray =  SXALoanCalculator.equalInstallment(principal: principal, annualRate: annualRate, month: month)
            
        } else if adIndex == 1 {
            print("\n================ 等额本金 ================")
            self.dataArray =  SXALoanCalculator.decreasingPayment(principal: principal, annualRate: annualRate, month: month)
            
        } else if adIndex == 2 {
            
            print("\n================ 等本等息 ================")
            self.dataArray =  SXALoanCalculator.equalPrincipalInterest(principal: principal, annualRate: annualRate, months: month)
            
        } else {
            print("\n================ 先息后本 ================")
            self.dataArray =  SXALoanCalculator.interestFirst(principal: principal, annualRate: annualRate, months: month)
        }
        
        self.mTableView.reloadData()
        
    }
    
    fileprivate func updateViewAfterGetData() {
        self.mTableView.isHidden = false
        self.mTableView.reloadData()
    }
}

//MARK: 表格代理
extension SXASXALoanCalculatorDetailController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
            
        }
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SXALoanDetailTopCell") as! SXALoanDetailTopCell
                cell.selectionStyle = .none
                cell.updateCellWithArray(self.dataArray,principal)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SXALoanDetailTitleCell") as! SXALoanDetailTitleCell
                cell.selectionStyle = .none
                return cell
            }
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "SXALoanDetailDataCell") as? SXALoanDetailDataCell
            if cell == nil {
                cell = SXALoanDetailDataCell(style: .default, reuseIdentifier: "SXALoanDetailDataCell")
            }
            cell?.selectionStyle = .none
            cell?.updateCellWithModel(self.dataArray[indexPath.row], indexPath.row)
            return cell!
        }
    }
}

extension SXASXALoanCalculatorDetailController {
    
    func setupMineViews() {
        self.title = "贷款详情"
        let bgImg = UIImageView()
        bgImg.image = DDSImage("a_home_icon_1")
        self.view.insertSubview(bgImg, at: 0)
        bgImg.snp.makeConstraints { make in
            make.left.right.top.equalTo(0)
            make.height.equalTo(kSizeScreenWidth)
        }
        
        self.view.backgroundColor = .white
        
        self.view.addSubview(topTabView)
        self.view.addSubview(self.mTableView)
        topTabView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(kTopBarHeight)
        }
        
        self.mTableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.top.equalTo(topTabView.snp.bottom)
        }
    }
}
