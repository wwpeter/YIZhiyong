//
//  SXAMatchingProductsListController.swift
//  SXProject
//
//  Created by Felix on 2025/5/16.
//


import UIKit

class SXAMatchingProductsListController: DDBaseViewController {
    var companyName = ""
    
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
        tableView.register(SXALoanCompanyNameCell.self, forCellReuseIdentifier: "SXALoanCompanyNameCell")
        tableView.register(SXALoanCompanyProductListCell.self, forCellReuseIdentifier: "SXALoanCompanyProductListCell")
        let footherView = UIView(frame: CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: 30))
        footherView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footherView
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    fileprivate lazy var rightButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("方案说明", for: .normal)
        button.titleLabel?.font = DDSFont(13)
        button.setTitleColor(kTBlue, for: .normal)
        button.addTarget(self, action: #selector(pushToConstructionController), for: .touchUpInside)
        return button
    }()
    
    fileprivate var currentCompanyModel = SXACompanyModel()
    fileprivate var dataArray = [SXACompanyProductModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        matchTheCompanyDetailData()
    }
    
    fileprivate func matchTheCompanyDetailData() {
        
        let param = ["name": companyName]
        NetworkRequestManager.sharedInstance().requestPath(kMatchCompanyDetail, withParam: param) { [weak self] result in
            //            printLog(result)
            if let model = JSONHelper.jsonToModel(result, SXACompanyModel.self) as? SXACompanyModel {
                self?.currentCompanyModel = model
            }
            self?.reloadViews()
            
        } failure: { error in
        }
    }
    
    fileprivate func reloadViews() {
        self.dataArray = self.currentCompanyModel.list
        self.mTableView.isHidden = false
        self.mTableView.reloadData()
    }
    
    @objc func pushToConstructionController() {
        print("方案说明=====")
        self.navigationController?.pushViewController(SXAProductExplainRuleController(), animated: true)
    }
    
    private func setupUI() {
        self.title = "匹配方案"
        self.topNavView.addSubview(rightButton)
        let bgImg = UIImageView()
        bgImg.image = DDSImage("a_home_icon_1")
        self.view.addSubview(bgImg)
        bgImg.snp.makeConstraints { make in
            make.left.right.top.equalTo(0)
            make.height.equalTo(kSizeScreenWidth)
        }
        self.view.addSubview(mTableView)
        mTableView.snp.makeConstraints { make in
            make.top.equalTo(kTopBarHeight)
            make.left.right.bottom.equalTo(0)
        }
        
        rightButton.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.bottom.equalTo(0)
            make.height.equalTo(44)
        }
        
    }
    
    fileprivate func pushToproductDetailController(_ model:SXACompanyProductModel) {
        //去申请
        let vc = SXALoanProductApplyController()
        vc.productModel = model
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SXAMatchingProductsListController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
            
        }
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SXALoanCompanyNameCell") as! SXALoanCompanyNameCell
            cell.selectionStyle = .none
            cell.updateCellWithModel(self.currentCompanyModel)
            return cell
            
        } else {
            var cell = tableView.dequeueReusableCell(withIdentifier: "SXALoanCompanyProductListCell") as? SXALoanCompanyProductListCell
            if cell == nil {
                cell = SXALoanCompanyProductListCell(style: .default, reuseIdentifier: "SXALoanCompanyProductListCell")
            }
            cell?.selectionStyle = .none
            let model = self.dataArray[indexPath.row]
            cell?.updateCellWithModel(model)
            weak var weakSelf = self
            cell?.applyBlock = { (tempmodel) in
                weakSelf?.pushToproductDetailController(tempmodel)
            }
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let detailVC = SXALoanProductDetailController()
        detailVC.productModel = self.dataArray[indexPath.row]
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
