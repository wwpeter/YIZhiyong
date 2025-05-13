//
//  ShareAlertView.swift
//  SXProject
//
//  Created by 王威 on 2024/5/23.
//

import UIKit

typealias ShareAlertViewBlock = () -> Void
class ShareAlertView: UIView {

    var clickBlock: ShareAlertViewBlock?
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
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
    func setTitle(_ title: String, sub: String) {
        titleLabel.text = title
        subTitleLabel.text = sub
    }
    
    func exchangeColcr() {
        submitBut.submitBut.isUserInteractionEnabled = false
        submitBut.exchangeColor(can: false)
        submitBut.exchangeTitle(title: "message_receive_sul".sx_T)
    }
    // initializa
    func initViews() {
        self.backgroundColor = AssetColors.b00030.color
        self.addSubview(contentView)
        self.contentView.addSubview(titleLabel)
        contentView.addSubview(centerView)
        contentView.addSubview(subTitleLabel)
        self.contentView.addSubview(submitBut)
        addSubview(clickView)
       
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(dismiss))
        
        clickView.addGestureRecognizer(tap)
    }
    
    func initViewLayouts() {
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(sxDynamic(0))
            make.trailing.equalTo(sxDynamic(0))
            make.height.equalTo(sxDynamic(340))
            make.bottom.equalTo(self.snp.bottom)
        }
        centerView.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(sxDynamic(190))
            make.width.equalTo(sxDynamic(160))
            make.top.equalTo(contentView.snp.top).offset(sxDynamic(-29))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(centerView.snp.centerX)
            make.top.equalTo(centerView.snp.bottom).offset(sxDynamic(15))
        }
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(centerView.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(15))
        }
       
        submitBut.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(sxDynamic(30))
            make.trailing.equalTo(contentView.snp.right).offset(sxDynamic(-30))
            make.height.equalTo(sxDynamic(45))
            make.bottom.equalTo(contentView.snp.bottom).offset(sxDynamic(-34))
        }
        clickView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(0)
            make.bottom.equalTo(centerView.snp.top)
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
            self.contentView.alpha = 0.0
        } completion: { finished in
            self.removeFromSuperview()
        }
    }
    
    // getter
    private lazy var clickView: UIView = {
        let view = UIView()
        
        return view
    }()
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = sxDynamic(16)
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.backgroundColor = .white
        
        return contentView
    }()
    private lazy var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = kBF2
        view.layer.cornerRadius = sxDynamic(16)
        
        return view
    }()
    
    
    private lazy var titleLabel: UILabel = {
        let contentLabel = CreateBaseView.makeLabel("--", UIFont.sx.font_t16, kT333, .center, 0)
        
        return contentLabel
    }()
    private lazy var subTitleLabel: UILabel = {
        let contentLabel = CreateBaseView.makeLabel("--", UIFont.sx.font_t13, kT333, .center, 0)
        
        return contentLabel
    }()
    
    private lazy var submitBut: GradationView = {
        let submitBut = GradationView()
        submitBut.exchangeTitle(title: "message_receive_title".sx_T)
        submitBut.submitBut.addTarget(self, action: #selector(click), for: .touchUpInside)
        
        return submitBut
    }()
    
    
    // MAKR: - 事件
    @objc
    func click() {
        guard let clickBlock = clickBlock else {
            return
        }
        clickBlock()
        self.dismiss()
    }
    
    @objc
    func cancelClick() {
        self.dismiss()
    }
}
