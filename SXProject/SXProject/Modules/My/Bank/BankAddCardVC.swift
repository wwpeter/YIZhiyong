//
//  BankAddCardVC.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

class BankAddCardVC: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cardModel = BankCardModel()
    
    var sourceData = ["姓名：", "银行卡号：", "预留电话：", "归属银行："]
    var placeholderData = ["请输入姓名", "请输入银行卡号", "请输入银行预留电话", "请输入银行名称"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        
    }
    
    func initViews() {
        view.backgroundColor = kWhite
        SX_navTitle = "添加银行卡"
        
        
        AddCardCell.registerCell(tableView: myTableView)
        view.addSubview(myTableView)
//        myTableView.tableFooterView = bottomView
        view.addSubview(bottomView)
    }
    
    /// 添加银行卡
    @objc func addBankCardF() {
        if self.cardModel.name.isEmpty || cardModel.bank.isEmpty || cardModel.cardNum.isEmpty || cardModel.phone.isEmpty {
            Toast.showInfoMessage("请您完善信息")
            return
        }
        let userId = UserSingleton.shared.getUserId()
        let param = ["userId": userId, "name":self.cardModel.name, "phone":cardModel.phone, "bank":cardModel.bank, "cardNum":cardModel.cardNum, ]
        NetworkRequestManager.sharedInstance().requestPath(kAddCard, withParam: param) { [weak self] result in
            printLog(result)
       
            self?.navigationController?.popViewController(animated: true)
        } failure: { error in
//            Toast.showInfoMessage("".sx_T)
        }
    }
    
    //MARK: - initialize
    lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: CGRectMake(0, 0, kSizeScreenWidth , sxDynamic(260)), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.backgroundColor = kWhite
        tableView.layer.cornerRadius = sxDynamic(8)
        
        return tableView
    }()
   
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.frame = CGRectMake(0, sxDynamic(290), kSizeScreenWidth, sxDynamic(110))
        view.backgroundColor = .clear
        let but = CreateBaseView.makeBut("确认添加", kTBlue, .white, UIFont.sx.font_t16)
        but.layer.cornerRadius = sxDynamic(25)
        but.addTarget(self, action: #selector(addBankCardF), for: .touchUpInside)
        
        but.frame = CGRectMake(sxDynamic(20),sxDynamic(10), kSizeScreenWidth - sxDynamic(40), sxDynamic(50))
        but.backgroundColor = kTBlue
        
        view.addSubview(but)
        
        return view
    }()
}
