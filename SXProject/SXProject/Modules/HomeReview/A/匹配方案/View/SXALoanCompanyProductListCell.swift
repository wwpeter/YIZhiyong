//
//  SXALoanCompanyProductListCell.swift
//  SXProject
//
//  Created by Felix on 2025/5/16.
//

import UIKit

class SXALoanCompanyProductListCell: UITableViewCell {
    
    public var applyBlock: (() -> Void)?
    
    
    fileprivate lazy var baseView:UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .white
        tempView.layer.cornerRadius = 8
        tempView.clipsToBounds = true
        return tempView
    }()
    
    fileprivate lazy var iocnImg:UIImageView = {
        let img = UIImageView()
        img.image = DDSImage("a_compang_icon")
        return img
    }()
    
    fileprivate lazy var nameLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "产品名称"
        label1.font = DDSFont(16)
        label1.textColor = kT333
        return label1
    }()
    
    fileprivate lazy var sureButton:UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("立即申请", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.backgroundColor =  kTBlue
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(doApplyAction), for: .touchUpInside)
        return button
    }()
    
    
    fileprivate lazy var yearRateTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "年化利率"
        label1.font = DDSFont(12)
        label1.textColor = kT777
        label1.textAlignment = .center
        return label1
    }()
    
    fileprivate lazy var yearRateDetailLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "12%"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .center
        return label1
    }()
    
    fileprivate lazy var eDuTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "最高额度"
        label1.font = DDSFont(12)
        label1.textColor = kT777
        label1.textAlignment = .center
        return label1
    }()
    
    fileprivate lazy var eDuDetailLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "20"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .center
        return label1
    }()
    
    fileprivate lazy var weekTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "还款周期"
        label1.font = DDSFont(12)
        label1.textColor = kT777
        label1.textAlignment = .center
        return label1
    }()
    
    fileprivate lazy var weekDetailabel:UILabel = {
        let label1 = UILabel()
        label1.text = "12期"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .center
        return label1
    }()
    
    fileprivate lazy var productDetailView :UIView = {
        let tempView = UIView()
        tempView.backgroundColor = kBF8
        tempView.setCorner(radius: 8)
        
        tempView.addSubview(yearRateDetailLabel)
        tempView.addSubview(yearRateTitleLabel)
        
        tempView.addSubview(eDuDetailLabel)
        tempView.addSubview(eDuTitleLabel)
        
        tempView.addSubview(weekDetailabel)
        tempView.addSubview(weekTitleLabel)
        
        yearRateDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.left.equalTo(0)
        }
        eDuDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.left.equalTo(yearRateDetailLabel.snp.right).offset(0)
            make.width.equalTo(yearRateDetailLabel.snp.width)
        }
        weekDetailabel.snp.makeConstraints { make in
            make.top.equalTo(8)
            make.left.equalTo(eDuDetailLabel.snp.right).offset(0)
            make.width.equalTo(yearRateDetailLabel.snp.width)
            make.right.equalTo(0)
        }
        
        yearRateTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(yearRateDetailLabel.snp.bottom).offset(5)
            make.centerX.equalTo(yearRateDetailLabel)
        }
        
        eDuTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(eDuDetailLabel.snp.bottom).offset(5)
            make.centerX.equalTo(eDuDetailLabel)
        }
        
        weekTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(weekDetailabel.snp.bottom).offset(5)
            make.centerX.equalTo(weekDetailabel)
        }
        
        return tempView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doApplyAction() {
        print("applyfor=======")
        applyBlock?()
    }
    
    
    fileprivate func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(baseView)
        baseView.addSubview(iocnImg)
        baseView.addSubview(nameLabel)
        baseView.addSubview(sureButton)
        baseView.addSubview(productDetailView)
        
        baseView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-10)
        }
        
        iocnImg.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(15)
            make.width.height.equalTo(24)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(iocnImg.snp.right).offset(10)
            make.centerY.equalTo(iocnImg)
        }
        
        sureButton.snp.makeConstraints { make in
            make.right.equalTo(-15)
            make.height.equalTo(28)
            make.width.equalTo(sxDynamic(72))
            make.centerY.equalTo(iocnImg)
        }
        
        productDetailView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.equalTo(iocnImg.snp.bottom).offset(15)
            make.height.equalTo(56)
            make.bottom.equalTo(-14)
        }
    }
}
