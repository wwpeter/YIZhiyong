//
//  SXAHomeCompanyListView.swift
//  SXProject
//
//  Created by Felix on 2025/5/19.
//


import UIKit

class SXAHomeCompanyListView: UIView {
    var companyName = ""
    var selectBlock: ((_ model:SXACompanyModel) -> Void)?

    fileprivate lazy var mTableView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style:.plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = true
        tableView.estimatedRowHeight = 44
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorInset = .zero
        tableView.register(SXAHomeCompanyListCell.self, forCellReuseIdentifier: "SXAHomeCompanyListCell")
        let footherView = UIView(frame: CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: 30))
        footherView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footherView
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    fileprivate var dataArray = [SXACompanyModel]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    func reloadViewWithArray(_ array:[SXACompanyModel]) {
        self.dataArray = array
        self.mTableView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        self.addSubview(mTableView)
        mTableView.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.right.bottom.equalTo(0)
        }
    }
}

extension SXAHomeCompanyListView : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "SXAHomeCompanyListCell") as? SXAHomeCompanyListCell
        if cell == nil {
            cell = SXAHomeCompanyListCell(style: .default, reuseIdentifier: "SXAHomeCompanyListCell")
        }
        cell?.selectionStyle = .none
        cell?.updateCellWithModel(self.dataArray[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        selectBlock?(self.dataArray[indexPath.row])
    }
}
