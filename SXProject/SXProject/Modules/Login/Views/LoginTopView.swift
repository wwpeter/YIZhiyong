//
//  LoginTopView.swift
//  SXProject
//
//  Created by 王威 on 2025/2/22.
//

import UIKit

class LoginTopView: UIView {

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
        addSubview(topGroundView)
        addSubview(iconImg)
        addSubview(titleLabel)
        addSubview(subLabel)
    }
    
    func initViewLayouts() {
      
        subLabel.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(20))
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(topGroundView.snp.bottom).offset(sxDynamic(-7))
        }
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(subLabel.snp.top).offset(sxDynamic(-10))
            make.centerX.equalTo(self.snp.centerX)
            make.height.equalTo(sxDynamic(22))
        }
        iconImg.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(110))
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(titleLabel.snp.top).offset(sxDynamic(-10))
        }
    }
    
    //MARK: - getter
    
    private lazy var topGroundView: UIView = {
        let view = UIView()
        view.frame = CGRectMake(0, 0, kSizeScreenWidth, sxDynamic(290))
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.sx.gradientColor(AssetColors.bdfeafd.color, kWhite, CGPoint(x: 0, y: 0), CGPoint(x: 0, y: 1))
        
        return view
    }()
    
    private lazy var iconImg: UIImageView = {
        let img = CreateBaseView.makeIMG("project_icon", .scaleAspectFit)
        
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("欢迎注册/登录易支用", UIFont.sx.font_t16Blod, kT333, .center, 1)
        
        return label
    }()
    
    private lazy var subLabel: UILabel = {
        let label = CreateBaseView.makeLabel("本人实名认证手机号码登录", UIFont.sx.font_t13, kT777, .center, 1)
        
        return label
    }()
}
