//
//  SXALoanCalculatorDetailController.swift
//  SXProject
//
//  Created by Felix on 2025/5/14.
//

import UIKit
import SnapKit
import MJRefresh

class DDTodayIncomeDataModel : NSObject  {
    var totalIncome:Double = 0 //总收入
    var talkIncome:Double = 0//聊天收入
    var giftIncome:Double = 0//礼物收入
    var voiceIncome:Double = 0//连麦
    var newerTalkReward:Double = 0//新人
    var luckBoxIncome:Double = 0 //幸运盒子收入
    var rankIncome:Double = 0 //排行榜收入
    var inviteIncome:Double = 0 //邀请收入
    var systemReward:Double = 0 //系统奖励
    var songOrderIncome:Double = 0
    var videoIncome:Double = 0
}


class SXALoanCalculatorDetailController: DDBaseViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMineViews()
        updateViewAfterGetData()
    }
    
    fileprivate func changeLoadTabIndex(_ adIndex:Int) {
        print("切换=====\(adIndex)")
        monthDay = Int.random(in: 1...10)
        self.mTableView.reloadData()
    }
    
    fileprivate func updateViewAfterGetData() {
        self.mTableView.isHidden = false
        self.mTableView.reloadData()
    }
}

//MARK: 表格代理
extension SXALoanCalculatorDetailController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
            
        }
        return monthDay //fixme
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SXALoanDetailTopCell") as! SXALoanDetailTopCell
                cell.selectionStyle = .none
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
            cell?.updateCellWithModel(DDTodayIncomeDataModel(), indexPath.row) //fixme
            return cell!
        }
    }
}

extension SXALoanCalculatorDetailController {
    
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
