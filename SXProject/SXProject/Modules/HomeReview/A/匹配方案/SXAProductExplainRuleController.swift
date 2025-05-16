//
//  SXAProductExplainRuleController.swift
//  SXProject
//
//  Created by Felix on 2025/5/16.
//

import UIKit

class SXAProductExplainRuleController: DDBaseViewController {
    
    fileprivate lazy var mTableView: UITableView = {
        let tableView = UITableView(frame: self.view.bounds, style:.plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.register(SXAProductExplainRuleCell.self, forCellReuseIdentifier: "SXAProductExplainRuleCell")
        let footherView = UIView(frame: CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: 30))
        footherView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footherView
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.setCorner(radius: 8)
        return tableView
    }()
    
    
    fileprivate var dataArray = [SXAProudectExplainModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        self.title = "方案说明"
        
        self.view.addSubview(mTableView)
        mTableView.snp.makeConstraints { make in
            make.top.equalTo(kTopBarHeight + 10)
            make.left.right.bottom.equalTo(0)
        }
        addTextString()
    }
    
    fileprivate func addTextString() {
        dataArray.removeAll()
        do {
            let model = SXAProudectExplainModel()
            model.title = "一、服务内容说明"
            model.decrilbelText = """
1.贵司全权授权易支用为贵司提供企业融资方案服务

2.融资方案生成过程中贵司将配合平台收集企业信息、税务信息等内容;

3.为贵司问量身定制融资方案并一对一向贵司解答融资方案
"""
            dataArray.append(model)
        }
        
        do {
            let model = SXAProudectExplainModel()
            model.title = "二 、隐私声明"
            model.decrilbelText = """
1.贵司相关资料将会严格保密，并且只用于制作融资方案，不会主动泄露到第三方，也不会在贵司未授权之下用于其他用途:

2.为保障贵司的数据安全，融资方案将会对企业以及个人相关信息进行脱敏处理。
"""
            dataArray.append(model)
        }
        
        do {
            let model = SXAProudectExplainModel()
            model.title = "三 、免责声明"
            model.decrilbelText = """
1.本融资方案是在贵司授权并配合提供资料的基础上，基于市面贷款产品条件进行合理的估算。估算结果与实际下款额度可能存在一定的误差。融资方案的准确度将取决于贵司提供信息的完整度、真实度。

2.本融资方案为参考性质，它可为您融资提供长期指引但不代表对贵司的融资目标的实现做出保证;

3.因贵司私下转播，因此照成损失易支用不承担任何责任。
"""
            dataArray.append(model)
        }
        mTableView.reloadData()
    }
    
}

extension SXAProductExplainRuleController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SXAProductExplainRuleCell") as! SXAProductExplainRuleCell
        cell.selectionStyle = .none
        cell.updateCellWithModel(self.dataArray[indexPath.row])
        return cell
    }
}
