//
//  TopViewDetailView.swift
//  SXProject
//
//  Created by 王威 on 2025/2/23.
//

import UIKit

class TopViewDetailView: UIView {

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
    
    func exchangeFaild() {
        centerLabel.text = "很抱歉您的预审未通过"
        centerSub.text = ""
        iconImg.image = UIImage(named: "fail_submit")
        
    }
    
    //MARK: - initialize
    func initViews() {
        addSubview(groundImg)
        
        addSubview(backBut)
        addSubview(titleLabel)
        addSubview(topView)
        addSubview(topLabel)
        
        addSubview(iconImg)
        addSubview(centerLabel)
        addSubview(centerSub)
        
        
    }
    
    func initViewLayouts() {
        groundImg.snp.makeConstraints { make in
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
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(backBut.snp.bottom).offset(sxDynamic(24))
            make.left.equalTo(groundImg.snp.left).offset(sxDynamic(15))
            make.right.equalTo(groundImg.snp.right).offset(sxDynamic(-15))
            make.height.equalTo(sxDynamic(30))
        }
        topLabel.snp.makeConstraints { make in
            make.left.equalTo(topView.snp.left).offset(sxDynamic(20))
            make.centerY.equalTo(topView.snp.centerY)
            make.right.equalTo(topView.snp.right).offset(sxDynamic(-10))
        }
        
        iconImg.snp.makeConstraints { make in
            make.width.equalTo(sxDynamic(80))
            make.height.equalTo(sxDynamic(50))
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(topView.snp.bottom).offset(sxDynamic(20))
        }
        centerLabel.snp.makeConstraints { make in
            make.top.equalTo(iconImg.snp.bottom).offset(sxDynamic(20))
            make.centerX.equalTo(self.snp.centerX)
        }
        centerSub.snp.makeConstraints { make in
            make.top.equalTo(centerLabel.snp.bottom).offset(sxDynamic(5))
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    //MARK: - getter
    lazy var backBut: UIButton = {
        let but = CreateBaseView.makeBut("white_back")
        
        return but
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("申请详情", UIFont.sx.font_t18Blod, kWhite, .center, 1)
        
        return label
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = AssetColors.bfff20.color
        view.layer.cornerRadius = sxDynamic(8)
        
        return view
    }()
    private lazy var topLabel: UILabel = {
        let label = CreateBaseView.makeLabel("申请过程中，无需任何费用请您务必知晓，谨防诈骗", UIFont.sx.font_t13, kWhite, .left, 1)
        
        return label
    }()
    private lazy var iconImg: UIImageView = {
        let iconImg = CreateBaseView.makeIMG("suc_icon", .scaleAspectFit)
        
        return iconImg
    }()
    private lazy var centerLabel: UILabel = {
        let label = CreateBaseView.makeLabel("预审通过", UIFont.sx.font_t20Blod, kWhite, .center, 1)
        
        return label
    }()
    private lazy var centerSub: UILabel = {
        let label = CreateBaseView.makeLabel("请耐心等待咨询电话", UIFont.sx.font_t15, kWhite, .center, 1)
        
        return label
    }()
    
    
    private lazy var groundImg: UIImageView = {
        let img = CreateBaseView.makeIMG("detail_icon", .scaleAspectFit)
        img.contentMode = .scaleAspectFit
        
        return img
    }()
}
