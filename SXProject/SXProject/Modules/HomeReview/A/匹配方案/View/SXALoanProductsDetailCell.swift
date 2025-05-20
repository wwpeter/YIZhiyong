//
//  SXALoanProductsDetailCell.swift
//  SXProject
//
//  Created by Felix on 2025/5/16.
//


import UIKit

class SXALoanProductsDetailCell: UITableViewCell {
    
    fileprivate var currentProductModel = SXACompanyProductModel()
    func updateCellWithModel(_ model:SXACompanyProductModel) {
        currentProductModel = model
        if let url = URL(string: model.url.urlEncoded()) {
            productIcon.kf.setImage(with: url, placeholder: DDSImage("a_compang_icon"), options: nil)
        }
        productNameLabel.text = model.productName
        
        eDuDaiDetailLabel.text = model.loanAmount
        yearDetailLabel.text = model.rate
        
        weekDetailLabel.text = model.loanTime
        huanDetailLabel.text = model.repayType
        self.loveIcon.setImage(model.collect ? DDSImage("product_love_1") : DDSImage("product_love_0"), for: .normal)
    }
    
    
    fileprivate lazy var productIcon:UIImageView = {
        let img = UIImageView()
        img.image = DDSImage("a_compang_icon")
        return img
    }()
    
    fileprivate lazy var productNameLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "产品名称"
        label1.font = DDSFont(16)
        label1.textColor = kT333
        return label1
    }()
    
    fileprivate lazy var loveIcon:UIButton = {
        let button = UIButton()
        button.setImage(DDSImage("product_love_0"), for: .normal)
        button.addTarget(self, action: #selector(doLoveProductAction), for: .touchUpInside)
        return button
    }()
    
    fileprivate lazy var loveTipsLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "收藏产品"
        label1.font = DDSFont(9)
        label1.textColor = kTaaa
        return label1
    }()
    
    fileprivate lazy var eduTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "授信额度"
        label1.font = DDSFont(13)
        label1.textColor = kT777
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var eDuDaiDetailLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "--"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var yearTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "年化利率"
        label1.font = DDSFont(13)
        label1.textColor = kT777
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var yearDetailLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "--"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .left
        label1.adjustsFontSizeToFitWidth = true
        return label1
    }()
    
    fileprivate lazy var weekTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "借款周期"
        label1.font = DDSFont(13)
        label1.textColor = kT777
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var weekDetailLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "--"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .left
        label1.adjustsFontSizeToFitWidth = true
        return label1
    }()
    
    fileprivate lazy var huanTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "还款方式"
        label1.font = DDSFont(13)
        label1.textColor = kT777
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var huanDetailLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "--"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .left
        label1.adjustsFontSizeToFitWidth = true
        return label1
    }()
    
    fileprivate lazy var baseView :UIView = {
        let tempView = UIView()
        tempView.backgroundColor = kBF8
        tempView.setCorner(radius: 8)
        
        tempView.addSubview(eDuDaiDetailLabel)
        tempView.addSubview(eduTitleLabel)
        
        tempView.addSubview(yearTitleLabel)
        tempView.addSubview(yearDetailLabel)
        
        tempView.addSubview(weekDetailLabel)
        tempView.addSubview(weekTitleLabel)
        
        tempView.addSubview(huanTitleLabel)
        tempView.addSubview(huanDetailLabel)
        
        eduTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(15)
        }
        eDuDaiDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(eduTitleLabel.snp.right).offset(10)
            make.centerY.equalTo(eduTitleLabel)
        }
        
        weekTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(eduTitleLabel.snp.bottom).offset(10)
        }
        weekDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(eDuDaiDetailLabel)
            make.centerY.equalTo(weekTitleLabel)
            make.bottom.equalTo(-12)
        }
        
        yearTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(180))
            make.centerY.equalTo(eduTitleLabel)
        }
        yearDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(yearTitleLabel.snp.right).offset(10)
            make.centerY.equalTo(eduTitleLabel)
            make.right.equalTo(-5)
        }
        
        huanTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(yearTitleLabel)
            make.centerY.equalTo(weekTitleLabel)
        }
        huanDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(huanTitleLabel.snp.right).offset(10)
            make.centerY.equalTo(weekTitleLabel)
            make.right.equalTo(-5)
        }
        
        
        return tempView
    }()
    
    fileprivate lazy var bottomLineView :UIView = {
        let tempView = UIView()
        tempView.backgroundColor = kBF2
        return tempView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doLoveProductAction() {
        //收藏
        print("收藏======")
        let isCollection = currentProductModel.collect
        let param = ["productId": currentProductModel.productId,"collect":isCollection ? false : true] as [String : Any]
        NetworkRequestManager.sharedInstance().requestPath(kproductCollectionUrl, withParam: param) { [weak self] result in
            self?.currentProductModel.collect = !isCollection
            self?.loveIcon.setImage(isCollection ? DDSImage("product_love_0") : DDSImage("product_love_1"), for: .normal)
        } failure: { error in
        }
    }
    
    fileprivate func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(productIcon)
        self.contentView.addSubview(productNameLabel)
        self.contentView.addSubview(loveIcon)
        self.contentView.addSubview(loveTipsLabel)
        
        self.contentView.addSubview(baseView)
        self.contentView.addSubview(bottomLineView)
        
        productIcon.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(15)
            make.width.height.equalTo(40)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(productIcon)
            make.left.equalTo(productIcon.snp.right).offset(10)
        }
        
        loveIcon.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.top.equalTo(productIcon)
            make.right.equalTo(-30)
        }
        loveTipsLabel.snp.makeConstraints { make in
            make.top.equalTo(loveIcon.snp.bottom).offset(1)
            make.centerX.equalTo(loveIcon)
        }
        
        baseView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(productIcon.snp.bottom).offset(15)
        }
        
        bottomLineView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(baseView.snp.bottom).offset(26)
            make.height.equalTo(10)
            make.bottom.equalTo(0)
        }
    }
}
