//
//  HomeController.swift
//  SXProject
//
//  Created by 王威 on 2024/1/3.
// 

import UIKit
import SXBaseModule
import MJExtension
import AppTrackingTransparency
import AdSupport

class HomeController: ViewController, HomeTopViewDelegate {
 
    
    var isConnectWiFiHotSpot = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        self.SX_navTitle = "title".sx_T
        initViews()
  
        appPageInfo()
        
        requestTrackingPermission()
        let ip = GetAddressIPManager.sharedInstance().getMyIP()
        if ip.isEmpty {
           self.getIPAdress()
        }
    }
    
    // MARK: - ip获取
    func getIPAdress() {
        GetAddressIPManager.sharedInstance().getAddressIp()
    }
    // 第一次安装
    func firstApp() {
        //第一次安装
        let firstIns = UserDefaults.standard.bool(forKey: kFirstInstallation)
        if !firstIns {
           /// 弹出隐私协议 弹窗
            let alertView = AlertViewFirstApp()
            
            alertView.show()
        }
    }
    
    func initViews() {
        
        view.addSubview(scrollView)
        scrollView.addSubview(bottomView)
        scrollView.addSubview(topView)
        scrollView.addSubview(bottomNewView)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true

//        let token = getUserDefault(key: "token")
//        if !token.isEmpty {
//            firstApp()
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.isHidden = false

    }
    
    func requestTrackingPermission() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                    print("用户允许追踪，IDFA: \(idfa)")
                case .denied, .restricted, .notDetermined:
                    print("用户拒绝或未授权追踪")
                @unknown default:
                    break
                }
            }
        }
    }
    
    //MARK: - getter
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRectMake(0, 0, kSizeScreenWidth, kSizeScreenHight)
        scrollView.contentSize = CGSize(width: kSizeScreenWidth, height: kSizeScreenHight + sxDynamic(235))
        scrollView.backgroundColor = kBF8
        
        return scrollView
    }()
    private lazy var bottomView: HomeBottomView = {
        let view = HomeBottomView()
  
        view.frame = CGRectMake(sxDynamic(20), sxDynamic(472) + kTopBarHeight, kSizeScreenWidth - sxDynamic(40), sxDynamic(163))
        
        return view
    }()
    
    private lazy var bottomNewView: HomeBottomNewView = {
        let view = HomeBottomNewView()
        view.frame = CGRectMake(sxDynamic(20), sxDynamic(472+180) + kTopBarHeight, kSizeScreenWidth - sxDynamic(40), sxDynamic(220))
        
        return view
    }()
    
     lazy var topView: HomeTopView = {
        let view = HomeTopView()
        view.homeEventDelegate = self
        view.frame = CGRectMake(0, 0, kSizeScreenWidth, sxDynamic(525))
       
        return view
    }()
}
