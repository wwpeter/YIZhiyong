//
//  BottomView.swift
//  SXProject
//
//  Created by 王威 on 2025/3/26.
//

import UIKit

typealias BottomViewBlock = () -> Void

typealias BottomViewSelBlock = (_ sel: Bool) -> Void
class BottomView: UIView {

    var submitBlock: BottomViewBlock?
    var selBlock: BottomViewSelBlock?
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
    
    //MARK: - action
    @objc func addSubmit() {
        guard let blockT = submitBlock else {return}
        blockT()
    }
    
    @objc
    func agreeClick(button: UIButton) {
        button.isSelected = !button.isSelected
      
        guard let blockT = selBlock else {return}
        blockT(button.isSelected)
    }
    
    @objc
    func agreeClickT(button: UIControl) {
        button.isSelected = !button.isSelected
      
        selectedBut.isSelected = button.isSelected
        
        guard let blockT = selBlock else {return}
        blockT(button.isSelected)
    }
    
    @objc func dealClick() {
        let dsweb = DsWebController()
   
        dsweb.url = String.init(format: "%@%@", kWebUrlBase, kAgreementShare)
        
        DHRouterUtil.getCurrentVc()?.navigationController?.pushViewController(dsweb, animated: true)
    }
    
    //MARK: - initialize
    func initViews() {
        addSubview(submitBut)
        addSubview(selectedBut)
        addSubview(subLabel)
        
        addSubview(ctr)
        
        addSubview(gerenCtr)
        
//        addSubview(subLabelT)
    }
    
    func initViewLayouts() {
        submitBut.snp.makeConstraints { make in
            make.top.equalTo(0)
            make.left.equalTo(self.snp.left).offset(sxDynamic(20))
            make.right.equalTo(self.snp.right).offset(sxDynamic(-20))
            make.height.equalTo(sxDynamic(45))
        }
        selectedBut.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(22))
            make.left.equalTo(submitBut.snp.left)
            make.top.equalTo(submitBut.snp.bottom).offset(sxDynamic(10))
        }
        
        ctr.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(30))
            make.width.equalTo(sxDynamic(100))
            make.left.equalTo(submitBut.snp.left)
            make.top.equalTo(submitBut.snp.bottom).offset(sxDynamic(5))
        }
      
        subLabel.snp.makeConstraints { make in
            make.leading.equalTo(selectedBut.snp.trailing).offset(sxDynamic(5))
            make.centerY.equalTo(selectedBut.snp.centerY)
            make.height.equalTo(sxDynamic(18))
        }
        
        gerenCtr.snp.makeConstraints { make in
            make.left.equalTo(subLabel.snp.centerX).offset(sxDynamic(-15))
            make.height.equalTo(sxDynamic(30))
            make.right.equalTo(subLabel.snp.right)
            make.centerY.equalTo(subLabel.snp.centerY)
        }
//        subLabelT.snp.makeConstraints { make in
//            make.leading.equalTo(selectedBut.snp.trailing).offset(sxDynamic(5))
//            make.top.equalTo(subLabel.snp.bottom).offset(sxDynamic(5))
//            make.right.equalTo(self.snp.right).offset(sxDynamic(-20))
//        }
    }

    
    //MARK: - getter
    private lazy var ctr: UIControl = {
        let ctr = UIControl()
        ctr.addTarget(self, action: #selector(agreeClickT), for: .touchUpInside)
        
        return ctr
    }()
    
    private lazy var selectedBut: UIButton = {
        let but = UIButton.init(type: .custom)
        but.setImage(UIImage(named: "iot_login_check") , for: .normal)
        but.setImage(UIImage(named: "login_selected") , for: .selected)
        but.addTarget(self, action: #selector(agreeClick(button:)), for: .touchUpInside)
        
        return but
    }()
    
    private lazy var submitBut: UIButton = {
        let but = CreateBaseView.makeBut("立即申请", kTBlue, kWhite, UIFont.sx.font_t16Blod)
        but.layer.cornerRadius = sxDynamic(22)
        but.addTarget(self, action: #selector(addSubmit), for: .touchUpInside)
        
        return but
    }()
    
    private lazy var subLabel: UILabel = {
        let label = CreateBaseView.makeLabel("我已阅读并同意《个人信息共享授权协议》", UIFont.sx.font_t13, kT777, .center, 1)
        
        return label
    }()
    
    private lazy var gerenCtr: UIControl = {
        let ctr = UIControl()
        ctr.addTarget(self, action: #selector(dealClick), for: .touchUpInside)
        
        return ctr
    }()
    
    private lazy var subLabelT: UILabel = {
        let label = CreateBaseView.makeLabel("请根据个人能力合理贷款，理性消费，避免逾期 贷款额度，放款时间以实际审批结果为准 郑重声明：本平台为金融中介平台，只提供贷款咨询和推荐服务，不向 未成年人 及大学生服务，所有贷款在未成功放款前，绝不收取任何费用。为了保障您的资金安全，请不要相信任何要求您支付费用的消息、电话等不实信息。 客服热线：0571-22930325 闽ICP备2025089972号 福建志鸿融资担保有限公司 专业助贷平台 ", UIFont.sx.font_t13, kT777, .center, 0)
        
        return label
    }()
}
