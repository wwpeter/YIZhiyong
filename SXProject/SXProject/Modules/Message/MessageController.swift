//
//  MessageController.swift
//  SXProject
//
//  Created by 王威 on 2024/1/3.
//

import UIKit
//import HZNavigationBar

class MessageController: ViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        updateApp()
        initViews()
        config()
    }
    
    func initViews() {
        self.view.backgroundColor = kWhite
        SX_navTitle = "iot_message".sx_T
        setRightImages(rights: ["message_niv_2", "message_niv_1"])
      
//        MessageItemCell.registerCell(tableView: messageTableView)
//        view.addSubview(nivView)
//        view.addSubview(messageTableView)
//     
//        messageTableView.tableHeaderView = headerView
        
    }
    

    
    //MAKR: - 顶部导航的按钮事件
    func config() {
//        nivView.messageBlock = { [weak self] type in
//            if type == .setting {
//                printLog("设置")
//                self?.pushSettingVC()
//            } else {
//                printLog("客服")
////                self?.pushCustomerVC()
//                let alertView = ConnectionAlertView()
//                alertView.connectionBlock = { [weak self] type in
//                    if type == "online" {
//                        self?.pushCustomerVC()
//                    } else if type == "phone" {
//                        if let phoneURL = URL(string: String.init(format: "tel://%@", kHotLine)) {
//                            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
//                        }
//                    }  else if type == "website" {
//                        if let websiteURL = URL(string: kOfficialWebsite) {
//                            UIApplication.shared.open(websiteURL, options: [:], completionHandler: nil)
//                        }
//                    }
//                }
//                
//                alertView.show()
//            }
//        }
//        
//        headerView.tapClick = { [weak self] type in
//            if type == "left" {
//                self?.pushSystem()
//            } else if type == "center" {
//                self?.pushShareVC()
//            } else if type == "right" {
//                self?.pushGuideVC()
//            }
//         }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        super.touchesBegan(touches, with: event)
//        
//        let vc = AddDeviceScanVC()
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//    
  
    //MARK: - getter
//    private lazy var nivView: MessageNivView = {
//        let view = MessageNivView()
//        view.frame = CGRectMake(0, 0, kSizeScreenWidth, sxDynamic(135))
//        
//        return view
//    }()
//    
//    private lazy var headerView: MessageHeaderView = {
//        let view = MessageHeaderView()
//        view.frame = CGRectMake(0, 0, kSizeScreenWidth, sxDynamic(113))
//        
//        return view
//    }()
//   
    
    lazy var messageTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: sxDynamic(90), width: kSizeScreenWidth, height: kSizeScreenHight - kTabbarHeight - sxDynamic(135)), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.backgroundColor = UIColor.clear
        tableView.separatorColor = UIColor.clear
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.estimatedRowHeight = sxDynamic(49) // 设置一个估算的行高
        tableView.rowHeight = UITableView.automaticDimension // 使用自动计算的行高
        
        
        return tableView
    }()
    
   
}
