//
//  HomeTopView.swift
//  SXProject
//
//  Created by 王威 on 2025/1/6.
//

import UIKit

protocol HomeTopViewDelegate: AnyObject {
    /// 领取额度
    func getAllowance()
    /// 借款帮助
    func helpClick()
    ///防诈指南
    func guideClick()
    /// 通知
    func notificate()
}

class HomeTopView: UIView {

    weak var homeEventDelegate: HomeTopViewDelegate?
    
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
    func setRate(rate: String, loanTime: String) {
        centerView.setRate(rate: rate, loanTime: loanTime)
    }
    
    
    //MARK: - initialize
    func initViews() {
        addSubview(topImg)
        
        addSubview(topIcon)
        addSubview(topIcon2)
        addSubview(titleLabel)
        
        addSubview(centerView)
        
        
        addSubview(notificationView)
        
        addSubview(helpBut)
        addSubview(fangzhaBut)
    }
    
    func initViewLayouts() {
        topImg.snp.makeConstraints { make in
            make.left.top.right.equalTo(0)
            make.height.equalTo(sxDynamic(565))
        }
        topIcon.snp.makeConstraints { make in
            make.left.equalTo(topImg.snp.left).offset(sxDynamic(30))
            make.width.equalTo(sxDynamic(35))
            make.height.equalTo(sxDynamic(50))
            make.top.equalTo(topImg.snp.top).offset(sxDynamic(15+kStatusBarHeight))
        }
        topIcon2.snp.makeConstraints { make in
            make.top.equalTo(topIcon.snp.top)
            make.width.equalTo(sxDynamic(63))
            make.height.equalTo(sxDynamic(25))
            make.left.equalTo(topIcon.snp.right).offset(sxDynamic(10))
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(topIcon2.snp.left)
            make.top.equalTo(topIcon2.snp.bottom).offset(sxDynamic(5))
            make.height.equalTo(sxDynamic(20))
            make.width.equalTo(sxDynamic(180))
        }
        
        centerView.snp.makeConstraints { make in
            make.top.equalTo(topIcon.snp.bottom).offset(sxDynamic(20))
            make.width.equalTo(sxDynamic(335))
            make.height.equalTo(sxDynamic(280))
            make.centerX.equalTo(topImg.snp.centerX)
        }
        
        notificationView.snp.makeConstraints { make in
            make.top.equalTo(centerView.snp.bottom).offset(sxDynamic(10))
            make.width.equalTo(sxDynamic(335))
            make.height.equalTo(sxDynamic(36))
            make.centerX.equalTo(topImg.snp.centerX)
        }
        
        helpBut.snp.makeConstraints { make in
            make.left.equalTo(topImg.snp.left).offset(sxDynamic(20))
            make.right.equalTo(topImg.snp.centerX).offset(sxDynamic(-5))
            make.height.equalTo(sxDynamic(60))
            make.top.equalTo(notificationView.snp.bottom).offset(sxDynamic(10))
        }
        fangzhaBut.snp.makeConstraints { make in
            make.right.equalTo(topImg.snp.right).offset(sxDynamic(-20))
            make.left.equalTo(topImg.snp.centerX).offset(sxDynamic(5))
            make.height.equalTo(sxDynamic(60))
            make.top.equalTo(notificationView.snp.bottom).offset(sxDynamic(10))
        }
    }
    
    //MARK: - getter
    private lazy var notificationView: NotificationView = {
        let view = NotificationView()
        view.frame = CGRectMake(sxDynamic(20), sxDynamic(420), kSizeScreenWidth - sxDynamic(40), sxDynamic(36))
        
        return view
    }()
    
    private lazy var topImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "home_top_1")
        
        return img
    }()
    
    private lazy var topIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "app_icon")
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    private lazy var topIcon2: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "yzy_icon")
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("正规金融服务平台", UIFont.sx.font_t13, .white, .left, 1)
        
        return label
    }()
    
    @objc func headTapClick() {
        if let delegate = self.homeEventDelegate {
            delegate.getAllowance()
        }
    }
    
    private lazy var centerView: TopCenterView = {
        let view = TopCenterView()
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(headTapClick))
        view.submitImg.addGestureRecognizer(tap)
       
        return view
    }()

    
    @objc func helpClickT() {
        if let delegate = self.homeEventDelegate {
            delegate.helpClick()
        }
    }
    private lazy var helpBut: UIButton = {
        let but = CreateBaseView.makeBut("借款帮助", .white, kT333, UIFont.sx.font_t16)
//        but.setTitle("借款帮助", for: .selected)
        but.addTarget(self, action: #selector(helpClickT), for: .touchUpInside)
        but.layer.cornerRadius = sxDynamic(8)
        
        return but
    }()
    
    @objc func fagzhaClickT() {
        if let delegate = self.homeEventDelegate {
            delegate.guideClick()
        }
    }
    private lazy var fangzhaBut: UIButton = {
        let but =  CreateBaseView.makeBut("防诈指南", .white, kT333, UIFont.sx.font_t16)
//        but.setTitle("防诈指南", for: .selected)
        but.addTarget(self, action: #selector(fagzhaClickT), for: .touchUpInside)
        but.layer.cornerRadius = sxDynamic(8)
        
        return but
    }()
}
