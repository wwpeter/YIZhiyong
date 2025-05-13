//
//  CommonAlert.swift
//  SXProject
//
//  Created by 王威 on 2024/5/16.
//
// 带输入框的 弹窗

import UIKit

typealias CommonAlertBlock = (_ name: String) -> Void
class CommonAlert: UIView, UITextFieldDelegate {
 
    var clickBlock: CommonAlertBlock?
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
    
    //MAKR: - 设备分享
    func dealShareDevice() {
        textField.placeholder = "device_share_account".sx_T
        titleLabel.text = "account_share".sx_T
    }
    
    //MARK: - 设备重名名
    func resetName() {
        titleLabel.text = "device_reset_name".sx_T
        textField.placeholder = "device_input_nikname".sx_T
    }
    
    func setRoomName() {
        titleLabel.text = "set_roomtitle".sx_T
        textField.placeholder = "set_room_name".sx_T
    }
    
    //MAKR: - actions
    func setTitle(_ title: String, placeholder: String) {
        titleLabel.text = title
        textField.placeholder = placeholder
    }
    // initializa
    func initViews() {
        self.backgroundColor = AssetColors.b00030.color
        self.addSubview(contentView)
        self.contentView.addSubview(titleLabel)
        contentView.addSubview(centerView)
        contentView.addSubview(textField)
        self.contentView.addSubview(submitBut)
        self.contentView.addSubview(cancleBut)
    }
    
    func initViewLayouts() {
        contentView.snp.makeConstraints { make in
            make.leading.equalTo(sxDynamic(20))
            make.trailing.equalTo(sxDynamic(-20))
            make.height.equalTo(sxDynamic(170))
            make.centerY.equalTo(self.snp.centerY).offset(-20)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.top.equalTo(contentView.snp.top).offset(sxDynamic(15))
        }
        cancleBut.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(18))
            make.top.equalTo(contentView.snp.top).offset(sxDynamic(10))
            make.trailing.equalTo(contentView.snp.trailing).offset(sxDynamic(-10))
        }
        submitBut.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.height.equalTo(sxDynamic(60))
            make.bottom.equalTo(contentView.snp.bottom)
        }
        centerView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.height.equalTo(sxDynamic(42))
            make.leading.equalTo(contentView.snp.leading).offset(sxDynamic(20))
            make.trailing.equalTo(contentView.snp.trailing).offset(sxDynamic(-20))
        }
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(centerView.snp.centerY)
            make.leading.equalTo(centerView.snp.leading).offset(sxDynamic(20))
            make.trailing.equalTo(centerView.snp.trailing).offset(sxDynamic(-20))
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
    
    func dismiss() {
        UIView.animate(withDuration: 0.4) {
//            self.contentView.transform = CGAffineTransformMakeScale
            self.contentView.alpha = 0.0
        } completion: { finished in
            self.removeFromSuperview()
        }
    }
    
    // getter
    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.layer.cornerRadius = sxDynamic(15)
        contentView.backgroundColor = .white
        
        return contentView
    }()
    private lazy var centerView: UIView = {
        let view = UIView()
        view.backgroundColor = kBF2
        view.layer.cornerRadius = sxDynamic(8)
        
        return view
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "".sx_T
        textField.keyboardType = .default
//        textField.borderStyle = .roundedRect
        textField.delegate = self
        
        return textField
    }()

    
    private lazy var titleLabel: UILabel = {
        let contentLabel = CreateBaseView.makeLabel("--", UIFont.sx.font_t15, kT333, .center, 0)
        
        return contentLabel
    }()
    
    private lazy var submitBut: UIButton = {
        let submitBut = CreateBaseView.makeBut("iot_login_submit".sx_T, .clear, kTBlue, UIFont.sx.font_t15)
        submitBut.addTarget(self, action: #selector(click), for: .touchUpInside)
        submitBut.backgroundColor = .clear
        
        return submitBut
    }()
    
    private lazy var cancleBut: UIButton = {
        let cancleBut = CreateBaseView.makeBut("update_close")
        cancleBut.addTarget(self, action: #selector(cancelClick), for: .touchUpInside)
        cancleBut.backgroundColor = .clear
        
        return cancleBut
    }()
    
    // MAKR: - 事件
    @objc
    func click() {
        guard let clickBlock = clickBlock else {
            return
        }
        clickBlock(textField.text ?? "")
        self.dismiss()
    }
    
    @objc
    func cancelClick() {
        self.dismiss()
    }
}
