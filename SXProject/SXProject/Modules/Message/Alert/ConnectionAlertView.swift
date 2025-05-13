//
//  ConnectionAlertView.swift
//  SXProject
//
//  Created by 王威 on 2024/5/23.
//

import UIKit

typealias ConnectionAlertViewBlock = (_ type: String) -> Void
class ConnectionAlertView: UIView {

    var connectionBlock: ConnectionAlertViewBlock?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
        getDataSource()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.initViewLayouts()
    }
    
    //MAKR: - actions
    func getDataSource() {
        //
        let param = ["time":""] as [String : String]
        
        //kStatuPath
//        NetworkRequestManager.sharedInstance().requestPath(kCustomerInfo, withParam: param) { [weak self] result in
//            printLog(result)
//            //变成字典
//            
//          
//                let dic = JSONHelper.exchangeDic(jsonStr: result)
//                let phone = dic["phone"]
//                let email = dic["email"]
//                let url = dic["url"]
////                self?.itemOne.exchangeCenterTitle(<#T##title: String##String#>)
//                self?.itemTwo.exchangeTitle("hote_line".sx_T, phone as? String ?? "")
//                self?.itemThree.exchangeTitle("official_website".sx_T, url as? String ?? "")
//     
//          
//        } failure: { error in
//            
//        }
    }
    // initializa
    func initViews() {
        self.backgroundColor = AssetColors.b00030.color
        self.addSubview(contentView)
        
        contentView.addSubview(goundIMG)
        contentView.addSubview(titleView)
        self.contentView.addSubview(titleLabel)
        
        contentView.addSubview(itemOne)
        contentView.addSubview(itemTwo)
        contentView.addSubview(itemThree)
        
        addSubview(colseBut)
    }
    
    func initViewLayouts() {
        itemOne.snp.makeConstraints { make in
            
        }
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(sxDynamic(40))
            make.trailing.equalTo(sxDynamic(-40))
            make.height.equalTo(sxDynamic(337))
            make.top.equalTo(self.snp.centerY).offset(sxDynamic(-170))
        }
        goundIMG.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(sxDynamic(20))
           
            make.top.equalTo(contentView.snp.top).offset(sxDynamic(30))
        }
        
        titleView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.height.equalTo(sxDynamic(9))
            make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(-4))
        }
        
        itemOne.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(sxDynamic(20))
            make.trailing.equalTo(contentView.snp.trailing).offset(sxDynamic(-20))
            make.top.equalTo(titleView.snp.bottom).offset(sxDynamic(20))
            make.height.equalTo(sxDynamic(64))
        }
        itemTwo.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(sxDynamic(20))
            make.trailing.equalTo(contentView.snp.trailing).offset(sxDynamic(-20))
            make.top.equalTo(itemOne.snp.bottom).offset(sxDynamic(15))
            make.height.equalTo(sxDynamic(64))
        }
        itemThree.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(sxDynamic(20))
            make.trailing.equalTo(contentView.snp.trailing).offset(sxDynamic(-20))
            make.top.equalTo(itemTwo.snp.bottom).offset(sxDynamic(15))
            make.height.equalTo(sxDynamic(64))
        }
        colseBut.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(sxDynamic(24))
            make.width.equalTo(sxDynamic(24))
            make.top.equalTo(contentView.snp.bottom).offset(sxDynamic(20))
        }
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
            self.contentView.alpha = 0.4
        } completion: { finished in
            self.removeFromSuperview()
        }
    }
    
    @objc func click1() {
        guard let blockT = connectionBlock else {
            return
        }
        blockT("online")
        dismiss()
    }
    @objc func click2() {
        guard let blockT = connectionBlock else {
            return
        }
        blockT("phone")
        dismiss()
    }
    @objc func click3() {
        guard let blockT = connectionBlock else {
            return
        }
        blockT("website")
        dismiss()
    }
    
    // getter
    private lazy var clickView: UIView = {
        let view = UIView()
        
        return view
    }()
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = sxDynamic(8)
//        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = .white
        
        return contentView
    }()
    private lazy var goundIMG: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "contact_us")
        
        return img
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let contentLabel = CreateBaseView.makeLabel("message_contact_us".sx_T, UIFont.sx.font_t24Blod, kT333, .center, 0)
        
        return contentLabel
    }()
    
    private lazy var titleView: UIView = {
        let view = UIView()
        view.backgroundColor = AssetColors.b2564Ff10.color
        
        return view
    }()
  
    
    private lazy var colseBut: UIButton = {
        let submitBut = CreateBaseView.makeBut("alert_close")
        submitBut.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        
        return submitBut
    }()
    
    private lazy var itemOne: AlertItemVIew = {
        let view = AlertItemVIew()
        view.exchangeCenterTitle("online_title".sx_T)
    
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(click1))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private lazy var itemTwo: AlertItemVIew = {
        let view = AlertItemVIew()
        view.exchangeTitle("hote_line".sx_T, kHotLine)
      
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(click2))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private lazy var itemThree: AlertItemVIew = {
        let view = AlertItemVIew()
        view.exchangeTitle("official_website".sx_T, kOfficialWebsite)
  
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(click3))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    
    // MAKR: - 事件
    @objc
    func click() {
     
        self.dismiss()
    }
    
    @objc
    func cancelClick() {
        self.dismiss()
    }
    

}
