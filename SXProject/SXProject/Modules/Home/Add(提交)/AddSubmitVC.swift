//
//  AddSubmitVC.swift
//  SXProject
//
//  Created by 王威 on 2025/3/26.
//
/// B面 主流程 提交页面

import UIKit

class AddSubmitVC: ViewController, UITableViewDelegate, UITableViewDataSource, JFCSTableViewControllerDelegate {
    func viewController(_ viewController: JFCSTableViewController, didSelectCity model: JFCSBaseInfoModel) {
        let city = String.init(format: "%@", model.name)//[NSString stringWithFormat:@"%@",[model yy_modelDescription]];
        headerView.setCity(city: city)
        addModel.cityName = city
        let tempCode = String.init(format: "%ld", model.code)
        if tempCode.count == 4 {
            addModel.city = model.code * 100
        } else {
            addModel.city = model.code
        }
       
    }
    
    var configCity = JFCSConfiguration()
    var titleArr = ["申请额度 (最高可申请20万):","使用时间：" , "您的资产信息（请按你的真实情况进行多选）：" , "其他信息完善：", ""]
    /// 申请额度

    /// 芝麻分选中
    var zhimaIndex = -1
    /// 职业选中
    var zhiyeIndex = -1
    /// 选中资产
    var assetSelArr = [false, false, false, false, false, false, false, false, false, false, false, false]
    /// 使用时间
    var userTimeIndex = -1
    /// 额度选中
    var limitIndex = -1
    //二级
    var condition = ["F,E", "CCC", "", "RT1,TAXES1,INVOICING4", "F,E"]
    
//    
//    var limitDealData = [Any]()
//    // 使用时间
//    var userTimeDeal = [Any]()
//    /// 资产信息
//    var assetInfoDeal = [Any]()
//    /// 其他信息
//    var zhimafenDeal = [Any]()
//    var occupationDeal = [Any]()
    /// 提交的离开
    var submitPOP = false
    /// 提交的资料
    var addModel = AddModel()
    /// 协议同意
    var agreement = false
    
    /// 当前弹窗的次数
    var currentIndexFirst = false
    
    // 保存原始代理
    private weak var originalGestureDelegate: UIGestureRecognizerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
        config()
        
        setupGestureControl()
        
        burialPoint()// 添加埋点
        getAddDataSource()
        getAddDataSourceOne()
        
        userOrderInfo()/// 信息回显
    }
    private func setupGestureControl() {
        guard let nav = navigationController,
              let gesture = nav.interactivePopGestureRecognizer else { return }
        
        // 1. 保存原始代理
        originalGestureDelegate = gesture.delegate
        
        // 2. 临时替换代理
        gesture.delegate = self
    }
    private func restoreGesture() {
         guard let nav = navigationController,
               let gesture = nav.interactivePopGestureRecognizer,
               let originalDelegate = originalGestureDelegate else { return }
         
         // 恢复原始代理
         gesture.delegate = originalDelegate
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        // 禁用右滑返回手势
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false
        // 恢复手势（避免影响其他页面）
//        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        restoreGesture()
       
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
      
    }
    
    func initViews() {
        view.backgroundColor = .white
        
        SelItemCellT.registerCell(tableView: myTableView)
        SelItemAssetCell.registerCell(tableView: myTableView)
        SelItemOtherCell.registerCell(tableView: myTableView)
        SelItemCell.registerCell(tableView: myTableView)
        BottomCell.registerCell(tableView: myTableView)
        view.addSubview(topView)
        view.addSubview(myTableView)
        myTableView.tableFooterView = bottomView
        
        myTableView.tableHeaderView = headerView
    }
    
    func config() {
        bottomView.submitBlock = { [weak self] in
//            let vc = UnderReviewVC()
//            
//            self?.navigationController?.pushViewController(vc, animated: true)
            
            
            self?.transferMeaning()
            self?.checkSul()
        }
        bottomView.selBlock = { [weak self] sel in
            self?.agreement = sel
        }
        
        headerView.headerBlock = { [weak self] in
            let vc = JFCSTableViewController.init(configuration: self?.configCity ?? JFCSConfiguration(), delegate: self!)
       
            
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        
        let city = GetAddressIPManager.sharedInstance().getMyCity()
        let cityCode = GetAddressIPManager.sharedInstance().getMyCityCode()
        headerView.setCity(city: city)
        addModel.cityName = city
        addModel.city = cityCode
    }
    
    
    @objc func backClick() {
//        self.navigationController?.popViewController(animated: true)
        if submitPOP == true {
            printLog("提交资料")
        } else {
            self.burialPointCommon(type: BurialPoint.FIRST_QUIT)
            if currentIndexFirst == false {
                /// 异常离开
                let aletView = AlertViewFillFirst()
                aletView.typeBlock = { [weak self] type in
                    if type == "1" {
                        /// 关闭首次弹窗,
                        self?.burialPointCommon(type: BurialPoint.CLOSE_FIRST_QUIT)
                    
                    } else if type == "2" {///  首次继续填写,
                        self?.burialPointCommon(type: BurialPoint.CONTINUE_FILL)
                    }
                }

                aletView.show()
                currentIndexFirst = true
            } else {
                /// 二次退出弹窗,
                self.burialPointCommon(type: BurialPoint.SECOND_QUIT)
                let aletView = AlertViewFillSecond()
                aletView.typeBlock = { [weak self] type in
                    if type == "1" {
                        /// 关闭二次弹窗,
                        self?.burialPointCommon(type: BurialPoint.CLOSE_SECOND_QUIT)
                        self?.navigationController?.popViewController(animated: true)
                    } else if type == "3" {
                        /// 是的,
                        self?.burialPointCommon(type: BurialPoint.YES_BUTTON)
                        self?.navigationController?.popViewController(animated: true)
                    } else if type == "2" {
                        /// 否，继续填写,
                        self?.burialPointCommon(type: BurialPoint.NOT_CONTINUE_FILL)
                    }
                }

                aletView.show()
            }
            
        }
    }
    
    //MARK: - getter
    
    lazy var myTableView: UITableView = {
        let tableView = UITableView(frame: CGRectMake(0, sxDynamic(98), kSizeScreenWidth, kSizeScreenHight - sxDynamic(110)), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        tableView.backgroundColor = .white
        tableView.layer.cornerRadius = sxDynamic(8)
        
        return tableView
    }()
   
    
    private lazy var bottomView: BottomView = {
        let view = BottomView()
        view.frame = CGRectMake(0, 0, kSizeScreenWidth, sxDynamic(185))
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var topView: AddTopView = {
        let view = AddTopView()
        view.backBut.addTarget(self, action: #selector(backClick), for: .touchUpInside)
        view.frame = CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: sxDynamic(160))
        
        return view
    }()
    
    lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.frame = CGRect(x: 0, y: 0, width: kSizeScreenWidth, height: sxDynamic(334))
        
        return view
    }()
}
// MARK: - 手势代理控制
extension AddSubmitVC: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // 在此控制器中完全禁止右滑返回
        return false
    }
}
