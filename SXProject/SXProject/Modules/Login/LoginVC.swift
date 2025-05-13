//
//  LoginVC.swift
//  SXProject
//
//  Created by 王威 on 2024/12/16.
//

import UIKit
import ActiveLabel

class LoginVC: ViewController, UITextFieldDelegate {
    
    /// 是否同意协议
    var agree = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initViews()
        initViewLayouts()
        
        UserSingleton.shared.dealUser()
        
        burialPoint()
        
         let ip = GetAddressIPManager.sharedInstance().getMyIP() 
         if ip.isEmpty {
            self.getIPAdress()
         }
    
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
    
    // MARK: - ip获取
    func getIPAdress() {
        GetAddressIPManager.sharedInstance().getAddressIp()
    }
   
    /// 埋点
    func burialPoint() {
        let manager = BurialPointManager()
        
        manager.burialPoint(type: BurialPoint.REGISTER_PAGE_VIEW)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        
        firstApp()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func initViews() {
        view.backgroundColor = .white
        view.addSubview(topView)
        
        view.addSubview(groundView)
        view.addSubview(textField)
        
        view.addSubview(selectedBut)
        view.addSubview(protocolLab)
        
        view.addSubview(submitBut)
        view.addSubview(subLabel)
        
        dealSubmit()
    }
    func initViewLayouts() {
        groundView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).offset(sxDynamic(30))
            make.right.equalTo(view.snp.right).offset(sxDynamic(-30))
            make.height.equalTo(sxDynamic(45))
            make.top.equalTo(topView.snp.bottom).offset(sxDynamic(13))
        }
        textField.snp.makeConstraints { make in
            make.left.equalTo(groundView.snp.left).offset(sxDynamic(15))
            make.centerY.equalTo(groundView.snp.centerY)
            make.right.equalTo(groundView.snp.right).offset(sxDynamic(-15))
        }
        selectedBut.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(22))
            make.left.equalTo(groundView.snp.left)
            make.top.equalTo(groundView.snp.bottom).offset(sxDynamic(22))
        }
        protocolLab.snp.makeConstraints { make in
            make.leading.equalTo(selectedBut.snp.trailing)
            make.right.equalTo(groundView.snp.right)
            make.centerY.equalTo(selectedBut.snp.centerY)
        }
        submitBut.snp.makeConstraints { make in
            make.top.equalTo(selectedBut.snp.bottom).offset(sxDynamic(62))
            make.left.equalTo(groundView.snp.left)
            make.right.equalTo(groundView.snp.right)
            make.height.equalTo(sxDynamic(45))
        }
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(submitBut.snp.bottom).offset(sxDynamic(15))
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(sxDynamic(18))
        }
    }
    
    //MARK: - actions
    func dealAgree() {
        selectedBut.isSelected = self.agree
        dealSubmit()
   }
    
    func dealSubmit() {
        if self.agree ==  true {
            submitBut.backgroundColor = kTBlue
            submitBut.setTitleColor(kWhite, for: .normal)
        } else {
            submitBut.backgroundColor = kBF2
            submitBut.setTitleColor(kTaaa, for: .normal)
        }
       
    }
    
    @objc
    func agreeClick(button: UIButton) {
        button.isSelected = !button.isSelected
      
        self.agree = button.isSelected
        
        dealSubmit()
    }
    @objc
    func loginClick() {
        if self.agree == false {
            return
        }
        
        getPhoneCode()
      
    }
    
    
    //MARK: - getter
    private lazy var topView: LoginTopView = {
        let view = LoginTopView()
        view.frame = CGRectMake(0, 0, kSizeScreenWidth, sxDynamic(290))
        
        return view
    }()
    private lazy var groundView: UIView = {
        let view = UIView()
        view.backgroundColor = kBF8
        view.layer.cornerRadius = sxDynamic(22.5)
        
        return view
    }()
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.clearButtonMode = .always
        textField.placeholder = "请输入账号"
        textField.keyboardType = .numberPad
//        textField.borderStyle = .roundedRect
        textField.delegate = self
        
        return textField
    }()
  

 
    private lazy var protocolLab: ActiveLabel = {
        let protocolLab = ActiveLabel()
        
        protocolLab.isUserInteractionEnabled = true
   
        let serviceAgreement = ActiveType.custom(pattern: "《用户协议》")
        let privacyPolicy = ActiveType.custom(pattern: "《隐私协议》".sx_T)

        protocolLab.enabledTypes.append(serviceAgreement)
        protocolLab.enabledTypes.append(privacyPolicy)
        
        protocolLab.enabledTypes = [.mention, .hashtag, .url, privacyPolicy, serviceAgreement]
//        protocolLab.enabledTypes = [serviceAgreement, privacyPolicy]
        protocolLab.text = String.init(format: "我已阅读《用户协议》和《隐私协议》，并同意协议内容")
        protocolLab.textColor = kT333
        protocolLab.numberOfLines = 0
        protocolLab.lineSpacing = 4
        protocolLab.font = UIFont.sx.font_t13
//        protocolLab.enabledTypes = [.url] // 设置需要激活的文本类型.mention, .hashtag,

        protocolLab.customColor[serviceAgreement] = kTBlue
        protocolLab.customColor[privacyPolicy] = kTBlue

        protocolLab.handleCustomTap(for: serviceAgreement) { _ in
            printLog("服务协议")
            let alertView = UserAgreementView()
            alertView.loadWebView(privacy: false)
            alertView.agreeBlock = { [weak self] agree in
                self?.agree = agree
                self?.dealAgree()
            }
            
            alertView.show()
           
        }
        protocolLab.handleCustomTap(for: privacyPolicy) { _ in
            let alertView = UserAgreementView()
            alertView.loadWebView(privacy: true)
            alertView.agreeBlock = { [weak self] agree in
                self?.agree = agree
                self?.dealAgree()
            }
            
            alertView.show()
        }
        
        return protocolLab
    }()
    
    
    private lazy var selectedBut: UIButton = {
        let but = UIButton.init(type: .custom)
        but.setImage(UIImage(named: "iot_login_check") , for: .normal)
        but.setImage(UIImage(named: "login_selected") , for: .selected)
        but.addTarget(self, action: #selector(agreeClick(button:)), for: .touchUpInside)
        
        return but
    }()
    
    private lazy var submitBut: UIButton = {
        let but = CreateBaseView.makeBut("获取短信验证码", kTBlue, kWhite, UIFont.sx.font_t15Blod)
        but.layer.cornerRadius = sxDynamic(22)
        but.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
        
        return but
    }()
    
    private lazy var subLabel: UILabel = {
        let label = CreateBaseView.makeLabel("手机号码验证通过即代表您同意创建易支用账户", UIFont.sx.font_t13, kT777, .center, 1)
        
        return label
    }()
    
}
