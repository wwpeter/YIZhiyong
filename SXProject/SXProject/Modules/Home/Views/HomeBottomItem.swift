//
//  HomeBottomItem.swift
//  SXProject
//
//  Created by 王威 on 2025/1/6.
//

import UIKit

class HomeBottomItem: UIView {

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
        addSubview(subLabel)
    }
    
    func initViewLayouts() {
        iconImg.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(48))
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(0)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImg.snp.bottom).offset(sxDynamic(5))
            make.centerX.equalTo(self.snp.centerX)
        }
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(5))
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    func exchangeType(type: Int) {
        if type == 2 {
            iconImg.image = UIImage(named: "home_bottom_center")
            titleLabel.text = "持牌机构"
            subLabel.text = "正规持牌机构"
        } else if type == 3 {
            iconImg.image = UIImage(named: "home_bottom_right")
            titleLabel.text = "信息安全"
            subLabel.text = "全程加密"
        }
       
    }
    
    //MARK: - getter
    private lazy var iconImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "home_bottom_left")
        
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("息费透明", UIFont.sx.font_t13, kT333, .center, 1)
        
        return label
    }()
    private lazy var subLabel: UILabel = {
        let label = CreateBaseView.makeLabel("无套路 息费可查", UIFont.sx.font_t12, kT777, .center, 1)
        
        return label
    }()
}
