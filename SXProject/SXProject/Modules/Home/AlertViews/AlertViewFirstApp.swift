//
//  AlertViewFirstApp.swift
//  SXProject
//
//  Created by 王威 on 2025/4/3.
//
/// 第一次安装弹窗

import UIKit
import ActiveLabel

class AlertViewFirstApp: UIView {

    /// 使用代码创建一个View会调用该构造方法
    ///
    /// - Parameter frame: <#frame description#>
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initViews()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.initViewLayouts()
    }
    
    //MARK: - initialize
    func initViews() {
        self.backgroundColor = AssetColors.b00030.color
        addSubview(contentView)
       
        contentView.addSubview(closeBut)
        contentView.addSubview(titleLabel)
        contentView.addSubview(protocolLab)
      
        contentView.addSubview(submitNotBut)
        
        contentView.addSubview(submitBut)
      
    }
    
    func initViewLayouts() {
        contentView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY).offset(sxDynamic(-20))
            make.height.equalTo(sxDynamic(280))
            make.leading.equalTo(self.snp.leading).offset(sxDynamic(30))
            make.trailing.equalTo(self.snp.trailing).offset(sxDynamic(-30))
        }
     
        
        closeBut.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(24))
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-20))
            make.top.equalTo(contentView.snp.top).offset(sxDynamic(15))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top).offset(sxDynamic(30))
            make.height.equalTo(sxDynamic(25))
        }
        
        protocolLab.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(20))
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-20))
            make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(20))
            
        }
        submitNotBut.snp.makeConstraints { make in
          
            make.height.equalTo(sxDynamic(45))
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(20))
            make.right.equalTo(contentView.snp.centerX).offset(sxDynamic(-10))
            make.bottom.equalTo(contentView.snp.bottom).offset(sxDynamic(-45))
        }
        
        submitBut.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(45))
            make.left.equalTo(contentView.snp.centerX).offset(sxDynamic(10))
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-20))
            make.centerY.equalTo(submitNotBut.snp.centerY)
        }
        
   
      
    }
    
    //MARK: - getter
    func show() {
        //获取delegate
        let window = UIWindow.key
        self.frame = window?.bounds ?? CGRect.zero
        window?.addSubview(self)
        
        UIView.animate(withDuration: 0.35) {
            self.contentView.alpha = 1.0
        }
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.4) {
//            self.contentView.transform = CGAffineTransformMakeScale
            self.contentView.alpha = 0.0
        } completion: { finished in
            self.removeFromSuperview()
        }
    }


    //MARK: - getter
    private lazy var closeBut: UIButton = {
        let but = CreateBaseView.makeBut("alert_close")
        but.addTarget(self, action: #selector(submitClickT), for: .touchUpInside)
        
        return but
    }()
    
//    private lazy var groundImg: UIImageView = {
//        let img = CreateBaseView.makeIMG("system_icon", .scaleAspectFit)
//        img.contentMode = .scaleAspectFit
//        
//        return img
//    }()
//    
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("易支用隐私保护政策", UIFont.sx.font_t16, kT333, .center, 1)
        
        return label
    }()
    
   private lazy var protocolLab: ActiveLabel = {
       let protocolLab = ActiveLabel()
       //
       protocolLab.isUserInteractionEnabled = true
  
       let serviceAgreement = ActiveType.custom(pattern: "《用户协议》")
       let privacyPolicy = ActiveType.custom(pattern: "《隐私协议》")

       protocolLab.enabledTypes.append(serviceAgreement)
       protocolLab.enabledTypes.append(privacyPolicy)
       
       protocolLab.enabledTypes = [.mention, .hashtag, .url, privacyPolicy, serviceAgreement]
//        protocolLab.enabledTypes = [serviceAgreement, privacyPolicy]
       protocolLab.text = String.init(format: "在您使用易支用服务前，请务必阅读 《用户协议》（点击了解详细内容）以便能够更好的使用产品功能。同时根据监管要求，我们将会依据《隐私协议》相关条款来手机，使用您的个人信息。")
       protocolLab.textColor = kT333
       protocolLab.numberOfLines = 0
       protocolLab.lineSpacing = 4
       protocolLab.font = UIFont.sx.font_t13
//        protocolLab.enabledTypes = [.url] // 设置需要激活的文本类型.mention, .hashtag,

       protocolLab.customColor[serviceAgreement] = kTBlue
       protocolLab.customColor[privacyPolicy] = kTBlue

       protocolLab.handleCustomTap(for: serviceAgreement) { _ in
           printLog("服务协议")
           let dsweb = DsWebController()
         
           dsweb.url = String.init(format: "%@%@", kWebUrlBase, kUserAgreement)
           
           DHRouterUtil.getCurrentVc()?.navigationController?.pushViewController(dsweb, animated: true)
           self.dismiss()
       }
       protocolLab.handleCustomTap(for: privacyPolicy) { _ in
           let dsweb = DsWebController()
      
           dsweb.url = String.init(format: "%@%@", kWebUrlBase, kPrivacyAgreement)
           
           DHRouterUtil.getCurrentVc()?.navigationController?.pushViewController(dsweb, animated: true)
           self.dismiss()
       }
       
       return protocolLab
   }()

    private lazy var submitBut: UIView = {
        let but = CreateBaseView.makeBut("同意", kTBlue, kWhite,  UIFont.sx.font_t16)
        but.layer.cornerRadius = sxDynamic(22.5)
        but.addTarget(self, action: #selector(submitClickFF), for: .touchUpInside)
//        let view = UIView()
//        view.backgroundColor = kTBlue
//        view.layer.cornerRadius = sxDynamic(22.5)
////
//        let tap = UITapGestureRecognizer()
//        tap.addTarget(self, action: #selector(submitClickT))
//        view.addGestureRecognizer(tap)
//        view.frame = CGRectMake(sxDynamic(20), sxDynamic(170), kSizeScreenWidth - sxDynamic(100), sxDynamic(45))
        
        return but
    }()

    
    @objc func submitClickFF() {
        UserDefaults.standard.setValue(true, forKey: kFirstInstallation)
        UserDefaults.standard.synchronize()
        
        dismiss()
    }
    
    private lazy var submitNotBut: UIButton = {
        let but = CreateBaseView.makeBut("不同意", kBF2, kT777,  UIFont.sx.font_t16)
        but.layer.cornerRadius = sxDynamic(22.5)
        but.addTarget(self, action: #selector(submitClickT), for: .touchUpInside)
        
        return but
    }()
    
    @objc func submitClickT() {
       
        exit(0)
    }
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = sxDynamic(16)
//        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = .white
        
        return contentView
    }()
}
