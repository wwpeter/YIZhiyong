//
//  TopCenterView.swift
//  SXProject
//
//  Created by 王威 on 2025/1/6.
//

import UIKit

class TopCenterView: UIView {

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
    
    func setRate(rate: String, loanTime: String) {
        subLabel1.text = String.init(format: "年利率低至:%@%起", rate)
        subLabel2.text = String.init(format: "借款期限:%@期", loanTime)
    }
    
    //MARK: - initialize
    func initViews() {
      
        addSubview(moneyImg)
        addSubview(titleMoney)
        addSubview(moneyIcon)
        
        addSubview(gradationView)
        addSubview(subLabel1)
        addSubview(subLabel2)
        
        addSubview(submitImg)
        
        addSubview(bottomLabel)
    }
    
    func initViewLayouts() {
        moneyImg.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        titleMoney.snp.makeConstraints { make in
            make.height.equalTo(sxDynamic(20))
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(moneyImg.snp.top).offset(sxDynamic(30))
        }
        moneyIcon.snp.makeConstraints { make in
            make.top.equalTo(titleMoney.snp.bottom).offset(sxDynamic(15))
            make.height.equalTo(sxDynamic(60))
            make.width.equalTo(sxDynamic(259))
            make.centerX.equalTo(self.snp.centerX)
        }
        
        subLabel1.snp.makeConstraints { make in
            make.right.equalTo(self.snp.centerX).offset(sxDynamic(-13))
            make.height.equalTo(sxDynamic(20))
            make.centerY.equalTo(gradationView.snp.centerY)
            make.left.equalTo(gradationView.snp.left)
        }
        subLabel2.snp.makeConstraints { make in
            make.left.equalTo(self.snp.centerX).offset(sxDynamic(13))
            make.height.equalTo(sxDynamic(20))
            make.centerY.equalTo(gradationView.snp.centerY)
            make.right.equalTo(gradationView.snp.right)
        }
        submitImg.snp.makeConstraints { make in
            make.top.equalTo(gradationView.snp.bottom)
            make.height.equalTo(sxDynamic(62))
            make.left.equalTo(self.snp.left).offset(sxDynamic(28))
            make.right.equalTo(self.snp.right).offset(sxDynamic(-28))
        }
        bottomLabel.snp.makeConstraints { make in
            make.centerX.equalTo(submitImg.snp.centerX)
            make.top.equalTo(submitImg.snp.bottom)
        }
    }
    
    //MARK: - getter
    private lazy var moneyImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "home_money_ground")
        
        return img
    }()
    
    private lazy var titleMoney: UILabel = {
        let label = CreateBaseView.makeLabel("您的预估额度（元）", UIFont.sx.font_t13, AssetColors.t532B0B.color, .center, 1)
        
        return label
    }()
    
    private lazy var moneyIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "money_icon")
        img.contentMode = .scaleAspectFit
        img.isUserInteractionEnabled = true
        
        return img
    }()
    
    private lazy var gradationView: UIView = {
        let view = UIView()
        view.frame = CGRectMake(sxDynamic(38), sxDynamic(138), kSizeScreenWidth - sxDynamic(116), sxDynamic(30))
        view.sx.gradientColor(AssetColors.bfcf3E1.color, AssetColors.bf7E4Bf.color, CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 0))
        
        
        return view
    }()
    
    private lazy var subLabel1: UILabel = {
        let label = CreateBaseView.makeLabel("年利率低至:7%起", UIFont.sx.font_t13, AssetColors.t532B0B.color, .right, 1)
        
        return label
    }()
    
    private lazy var subLabel2: UILabel = {
        let label = CreateBaseView.makeLabel("借款期限:3-36期", UIFont.sx.font_t13, AssetColors.t532B0B.color, .left, 1)
        
        return label
    }()
    
     lazy var submitImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "money_submit")
        img.contentMode = .scaleAspectFit
         img.isUserInteractionEnabled = true
        
        return img
    }()
    
    private lazy var bottomLabel: UILabel = {
        let label = CreateBaseView.makeLabel("最终以审核利率为准", UIFont.sx.font_t11, AssetColors.tc4A264.color, .center, 1)
        
        return label
    }()
}
