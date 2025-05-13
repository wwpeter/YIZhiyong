//
//  TopGuideView.swift
//  SXProject
//
//  Created by 王威 on 2025/2/23.
//

import UIKit

class TopGuideView: UIView {

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
        addSubview(img)
        
        addSubview(titleLabel)
        addSubview(backBut)
        
    
        addSubview(leftIcon)
    }
    
    func initViewLayouts() {
        img.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(sxDynamic(13) + kStatusBarHeight)
        }
        backBut.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(sxDynamic(22))
            make.height.equalTo(sxDynamic(15))
            make.left.equalTo(self.snp.left).offset(sxDynamic(15))
        }
        
        leftIcon.snp.makeConstraints { make in
            make.left.equalTo(backBut.snp.right)
            make.top.equalTo(backBut.snp.bottom).offset(sxDynamic(28))
            make.height.equalTo(sxDynamic(26))
            make.width.equalTo(sxDynamic(127))
        }
    }
    
   
    //MARK: - getter
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("防诈指南", UIFont.sx.font_t18, kT333, .center, 1)
        
        return label
    }()
    
    lazy var backBut: UIButton = {
        let but = CreateBaseView.makeBut("navigationBack")
        
        
        return but
    }()
    
    private lazy var img: UIImageView = {
        let img = CreateBaseView.makeIMG("fangzha_back", .scaleAspectFill)
        
        return img
    }()
    
    private lazy var leftIcon: UIImageView = {
        let img = CreateBaseView.makeIMG("fangzhazhinan_icon", .scaleAspectFit)
        
        return img
    }()

}
