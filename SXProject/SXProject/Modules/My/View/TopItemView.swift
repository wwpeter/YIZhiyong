//
//  TopItemView.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

class TopItemView: UIView {

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
    
    func exchangeTitle(title: String, icon: String) {
        iconImg.image = UIImage(named: icon)
        titleLabel.text = title
    }
    
    //MARK: - initialize
    func initViews() {
        
        
        addSubview(groundView)
        groundView.addSubview(iconImg)
        groundView.addSubview(titleLabel)
    }
    
    func initViewLayouts() {
        groundView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        iconImg.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(44))
            make.centerY.equalTo(self)
            make.left.equalTo(groundView.snp.left).offset(sxDynamic(20))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(iconImg.snp.right).offset(sxDynamic(10))
            make.right.equalTo(groundView.snp.right)
        }
    }
    
    //MARK: - getter
    
    private lazy var groundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = sxDynamic(8)
        
        return view
    }()
    
    private lazy var iconImg: UIImageView = {
        let img = CreateBaseView.makeIMG("jiek_img", .scaleAspectFit)
        
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        if UserSingleton.shared.getHhtPageUrl() == "MJB" {
            let title = CreateBaseView.makeLabel("借款记录", UIFont.sx.font_t16Blod, kT333, .left, 1)
            return title
        } else {
            let title = CreateBaseView.makeLabel("申请记录", UIFont.sx.font_t16Blod, kT333, .left, 1)
            return title
        }       
    }()
}
