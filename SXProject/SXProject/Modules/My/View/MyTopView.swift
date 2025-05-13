//
//  MyTopView.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

enum MyTopViewType: String, Codable {
    case headImg = "img"
    case setting = "setting"
    case loanRecord = "loan"
    case repaymentRecord = "record"
}

typealias myTopViewBlock = (_ type: MyTopViewType) -> (Void)

class MyTopView: UIView {

    var topBlock: myTopViewBlock?
    
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
    
    func setTitle(title: String) {
        nameLabel.text = title
    }
    
    //MARK: - initialize
    func initViews() {
        addSubview(groundImg)
        addSubview(settingImg)
        
        addSubview(headImg)
        addSubview(nameLabel)
        
        addSubview(leftView)
        addSubview(rightView)
        
    }
    
    func initViewLayouts() {
        groundImg.snp.makeConstraints { make in
            make.left.top.right.equalTo(0)
            make.height.equalTo(sxDynamic(305))
        }
        settingImg.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(22))
            make.top.equalTo(self.snp.top).offset(sxDynamic(12) + kStatusBarHeight)
            make.right.equalTo(self.snp.right).offset(sxDynamic(-20))
        }
        
        headImg.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(80))
            make.top.equalTo(settingImg.snp.bottom).offset(sxDynamic(5))
            make.left.equalTo(self.snp.left).offset(sxDynamic(20))
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(headImg.snp.centerY)
            make.left.equalTo(headImg.snp.right).offset(sxDynamic(5))
            make.right.equalTo(self.snp.right)
        }
        
        leftView.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(sxDynamic(20))
            make.right.equalTo(self.snp.centerX).offset(sxDynamic(-10))
            make.height.equalTo(sxDynamic(72))
            make.top.equalTo(headImg.snp.bottom).offset(sxDynamic(30))
        }
        
        rightView.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right).offset(sxDynamic(-20))
            make.left.equalTo(self.snp.centerX).offset(sxDynamic(10))
            make.height.equalTo(sxDynamic(72))
            make.top.equalTo(headImg.snp.bottom).offset(sxDynamic(30))
        }
    }
    
    //MARK: - getter
    
    @objc func headTapClick() {
        guard let blockT = topBlock else { return}
        blockT(.headImg)
    }
    
    private lazy var groundImg: UIImageView = {
        let img = CreateBaseView.makeIMG("my_ground_img", .scaleToFill)
        img.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(headTapClick))
        img.addGestureRecognizer(tap)
        
        return img
    }()
    
    @objc func settingTapClick() {
        guard let blockT = topBlock else { return}
        blockT(.setting)
    }
    
    private lazy var settingImg: UIImageView = {
        let img = CreateBaseView.makeIMG("setting_img", .scaleToFill)
        img.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(settingTapClick))
        img.addGestureRecognizer(tap)
        
        return img
    }()
    
    private lazy var headImg: UIImageView = {
        let img = CreateBaseView.makeIMG("heand_img", .scaleAspectFit)
        
        return img
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel =  CreateBaseView.makeLabel("--", UIFont.sx.font_t24Blod, kT333, .left, 1)
        
        return nameLabel
    }()
    
    @objc func leftTapClick() {
        guard let blockT = topBlock else { return}
        blockT(.loanRecord)
    }
    
    private lazy var leftView: TopItemView = {
        let view = TopItemView()
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(leftTapClick))
        
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    @objc func rightTapClick() {
        guard let blockT = topBlock else { return}
        blockT(.repaymentRecord)
    }
    
    private lazy var rightView: TopItemView = {
        let view = TopItemView()
        view.exchangeTitle(title: "还款记录", icon: "huank_img")
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(rightTapClick))
        
        view.addGestureRecognizer(tap)
        
        return view
    }()
}
