//
//  SXALoanDetailTopCell.swift
//  DDStudyBlind
//
//  Created by Felix on 2023/6/15.
//

import UIKit
import SnapKit

class SXALoanDetailTopCell: UITableViewCell {
    
    public func updateCellWithArray(_ array:[SXALoadPaymentDetailModel],_ principal:Double) {
        benJinDetailLabel.text = principal.format(".2")
        monthDetailLabel.text = "\(array.count)"
        
        var lixiValue :Double = 0
        for model in array {
            lixiValue += model.interest
        }
        lixiDetailLabel.text = lixiValue.format(".2")
        
        let toatlPay = principal + lixiValue
        moneyLabel.text = toatlPay.format(".2")
    }
    
    fileprivate var baseView:UIView = {
        let view = UIView()
        view.backgroundColor = kTBlue
        view.setCorner(radius: 8)
        
        let label = UILabel()
        label.font = DDSFont(13)
        label.textColor = .white
        label.text = "累计还款（元）"
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalTo(20)
            make.centerX.equalTo(view)
        }
        return view
    }()
    
    
    fileprivate var moneyLabel:UILabel = {
        let label = UILabel()
        label.font = DDSFont_B(30)
        label.textColor = .white
        label.text = "--"
        return label
    }()
    
    fileprivate var benJinTitleLabel:UILabel = {
        let label = UILabel()
        label.font = DDSFont(13)
        label.textColor = .white
        label.text = "贷款本金(元)"
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var benJinDetailLabel:UILabel = {
        let label = UILabel()
        label.font = DDSFont(15)
        label.textColor = .white
        label.text = "--"
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var liXiTitleLabel:UILabel = {
        let label = UILabel()
        label.font = DDSFont(13)
        label.textColor = .white
        label.text = "贷款利息(元)"
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var lixiDetailLabel:UILabel = {
        let label = UILabel()
        label.font = DDSFont(15)
        label.textColor = .white
        label.text = "--"
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var monthTitleLabel:UILabel = {
        let label = UILabel()
        label.font = DDSFont(13)
        label.textColor = .white
        label.text = "还款期数(月)"
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var monthDetailLabel:UILabel = {
        let label = UILabel()
        label.font = DDSFont(15)
        label.textColor = .white
        label.text = "--"
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var line_1:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return view
    }()
    
    fileprivate var line_2:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UI

extension SXALoanDetailTopCell {
    fileprivate func setUpViews() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(baseView)
        
        baseView.addSubview(moneyLabel)
        baseView.addSubview(benJinTitleLabel)
        baseView.addSubview(benJinDetailLabel)
        
        baseView.addSubview(liXiTitleLabel)
        baseView.addSubview(lixiDetailLabel)
        
        baseView.addSubview(monthTitleLabel)
        baseView.addSubview(monthDetailLabel)
        baseView.addSubview(line_1)
        baseView.addSubview(line_2)
        
        baseView.snp.makeConstraints { make in
            make.left.top.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.bottom.equalTo(-15)
            make.top.equalTo(10)
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.top.equalTo(50)
            make.centerX.equalTo(baseView)
            
        }
        
        benJinTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(moneyLabel.snp.bottom).offset(20)
            
        }
        
        liXiTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(benJinTitleLabel.snp.right).offset(0)
            make.top.equalTo(benJinTitleLabel)
            make.width.equalTo(benJinTitleLabel)
        }
        
        monthTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(liXiTitleLabel.snp.right).offset(0)
            make.top.equalTo(benJinTitleLabel)
            make.width.equalTo(benJinTitleLabel)
            make.right.equalTo(-10)
        }
        
        benJinDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(benJinTitleLabel.snp.bottom).offset(6)
            make.centerX.equalTo(benJinTitleLabel)
            make.bottom.equalTo(-20)
        }
        
        lixiDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(benJinDetailLabel)
            make.centerX.equalTo(liXiTitleLabel)
        }
        
        monthDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(benJinDetailLabel)
            make.centerX.equalTo(monthTitleLabel)
        }
        
        line_1.snp.makeConstraints { make in
            make.top.equalTo(benJinTitleLabel.snp.top)
            make.height.equalTo(44)
            make.width.equalTo(0.5)
            make.left.equalTo(benJinTitleLabel.snp.right)
        }
        
        line_2.snp.makeConstraints { make in
            make.top.equalTo(line_1)
            make.height.equalTo(44)
            make.width.equalTo(0.5)
            make.left.equalTo(liXiTitleLabel.snp.right)
        }
    }
}
