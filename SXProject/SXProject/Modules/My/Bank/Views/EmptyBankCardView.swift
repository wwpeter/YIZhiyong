//
//  EmptyBankCardView.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

class EmptyBankCardView: UIView {

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
        addSubview(iconImg)
        addSubview(titleLabel)
        addSubview(addCardBut)
    }
    
    func initViewLayouts() {
        iconImg.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(200))
            make.top.equalTo(0)
            make.centerX.equalTo(self.snp.centerX)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(iconImg.snp.bottom).offset(sxDynamic(5))
            make.height.equalTo(18)
        }
        addCardBut.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(42))
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(30))
            make.width.equalTo(sxDynamic(95))
        }
    }
    
    //MARK: - getter
    private lazy var iconImg: UIImageView = {
        let img = CreateBaseView.makeIMG("no_bank_card", .scaleAspectFit)
        
        
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("暂无可用银行卡", UIFont.sx.font_t12, kT777, .center, 1)
        
        return label
    }()
    
    lazy var addCardBut: UIButton = {
        let but = CreateBaseView.makeBut("添加银行卡", .white, kTBlue, UIFont.sx.font_t13)
        but.layer.cornerRadius = sxDynamic(21)
        but.layer.borderWidth = sxDynamic(1)
        but.layer.borderColor = kTBlue.cgColor
        
        return but
    }()
}
