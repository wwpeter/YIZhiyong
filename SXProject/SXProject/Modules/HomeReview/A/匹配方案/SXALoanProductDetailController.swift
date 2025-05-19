//
//  SXALoanProductDetailController.swift
//  SXProject
//
//  Created by Felix on 2025/5/16.
//

import UIKit

class SXALoanProductDetailController: DDBaseViewController {
    var productModel = SXACompanyProductModel()
    
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
        tableView.register(SXALoanProductsDetailCell.self, forCellReuseIdentifier: "SXALoanProductsDetailCell")
        tableView.register(SXAProductExplainRuleCell.self, forCellReuseIdentifier: "SXAProductExplainRuleCell")
        let footherView = UIView(frame: CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: 30))
        footherView.backgroundColor = UIColor.clear
        tableView.tableFooterView = footherView
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    
    fileprivate lazy var bottomView:UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .white
        
        let callButton = UIButton()
        callButton.setImage(DDSImage("product_call_iocn"), for: .normal)
        callButton.addTarget(self, action: #selector(callButtonAction), for: .touchUpInside)
        tempView.addSubview(callButton)
        
        let label1 = UILabel()
        label1.text = "在线客服"
        label1.font = DDSFont(9)
        label1.textColor = kTaaa
        tempView.addSubview(label1)
        
        let applyButton = UIButton(type: .custom)
        applyButton.setTitle("立即申请", for: .normal)
        applyButton.setTitleColor(.white, for: .normal)
        applyButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        applyButton.backgroundColor =  kTBlue
        applyButton.addTarget(self, action: #selector(applyButtonAction), for: .touchUpInside)
        applyButton.setCorner(20)
        tempView.addSubview(applyButton)
        
        callButton.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.width.height.equalTo(24)
            make.left.equalTo(30)
        }
        label1.snp.makeConstraints { make in
            make.top.equalTo(callButton.snp.bottom).offset(2)
            make.centerX.equalTo(callButton)
        }
        
        applyButton.snp.makeConstraints { make in
            make.left.equalTo(callButton.snp.right).offset(30)
            make.top.equalTo(10)
            make.right.equalTo(-20)
            make.height.equalTo(40)
        }
        
        return tempView
    }()
    
    
    fileprivate var dataArray = [SXAProudectExplainModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc func callButtonAction() {
        print("在线客服====")
        let pop = DDAlertView(content: "是否拨打客服电话：057122930325", cancelButtonTitle: "取消", sureButtonTitle:"确定")
        pop.sureBlock {
            if let url = URL(string:"tel:057122930325") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        pop.show()
    }
    
    @objc func applyButtonAction() {
        print("立即申请====")
        let param = ["productId": productModel.productId]
        Toast.showWaiting()
        NetworkRequestManager.sharedInstance().requestPath(kMatchTheProcutStatus, withParam: param) { [weak self] result in
            let dic = JSONHelper.exchangeDic(jsonStr: result)
            Toast.closeWaiting()
            print("查询========\(dic)")
            if let code = dic["code"] as? Int {
                if code == 1 {
                    self?.pushToLoanProductController()
                } else {
                    Toast.showInfoMessage("该产品已下架")
                }
            }
            
        } failure: { error in
            Toast.closeWaiting()
        }
    }
    
    fileprivate func pushToLoanProductController() {
        let vc = SXALoanProductApplyController()
        vc.productModel = productModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        self.title = self.productModel.productName
        self.view.backgroundColor = .white
        
        self.view.addSubview(mTableView)
        self.view.addSubview(bottomView)
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(50 + kBottomSafeBarHeight)
        }
        mTableView.snp.makeConstraints { make in
            make.top.equalTo(kTopBarHeight)
            make.left.right.equalTo(0)
            make.bottom.equalTo(bottomView.snp.top)
        }
        
        addTextString()
    }
    
    fileprivate func addTextString() {
        dataArray.removeAll()
        if productModel.access != "" {
            do {
                let model = SXAProudectExplainModel()
                model.title = "准入要求"
                model.decrilbelText = productModel.access
                dataArray.append(model)
            }
        }
        
        if productModel.forbidden != "" {
            do {
                let model = SXAProudectExplainModel()
                model.title = "禁入行业"
                model.decrilbelText = productModel.forbidden
                dataArray.append(model)
            }
        }
        
        if productModel.require != "" {
            do {
                let model = SXAProudectExplainModel()
                model.title = "企业要求"
                model.decrilbelText = productModel.require
                dataArray.append(model)
            }
        }
        
        if productModel.credit != "" {
            do {
                let model = SXAProudectExplainModel()
                model.title = "征信要求"
                model.decrilbelText = productModel.credit
                dataArray.append(model)
                
            }
        }
        mTableView.reloadData()
    }
}

extension SXALoanProductDetailController : UITableViewDelegate, UITableViewDataSource {
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "SXALoanProductsDetailCell") as! SXALoanProductsDetailCell
            cell.selectionStyle = .none
            cell.updateCellWithModel(productModel)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SXAProductExplainRuleCell") as! SXAProductExplainRuleCell
            cell.selectionStyle = .none
            cell.updateCellWithModel(self.dataArray[indexPath.row])
            return cell
        }
    }
}
