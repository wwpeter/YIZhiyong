//
//  MyController.swift
//  SXProject
//
//  Created by 王威 on 2024/1/3.
//

import UIKit


class MyController: ViewController, UITableViewDelegate, UITableViewDataSource {
 
    var sourceData = ["银行卡管理", "服务协议", "联系客服", "设置"]
    var sourceImg = ["bank_manager", "server_img", "custom_img", "cell_settting"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        userDetail()
        config()
      
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        UserSingleton.shared.userDetail()// 用户信息
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        initConfig()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    func initViews() {
        view.backgroundColor = kBF8
        SX_navTitle = "iot_mine".sx_T
        
        MyItemCell.registerCell(tableView: myTableView)
        
        view.addSubview(headerView)
        view.addSubview(myTableView)
        
        /// 临时进入 登录
//        let token = getUserDefault(key: "access_token")
//        if token.isEmpty {
//            goLoginNew()
//        }
       
    }
    /// 跳转登录新
    @objc func goLoginNew() {
        guard !(UIApplication.sx.getCurrentViewController() is LoginVC) else { return }
        let vc = LoginVC()
        let niv = NavigationController.init(rootViewController: vc)
        niv.modalPresentationStyle = .fullScreen
        
        DHRouterUtil.getCurrentVc()?.present(niv, animated: true, completion: {
            printLog("进入登录！")
        })
    }
    func config() {
        headerView.topBlock = { [weak self] type in
            if type == .headImg {
                 
            } else if type == .setting {
                let vc = SettingVC()
                
                self?.navigationController?.pushViewController(vc, animated: true)
            } else if type == .loanRecord {
                let vc = RecordVC()
                vc.recordType = 0
                self?.navigationController?.pushViewController(vc, animated: true)
            } else if type == .repaymentRecord {
                let vc = RecordVC()
                vc.recordType = 1
                self?.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        refreshTopView()
    }
    
    func refreshTopView() {//UserInfo
//        headerView.setDataSource(UserSingleton.shared.userInfo ?? UserInfo())
    }
    
    
    ///用户详情接口
    func userDetail() {
        let token = getUserDefault(key: "access_token")
        let param = ["token": token]
//        NetworkRequestManager.sharedInstance().requestPath(kQueryUserOrderInfo, withParam: param) { [weak self] result in
//            printLog(result)
//            let detailStr = result.sx.base64Encoded
//            setUserDefault(key: "userDetail", value: detailStr ?? "")
//            _ = JSONHelper.exchangeDic(jsonStr: result)
//            if let userInfo: UserInfo = JSONHelper.parse(jsonString: result) {
//                printLog(userInfo)
//                UserSingleton.shared.userInfo = userInfo
//            }
//            self?.updataUserDetail()
//            self?.refreshTopView()
//        } failure: { error in
////            Toast.showInfoMessage("".sx_T)
//        }
    }
    

    
    func initConfig() {
        myTableView.tableFooterView = UIView()
//        view.addSubview(headerView)
        
        let securePhone = UserSingleton.shared.getPhone()
        if !securePhone.isEmpty {
       
            // 截取前3个字符
    
            if let result = securePhone.safeSubstring(from: 0, length: 3) {
                headerView.setTitle(title: String.init(format: "%@********", result))
            }
            
        }
       
    }
    
    

    @objc func clickDetail() {
//        let vc = MyDetailVC()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - getter
    lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: CGRectMake(sxDynamic(20), sxDynamic(279), kSizeScreenWidth - sxDynamic(40), sxDynamic(240)), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.backgroundColor = kBF4F5F9
        tableView.layer.cornerRadius = sxDynamic(8)
        
        return tableView
    }()
   
    
    private lazy var headerView: MyTopView = {
        let view = MyTopView()
        view.frame = CGRectMake(0, 0, kSizeScreenWidth, sxDynamic(305))
        
        return view
    }()
}
extension String {
    func safeSubstring(from index: Int, length: Int) -> String? {
        guard index >= 0, length >= 0, index <= self.count else { return nil }
        
        let start = self.index(
            self.startIndex,
            offsetBy: index,
            limitedBy: self.endIndex
        ) ?? self.endIndex
        
        let end = self.index(
            start,
            offsetBy: length,
            limitedBy: self.endIndex
        ) ?? self.endIndex
        
        return String(self[start..<end])
    }
}
