//
//  CheaterGuideBV.swift
//  SXProject
//
//  Created by 王威 on 2025/2/14.
//
/// 防诈指南

import UIKit

class CheaterGuideBV: ViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataDic = [["title":"1.场景一：假冒APP 借钱先缴费","sub":"-通过相似的Logo、名称诱导用户下载虚假产品，或以高额度、低利率等方式为诱饵，通过其他链接或者二维码形式下载仿冒APP，索要人工费、手续费、保证金、手续费等行为都为诈骗行为。\n\n- 用户要从正规和官方渠道下载APP，不要轻易从陌生短信及邮件中下载，遇到类似情况请及时寻找官方客服进行信息核对和辨别。所有需要提前缴费的行为都属于欺诈行为。"],
                   ["title":"2. 场景二：冒充工作人员 私下转账","sub":"- 冒充钱包工作人员，私下联系用户，以“降息”、“威胁”、“催促还款”、“系统故障”等方式诱骗用户添加微信，需要线下操作的转账到个人账户等行为，都是属于欺诈。\n\n - 官方客服不会私下联系用户，不会要求用户向个人账户转账，办理借款一定要通过官方平台渠道借贷。\n\n - 通过非法手段获取用户的个人信息，编造转账错误等理由联系用户进行操作。"],
                   ["title":"3. 场景三：收到莫名转账资金","sub":"- 遇到类似情况，请联系银行或报警处理，切勿进行私下操作，保护自身的财产安全。"], ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func initViews() {
       
      
        view.addSubview(topView)
        
        TopGuideCell.registerCell(tableView: myTableView)
        view.addSubview(myTableView)
    }
    
    @objc func backClick() {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - initialize
    lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: CGRectMake(0, sxDynamic(148), kSizeScreenWidth , kSizeScreenHight - sxDynamic(148)), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = sxDynamic(16)
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return tableView
    }()
    
    private lazy var topView: TopGuideView = {
        let view = TopGuideView()
        view.backBut.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        view.frame = CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: sxDynamic(305))
      
        return view
    }()

}
