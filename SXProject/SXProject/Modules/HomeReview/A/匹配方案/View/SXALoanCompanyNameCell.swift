//
//  SXALoanCompanyNameCell.swift
//  SXProject
//
//  Created by Felix on 2025/5/16.
//

import UIKit

class SXALoanCompanyNameCell: UITableViewCell {

    fileprivate lazy var companyIconImg:UIImageView = {
        let img = UIImageView()
        img.image = DDSImage("a_compang_icon")
        return img
    }()
    
    fileprivate lazy var rightTipImage:UIImageView = {
        let img = UIImageView()
        img.image = DDSImage("a_loan_icon_1")
        return img
    }()
    fileprivate lazy var companyNameLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "企业名称"
        label1.font = DDSFont(16)
        label1.textColor = kT333
        return label1
    }()
    
    fileprivate lazy var tipsLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "匹配完成请查收"
        label1.font = DDSFont(12)
        label1.textColor = kT777
        return label1
    }()
    
    fileprivate lazy var keDaiTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "可贷产品(款)"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .center
        return label1
    }()
    
    fileprivate lazy var keDaiDetailLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "3"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .center
        return label1
    }()
    
    fileprivate lazy var yuGuTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "预估额度(款)"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .center
        return label1
    }()
    
    fileprivate lazy var yuGuDetailLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "20"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .center
        return label1
    }()
    
    fileprivate lazy var yearTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "参考年息(%)"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .center
        return label1
    }()
    
    fileprivate lazy var yearDetailLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "20%"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .center
        return label1
    }()
    fileprivate lazy var baseView :UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .white
        tempView.addSubview(keDaiDetailLabel)
        tempView.addSubview(keDaiTitleLabel)

        tempView.addSubview(yuGuDetailLabel)
        tempView.addSubview(yuGuTitleLabel)

        tempView.addSubview(yearDetailLabel)
        tempView.addSubview(yearTitleLabel)
        
        keDaiDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(0)
        }
        yuGuDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(keDaiDetailLabel.snp.right).offset(0)
            make.width.equalTo(keDaiDetailLabel.snp.width)
        }
        yearDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.left.equalTo(yuGuDetailLabel.snp.right).offset(0)
            make.width.equalTo(keDaiDetailLabel.snp.width)
            make.right.equalTo(0)
        }
        
        keDaiTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(keDaiDetailLabel.snp.bottom).offset(10)
            make.centerX.equalTo(keDaiDetailLabel)
        }
        
        yuGuTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(yuGuDetailLabel.snp.bottom).offset(10)
            make.centerX.equalTo(yuGuDetailLabel)
        }
        
        yearTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(yearDetailLabel.snp.bottom).offset(10)
            make.centerX.equalTo(yearDetailLabel)
        }
        
        return tempView
    }()
    
    fileprivate lazy var bottomLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "可申请产品"
        label1.font = DDSFont(16)
        label1.textColor = kT333
        return label1
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    fileprivate func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(rightTipImage)
        self.contentView.addSubview(companyIconImg)
        self.contentView.addSubview(companyNameLabel)
        self.contentView.addSubview(tipsLabel)
        self.contentView.addSubview(baseView)
        self.contentView.addSubview(bottomLabel)
        
        companyIconImg.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(15)
            make.width.height.equalTo(24)
        }
        companyNameLabel.snp.makeConstraints { make in
            make.top.equalTo(companyIconImg.snp.top)
            make.left.equalTo(companyIconImg.snp.right).offset(5)
        }
        tipsLabel.snp.makeConstraints { make in
            make.left.equalTo(companyNameLabel)
            make.top.equalTo(companyNameLabel.snp.bottom).offset(8)
        }
        
        rightTipImage.snp.makeConstraints { make in
            make.right.equalTo(-20)
            make.top.equalTo(0)
            make.width.equalTo(80)
            make.height.equalTo(112)
        }
        
        baseView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.height.equalTo(90)
            make.top.equalTo(80)
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(baseView.snp.bottom).offset(15)
            make.bottom.equalTo(-10)
        }
    }
}
