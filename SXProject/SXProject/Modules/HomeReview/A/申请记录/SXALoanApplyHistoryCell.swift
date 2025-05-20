//
//  SXALoanApplyHistoryCell.swift
//  SXProject
//
//  Created by Felix on 2025/5/20.
//

import UIKit

class SXALoanApplyHistoryCell: UITableViewCell {
    
    func updateCellWithModel(_ model:SXALoanHistoryModel) {
        self.orderDetailLabel.text = model.orderId
        self.loanMoneyDetailLabel.text = model.loanAmount
        self.productDetailLabel.text = model.productName
        self.monthDetailabel.text = model.loanTime
        self.rateDetailabel.text = model.rate
        self.timeDetailabel.text = model.createTime
    }
    
    
    fileprivate lazy var baseView:UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .white
        tempView.layer.cornerRadius = 8
        tempView.clipsToBounds = true
        return tempView
    }()
    
    fileprivate lazy var orderTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.font = DDSFont(13)
        label1.textColor = kT777
        label1.text = "申请单号"
        return label1
    }()
    
    fileprivate lazy var orderDetailLabel:UILabel = {
        let label1 = UILabel()
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.text = "202311031425261234"
        return label1
    }()
    
    fileprivate lazy var statusLabel:UILabel = {
        let label1 = UILabel()
        label1.font = DDSFont(10)
        label1.textColor = UIColor(named: "tFFAA00")
        label1.text = "申请中"
        label1.backgroundColor = UIColor(named: "bFFF5F5")
        label1.textAlignment = .center
        label1.adjustsFontSizeToFitWidth = true
        label1.setCorner(2)
        return label1
    }()
    
    fileprivate lazy var topLine:UIView = {
        let line = UIView()
        line.backgroundColor = kBF2
        return line
    }()
    
    fileprivate lazy var loanMoneyTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "申请金额"
        label1.font = DDSFont(13)
        label1.textColor = kT777
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var loanMoneyDetailLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "30,000.00  元"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var productTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "申请产品"
        label1.font = DDSFont(13)
        label1.textColor = kT777
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var productDetailLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "产品名称"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var monthTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "申请期限"
        label1.font = DDSFont(13)
        label1.textColor = kT777
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var monthDetailabel:UILabel = {
        let label1 = UILabel()
        label1.text = "12  个月"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var rateTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "年化利率"
        label1.font = DDSFont(13)
        label1.textColor = kT777
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var rateDetailabel:UILabel = {
        let label1 = UILabel()
        label1.text = "24.00%"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var timeTitleLabel:UILabel = {
        let label1 = UILabel()
        label1.text = "申请时间"
        label1.font = DDSFont(13)
        label1.textColor = kT777
        label1.textAlignment = .left
        return label1
    }()
    
    fileprivate lazy var timeDetailabel:UILabel = {
        let label1 = UILabel()
        label1.text = "2025-04-05 12：23：23"
        label1.font = DDSFont(13)
        label1.textColor = kT333
        label1.textAlignment = .left
        return label1
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
    }
    
    
    fileprivate func setupViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(baseView)
        baseView.addSubview(orderTitleLabel)
        baseView.addSubview(orderDetailLabel)
        baseView.addSubview(statusLabel)
        baseView.addSubview(topLine)
        
        baseView.addSubview(loanMoneyTitleLabel)
        baseView.addSubview(loanMoneyDetailLabel)
        
        baseView.addSubview(productTitleLabel)
        baseView.addSubview(productDetailLabel)
        
        baseView.addSubview(monthTitleLabel)
        baseView.addSubview(monthDetailabel)
        
        baseView.addSubview(rateTitleLabel)
        baseView.addSubview(rateDetailabel)
        
        baseView.addSubview(timeTitleLabel)
        baseView.addSubview(timeDetailabel)
        
        baseView.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.top.equalTo(10)
            make.right.equalTo(-15)
            make.bottom.equalTo(-0)
        }
        
        orderTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(0)
            make.height.equalTo(48)
        }
        
        orderDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(75))
            make.centerY.equalTo(orderTitleLabel)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.width.equalTo(sxDynamic(40))
            make.height.equalTo(16)
            make.centerY.equalTo(orderTitleLabel)
        }
        
        topLine.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.right.equalTo(-10)
            make.height.equalTo(0.5)
            make.top.equalTo(48)
        }
        
        loanMoneyTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(topLine.snp.bottom).offset(10)
        }
        
        loanMoneyDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(75))
            make.centerY.equalTo(loanMoneyTitleLabel)
            make.right.equalTo(-10)
        }
        
        
        productTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(loanMoneyTitleLabel.snp.bottom).offset(10)
        }
        
        productDetailLabel.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(75))
            make.centerY.equalTo(productTitleLabel)
            make.right.equalTo(-10)
        }
        
        monthTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(productTitleLabel.snp.bottom).offset(10)
        }
        
        monthDetailabel.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(75))
            make.centerY.equalTo(monthTitleLabel)
            make.right.equalTo(-10)
        }
        
        rateTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(monthTitleLabel.snp.bottom).offset(10)
        }
        
        rateDetailabel.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(75))
            make.centerY.equalTo(rateTitleLabel)
            make.right.equalTo(-10)
        }
        
        timeTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(rateTitleLabel.snp.bottom).offset(10)
            make.bottom.equalTo(-15)
        }
        
        timeDetailabel.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(75))
            make.centerY.equalTo(timeTitleLabel)
            make.right.equalTo(-10)
        }
    }
}
