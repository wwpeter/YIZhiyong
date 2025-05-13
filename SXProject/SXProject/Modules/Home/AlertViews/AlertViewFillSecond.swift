//
//  AlertViewFillSecond.swift
//  SXProject
//
//  Created by 王威 on 2025/2/23.
//

import UIKit

/// 1 关闭 2 继续 3 是的
typealias AlertViewFillSecondBlock = (_ type: String) -> Void

class AlertViewFillSecond: UIView {
    
    var typeBlock: AlertViewFillSecondBlock?

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
        contentView.addSubview(groundImg)
        contentView.addSubview(closeBut)
        contentView.addSubview(titleLabel)
        contentView.addSubview(submitBut)
        contentView.addSubview(cancleBut)
    }
    
    func initViewLayouts() {
        contentView.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(sxDynamic(248))
            make.width.equalTo(sxDynamic(260))
        }
        groundImg.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo((contentView.snp.right))
            make.height.equalTo(sxDynamic(174))
            make.top.equalTo(contentView.snp.top).offset(sxDynamic(-14))
        }
        closeBut.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(24))
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-20))
            make.top.equalTo(contentView.snp.top).offset(sxDynamic(15))
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY).offset(sxDynamic(-30))
            make.height.equalTo(sxDynamic(22))
        }
        submitBut.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(45))
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.snp.bottom).offset(sxDynamic(-67))
            make.width.equalTo(sxDynamic(200))
        }
        cancleBut.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(45))
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(submitBut.snp.bottom).offset(sxDynamic(10))
            make.width.equalTo(sxDynamic(200))
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
    
    @objc func submitClick() {
        guard let block = typeBlock else {return}
        block("2")
        self.dismiss()
    }
    @objc func cancleClick() {
        guard let block = typeBlock else {return}
        block("3")
        self.dismiss()
    }
    
    @objc func closeClick(){
        guard let block = typeBlock else {return}
        block("1")
        
        self.dismiss()
    }
    
    //MARK: - getter
    private lazy var closeBut: UIButton = {
        let but = CreateBaseView.makeBut("alert_close")
        but.addTarget(self, action: #selector(closeClick), for: .touchUpInside)
        
        return but
    }()
    
    private lazy var groundImg: UIImageView = {
        let img = CreateBaseView.makeIMG("alertView_ground", .scaleAspectFit)
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("是否放弃提交个人需求", UIFont.sx.font_t16Blod, kT333, .center, 1)
        
        return label
    }()
    
    private lazy var submitBut: UIButton = {
        let but = CreateBaseView.makeBut("否，继续填写", kTBlue, kWhite,  UIFont.sx.font_t16Blod)
        but.layer.cornerRadius = sxDynamic(22.5)
        but.addTarget(self, action: #selector(submitClick), for: .touchUpInside)
        
        return but
    }()
    
    private lazy var cancleBut: UIButton = {
        let but = CreateBaseView.makeBut("是的", kWhite, kTaaa, UIFont.sx.font_t16)
        but.addTarget(self, action: #selector(cancleClick), for: .touchUpInside)
        
        return but
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = sxDynamic(16)
//        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = .white
        
        return contentView
    }()
    
}
