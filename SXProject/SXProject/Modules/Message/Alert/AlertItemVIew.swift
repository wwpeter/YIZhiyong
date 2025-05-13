//
//  AlertItemVIew.swift
//  SXProject
//
//  Created by 王威 on 2024/5/23.
//

import UIKit

class AlertItemVIew: UIView {
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
    
    //MAKR: - acionts
    func hiddenRright(_ hide: Bool) {
        rightIMG.isHidden = hide
    }
    
    func exchangeTitle(_ title: String, _ sub: String) {
        titleLabel.text = title
        subLabel.text = sub
    }
    
    func exchangeCenterTitle(_ title: String) {
        titleLabel.text = title
        titleLabel.snp.remakeConstraints { make in
            make.leading.equalTo(leftIcon.snp.trailing).offset(sxDynamic(10))
            make.centerY.equalTo(contentView.snp.centerY)
        }
    }
    
    //MARK: - initialize
    func initViews() {
        addSubview(contentView)
        addSubview(leftIcon)
        addSubview(titleLabel)
        addSubview(subLabel)
        addSubview(rightIMG)
    }
    
    func initViewLayouts() {
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        leftIcon.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).offset(sxDynamic(15))
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(sxDynamic(34))
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftIcon.snp.trailing).offset(sxDynamic(10))
            make.top.equalTo(leftIcon.snp.top)
            
        }
        subLabel.snp.makeConstraints { make in
            make.leading.equalTo(leftIcon.snp.trailing).offset(sxDynamic(10))
            make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(3))
        }
        rightIMG.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(sxDynamic(8))
            make.height.equalTo(sxDynamic(14))
            make.trailing.equalTo(contentView.snp.trailing).offset(sxDynamic(-15))
        }
    }
    
    //MARK: - getter
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = kWhite
        view.layer.cornerRadius = sxDynamic(8)
        
        return view
    }()
    private lazy var leftIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "online_customer")
        img.contentMode = .scaleAspectFit
        
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("", UIFont.sx.font_t11, kT777, .left, 1)
        
        return label
    }()
    
    private lazy var subLabel: UILabel = {
        let label = CreateBaseView.makeLabel("".sx_T, UIFont.sx.font_t11, kTBlue, .left, 1)
        
        return label
    }()
    
    private lazy var rightIMG: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "cell_right")
        
        return img
    }()
    
    
}
