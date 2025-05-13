//
//  UserAgreementView.swift
//  SXProject
//
//  Created by 王威 on 2025/2/22.
//

import UIKit
import WebKit

typealias UserAgreementViewBlock = (_ agree: Bool) -> Void
class UserAgreementView: UIView, WKNavigationDelegate {
    
    var agreeBlock: UserAgreementViewBlock?
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
    
    func loadWebView(privacy: Bool) {
        if privacy ==  true {
            if let url = URL(string: String.init(format: "%@%@", kWebUrlBase, kPrivacyAgreement)) {
                webView.load(URLRequest(url: url))
            }
        
        } else {
            if let url = URL(string: String.init(format: "%@%@", kWebUrlBase, kUserAgreement)) {
                webView.load(URLRequest(url: url))
            }
           
        }
       
        exchangeUI(ex: privacy)
    }
    
    func loadWebViewNei(privacy: Bool) {
        if privacy ==  true {
            if let url = URL(string: String.init(format: "%@%@", kWebUrlBase, kPrivacyAgreement)) {
                webView.load(URLRequest(url: url))
            }
        
        } else {
            if let url = URL(string: String.init(format: "%@%@", kWebUrlBase, kUserAgreement)) {
                webView.load(URLRequest(url: url))
            }
           
        }
    }
    
    
    //MARK: - initialize
    func initViews() {
        addSubview(contentView)
        
        contentView.addSubview(leftImg)
        contentView.addSubview(rightImg)
        contentView.addSubview(leftCtr)
        
        contentView.addSubview(leftTitle)
        contentView.addSubview(rightLabel)
        contentView.addSubview(rightCtr)
        
        contentView.addSubview(leftCtr)
        contentView.addSubview(rightCtr)
        
//        contentView.addSubview(topView)


        contentView.addSubview(webView)
        contentView.addSubview(bottomView)
        
        contentView.addSubview(cancleBut)
        contentView.addSubview(submitBut)
    }
    
    func initViewLayouts() {
        contentView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(sxDynamic(88))
            make.left.right.bottom.equalTo(0)
        }
        leftCtr.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(54))
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top)
        }
        rightCtr.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(54))
            make.left.equalTo(contentView.snp.centerX)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentView.snp.top)
        }
        
        leftImg.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(54))
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top)
        }
        rightImg.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(54))
            make.left.equalTo(contentView.snp.centerX)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentView.snp.top)
        }
        
        leftTitle.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(54))
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top)
        }
        rightLabel.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(54))
            make.left.equalTo(contentView.snp.centerX)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(contentView.snp.top)
        }
        
        bottomView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(sxDynamic(67))
        }
        cancleBut.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.centerX)
            make.top.equalTo(bottomView.snp.top)
            make.bottom.equalTo(bottomView.snp.bottom)
        }
        submitBut.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.centerX)
            make.right.equalTo(contentView.snp.right)
            make.top.equalTo(bottomView.snp.top)
            make.bottom.equalTo(bottomView.snp.bottom)
        }
        
        deal()
    }
    
    func deal() {
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 0.5
        bottomView.layer.shadowOffset = CGSize(width: 0, height: 5)
        bottomView.layer.shadowRadius = 5
        bottomView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        bottomView.clipsToBounds = false // 关键！
    }
    
    // MAKR: - 事件
    @objc
    func click() {
   
        guard let blockT = agreeBlock else {return}
        blockT(true)
        
        self.dismiss()
    }
    
    @objc
    func cancelClick() {
   
        guard let blockT = agreeBlock else {return}
        blockT(false)
        self.dismiss()
    }
    
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
    
    @objc func leftClick() {
       
        exchangeUI(ex: false)
        loadWebViewNei(privacy: false)
    }
    
    func exchangeUI(ex: Bool) {
        if ex == true {
            rightImg.isHidden = true
            leftImg.isHidden = false
            leftTitle.textColor = kTaaa
            rightLabel.textColor = kT333
        } else {
          
            rightImg.isHidden = false
            leftImg.isHidden = true
            leftTitle.textColor = kT333
            rightLabel.textColor = kTaaa
        }
    }
    
    @objc func rightClick() {
       
        exchangeUI(ex: true)
        loadWebViewNei(privacy: true)
  
    }
    
    //MARK: - getter
    
    private lazy var leftCtr: UIControl = {
        let ctr = UIControl()
        ctr.addTarget(self, action: #selector(leftClick), for: .touchUpInside)
        
        return ctr
    }()
    private lazy var rightCtr: UIControl = {
        let ctr = UIControl()
        ctr.addTarget(self, action: #selector(rightClick), for: .touchUpInside)
        
        return ctr
    }()
    
    private lazy var leftTitle: UILabel = {
        let label = CreateBaseView.makeLabel("用户协议", UIFont.sx.font_t15, kT333, .center, 1)
        label.backgroundColor = .clear
        
        return label
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = CreateBaseView.makeLabel("隐私协议", UIFont.sx.font_t15, kTaaa, .center, 1)
        label.backgroundColor = .clear
        
        return label
    }()
    
    private lazy var leftImg: UIImageView = {
        let img = CreateBaseView.makeIMG("left_icon", .scaleAspectFill)
        img.isHidden = true
        
        return img
    }()
    
    private lazy var rightImg: UIImageView = {
        let img = CreateBaseView.makeIMG("right_icon", .scaleAspectFill)
        
        return img
    }()
    
//    let dsweb = DsWebController()
//
//    dsweb.url = urlT
//    self.navigationController?.pushViewController(dsweb, animated: true)
    private lazy var webViewT: DsWebController = {
        let webView = DsWebController()
        webView.view.frame = CGRect(x: 0, y: sxDynamic(65), width: kSizeScreenWidth, height: sxDynamic(600))
        
        return webView
    }()
    
    // 定义懒加载的 WKWebView
    lazy var webView: WKWebView = {
        // 创建配置 (可选)
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = false
        
        // 初始化 WebView
        let webView = WKWebView(frame: CGRect(x: 0, y: sxDynamic(65), width: kSizeScreenWidth, height: sxDynamic(600)), configuration: config)
       // webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        webView.navigationDelegate = self
        
        return webView
    }()
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = sxDynamic(16)
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = .white
        
        return contentView
    }()
    private lazy var submitBut: UIButton = {
        let submitBut = CreateBaseView.makeBut("同意协议并继续", .clear, kTBlue, UIFont.sx.font_t13)
        submitBut.addTarget(self, action: #selector(click), for: .touchUpInside)
        submitBut.backgroundColor = .white
        
        return submitBut
    }()
    
    private lazy var cancleBut: UIButton = {
        let cancleBut = CreateBaseView.makeBut("不同意", .clear, kT333, UIFont.sx.font_t13)
        cancleBut.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        cancleBut.backgroundColor = .white
        
        return cancleBut
    }()
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhite
//        view.layer.cornerRadius = 10
       
        
        return view
    }()
    private lazy var topView: ProtocolTopView = {
        let view = ProtocolTopView()
        view.layer.cornerRadius = sxDynamic(16)
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return view
    }()
 
}
