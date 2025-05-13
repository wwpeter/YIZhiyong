//
//  HomeBottomNewView.swift
//  SXProject
//
//  Created by 王威 on 2025/4/25.
//

import UIKit

class HomeBottomNewView: UIView {

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
        addSubview(groundView)
        groundView.addSubview(titleLabel)
    }
    
    func initViewLayouts() {
        groundView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(groundView.snp.leading).offset(sxDynamic(20))
            make.trailing.equalTo(groundView.snp.trailing).offset(sxDynamic(-20))
            make.centerY.equalTo(groundView.snp.centerY)
        }
    }
    
    //MARK: - getter
    
    private lazy var groundView: UIView = {
        let view = UIView ()
        view.layer.cornerRadius = sxDynamic(16)
        view.clipsToBounds = true
        view.backgroundColor = .white
        
        
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("郑重声明\n\n本平台为金融信息平台,所有贷款在未成功放款前，绝不收取任何费用\n\n 请根据个人能力合理贷款，理性消费，避免逾期 \n\n 客服热线:0571-22930325\n\n闽ICP备2025089972号\n\n福建志鸿融资担保有限公司\n\n资金来源：南宁市富利小额贷款有限公司", UIFont.sx.font_t13, kT333, .center, 0)
        
        return label
    }()
}
