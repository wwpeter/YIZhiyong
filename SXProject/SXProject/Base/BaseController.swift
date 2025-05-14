//
//  BaseController.swift
//  DigitalSleep
//
//  Created by sx on 2021/11/30.
//
//  基类控制器

import UIKit
import SXBaseModule
import HZNavigationBar

@objc protocol ViewControllerAffair {
    
    /// 初始化界面
    
    @objc optional func setUp()
    
    /// 添加和布局子视图
    @objc optional func addAndLayoutSubView()
    
    /// 数据界面绑定
    @objc optional func bind()
}

/// 所有子类需要继承的类
typealias ViewController = ViewControllerAffair & BaseController

/// 基类
class BaseController: UIViewController {
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    var nav: HZCustomNavigationBar?
    
    ///返回上一个vc
    func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    func popRootVC() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    //更新用户信息
    func updataUserDetail() {
        //获取本地用户信息
        UserSingleton.shared.getUserDetail()
    }
    //状态栏颜色
//    func exchangeLight() {
//        if #available(iOS 13.0, *) {
//            UIApplication.shared.statusBarStyle = .lightContent //状态栏颜色
//        }
//
//    }
//    func excahngeDef() {
//        if #available(iOS 13.0, *) {
//            UIApplication.shared.statusBarStyle = .default //状态栏颜色
//        }
//    }
    func dealNiv() {
        statusBarHidden()
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        nav = HZCustomNavigationBar.create(to: view)
        nav?.backgroundColor = kBF4F5F9
        nav?.shadowImageHidden = false
        
//        NotificationCenter.default.addObserver(self, selector: #selector(orientationDidChange(_:)), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    
    /// 标题
    var SX_navTitle :String? {
        didSet {
            self.navigationItem.title = SX_navTitle
        }
    }
    /// 导航栏左侧标题
    var SX_navLeftTitle :String? {
        didSet {
            let item = UIBarButtonItem.sx.textItem(title: SX_navLeftTitle ?? "", titleColor: AssetColors.t333.color, target: self, action: #selector(clickLeftItem))
            self.navigationItem.leftBarButtonItem = item
        }
    }
    /// 导航栏左侧img
    var SX_navLeftImage :String? {
        didSet {
            let item = UIBarButtonItem.sx.imageItem(imageName: SX_navLeftImage ?? "", target: self, action: #selector(clickLeftItem))
            self.navigationItem.leftBarButtonItem = item
        }
    }
    /// 导航栏右侧标题
    var SX_navRightTitle :String? {
        didSet {
            let item = UIBarButtonItem.sx.textItem(title: SX_navRightTitle ?? "", titleColor: AssetColors.t333.color, target: self, action: #selector(clickRightItem))
            self.navigationItem.rightBarButtonItem = item
        }
    }
    
    
    /// 导航栏右侧img
    var SX_navRightImage :String? {
        didSet {
            let item = UIBarButtonItem.sx.imageItem(imageName: SX_navRightImage ?? "", target: self, action: #selector(clickRightItem))
            self.navigationItem.rightBarButtonItem = item
        }
    }
    /// 右侧导航栏多个
   
    func setRightImages(rights: Array<String>) {
        var tempArr = [UIBarButtonItem]()
        rights.enumerated().map {  indexT, result in
            // 设置 rightBarButtonItems
            let spaceItem = UIBarButtonItem.createSpace(width: sxDynamic(3)) // 设置间距宽度
            if indexT == 0 {
                let item = UIBarButtonItem.sx.imageItem(imageName: rights[indexT] , target: self, action: #selector(clickRightItem))
//                let item = UIBarButtonItem(title: rights[indexT], style: .plain, target: self, action: #selector(clickRightItem))
                
                tempArr.append(item)
                tempArr.append(spaceItem)
            } else if indexT == 1 {
                let item = UIBarButtonItem.sx.imageItem(imageName: rights[indexT] , target: self, action: #selector(clickRightItem2))
          
                tempArr.append(item)
                tempArr.append(spaceItem)
            } else if indexT == 2 {
                let item = UIBarButtonItem.sx.imageItem(imageName: rights[indexT] , target: self, action: #selector(clickRightItem3))

                tempArr.append(item)
            }
           
         
        }

        
        self.navigationItem.rightBarButtonItems = tempArr
    }
    
    /// 点击导航栏左侧item Block
    var SXClickNavLeftItemBlock:(() -> Void)?
    /// 点击导航栏右侧item Block
    var SXClickNavRightItemBlock:(() -> Void)?
    
    @objc
    func clickLeftItem() {
        self.SXClickNavLeftItemBlock?()
    }
    
    @objc
    func clickRightItem() {
        self.SXClickNavRightItemBlock?()
    }
    
    @objc
    func clickRightItem2() {
        self.SXClickNavRightItemBlock?()
    }
    
    @objc
    func clickRightItem3() {
        self.SXClickNavRightItemBlock?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configIOS11()
        self.configIOS15()
        //        self.dealNiv()
        
        //去除导航的线
        // 去除导航栏下方的线条
        //        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        hideNavBottomHairline(hide: true)
     
    }
    
    // 隐藏NavigationBar下面的黑线
    public func hideNavBottomHairline(hide: Bool) {
        let navigationBarImageView = hairlineImageViewInNavigationBar(view: self.navigationController?.navigationBar ?? UIView())
        navigationBarImageView?.isHidden = hide
    }

    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKind(of: UIImageView.self) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInNavigationBar(view: subview) {
                return imageView
            }
        }
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if hideNavigationBar() {
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if hideNavigationBar() {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    /// 重写改方法控制导航 隐藏或者显示
    func hideNavigationBar() -> Bool { false }
    
    //MARK: - 全屏问题处理
    @objc public func orientationDidChange(_ notification: Notification) {
        statusBarHidden()
    }
    
    /// 解决刘海屏手机在横屏后状态栏消失问题
    fileprivate func statusBarHidden() {
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            var statusBar: UIView?
            if #available(iOS 13.0, *) {
                statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? .zero)
                UIApplication.shared.keyWindow?.addSubview(statusBar!)
            } else {
                statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView
            }
            statusBar?.isHidden = false
            statusBar?.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44.0)
        }
    }
    
    // MARK: - iOS 适配
    
    func configIOS11() {
        /// 适配 iOS 11.0 ,iOS11以后，控制器的automaticallyAdjustsScrollViewInsets已经废弃，所以默认就会是YES
        /// iOS 11新增：adjustContentInset 和 contentInsetAdjustmentBehavior 来处理滚动区域
        if #available(iOS 11.0, *) {
            UITableView.appearance().estimatedRowHeight = 0
            UITableView.appearance().estimatedSectionHeaderHeight = 0
            UITableView.appearance().estimatedSectionFooterHeight = 0
            // 防止列表/页面偏移
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
            UITableView.appearance().contentInsetAdjustmentBehavior = .never
            UICollectionView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    func configIOS15() {
        // 适配iOS15，tableView的section设置
        // iOS15中，tableView会给每一个section的顶部（header以上）再加上一个22像素的高度，形成一个section和section之间的间距
        // 新增的sectionHeaderTopPadding会使表头新增一段间隙，默认为UITableViewAutomaticDimension
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }
    }
    /**
     * 地图坐标系 转 世界坐标系
     * @param point 地图点
     * @param size 地图min 或者 max
     * @param resolution 缩放
     * @return
     */
    //{"y_min":295,"x_max":422,"y_max":416,"x_min":374,"map_size":5978}
    func convertPoint(point: Double, size: Double, resulution: Double) -> Int {
        let worldPoint = (size - 400.0) * resulution + point * resulution
        
        return Int(worldPoint * 100)
    }
    /**
     * 世界坐标系 转 地图坐标系
     * @param point 世界坐标系的点
     * @param size 地图min 或者 max
     * @param resolution 缩放
     * @return
     */
    func worldPointToIndexPoint(point: Double, size: Double, resulution: Double) -> Double {
        //point / resolution) + 400 - size
        let indexPoint = (size - 400.0) / resulution - point / resulution
        
        return indexPoint
    }
}
//获取主vc
extension BaseController {
//    func getMainVC() -> UIViewController {
//        return DHRouterUtil.getCurrentVc() ?? UIViewController()
//    }
}
//MAKR: - 去登录
extension BaseController {
   @objc func goLoginBase() {
        let vc = LoginVC()
       
        let niv = NavigationController.init(rootViewController: vc)
        niv.modalPresentationStyle = .fullScreen
        self.present(niv, animated: true)
    }
}

//MARK: -  创建一个 UIBarButtonItem 的扩展，用于创建包含间距的自定义视图
extension UIBarButtonItem {
    static func createSpace(width: CGFloat) -> UIBarButtonItem {
        let spaceView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 1))
        let spaceItem = UIBarButtonItem(customView: spaceView)
        return spaceItem
    }
}
