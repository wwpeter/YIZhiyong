//
//  SXALoanDetailTitleCell.swift
//  SXProject
//
//  Created by Felix on 2025/5/14.
//

import UIKit
import SnapKit

class SXALoanDetailTitleCell: UITableViewCell {
    
    fileprivate var baseView:UIView = {
        let view = UIView()
        view.backgroundColor = kBF8
        view.setCorner(8)
        return view
    }()
    
    fileprivate var qiShuLabel:UILabel = {
        let label = UILabel()
        label.font = DDSFont(12)
        label.textColor = kT777
        label.text = "期数"
        label.textAlignment = .center
        return label
    }()
    
    fileprivate var monthReturnLabel:UILabel = {
        let label = UILabel()
        label.textColor = kT777
        label.textAlignment = .center
        label.text = "每月还款(元)"
        label.font = DDSFont(12)
        return label
    }()
    
    fileprivate var benJinLabel:UILabel = {
        let label = UILabel()
        label.textColor = kT777
        label.textAlignment = .center
        label.text = "本金占额(元)"
        label.font = DDSFont(12)
        return label
    }()
    
    fileprivate var lixiLabel:UILabel = {
        let label = UILabel()
        label.textColor = kT777
        label.textAlignment = .center
        label.text = "利息占额(元)"
        label.font = DDSFont(12)
        return label
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

extension SXALoanDetailTitleCell {
    fileprivate func setUpViews() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        self.contentView.addSubview(baseView)
        baseView.addSubview(qiShuLabel)
        baseView.addSubview(monthReturnLabel)
        baseView.addSubview(benJinLabel)
        baseView.addSubview(lixiLabel)
        
        baseView.snp.makeConstraints { make in
            make.left.equalTo(sxDynamic(20))
            make.right.equalTo(-sxDynamic(20))
            make.top.equalTo(0)
            make.bottom.equalTo(0)
            make.height.equalTo(40)
        }
        qiShuLabel.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.width.equalTo(60)
            make.top.bottom.equalTo(0)
        }
        
        monthReturnLabel.snp.makeConstraints { make in
            make.left.equalTo(qiShuLabel.snp.right)
            make.top.bottom.equalTo(0)
        }
        
        benJinLabel.snp.makeConstraints { make in
            make.left.equalTo(monthReturnLabel.snp.right)
            make.top.bottom.equalTo(0)
            make.width.equalTo(monthReturnLabel)
        }
        lixiLabel.snp.makeConstraints { make in
            make.left.equalTo(benJinLabel.snp.right)
            make.top.bottom.equalTo(0)
            make.width.equalTo(monthReturnLabel)
            make.right.equalTo(0)
        }
    }
}
