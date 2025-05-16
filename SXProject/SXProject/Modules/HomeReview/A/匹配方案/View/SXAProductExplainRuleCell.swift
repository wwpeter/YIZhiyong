//
//  SXAProductExplainRuleCell.swift
//  SXProject
//
//  Created by Felix on 2025/5/16.
//

import UIKit

class SXAProductExplainRuleCell: UITableViewCell {

    public func updateCellWithModel(_ model:SXAProudectExplainModel) {
        nameLabel.text = model.title
        detailLabel.text = model.decrilbelText
    }

    fileprivate lazy var nameLabel:UILabel = {
        let label1 = UILabel()
        label1.font = DDSFont_B(16)
        label1.textColor = kT333
        return label1
    }()
    
    fileprivate lazy var baseView:UIView = {
        let tempView = UIView()
        tempView.setCorner(radius: 8)
        tempView.backgroundColor = kBF8
        tempView.addSubview(detailLabel)
        
        detailLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(10)
            make.right.equalTo(-10)
            make.bottom.equalTo(-10)
        }
        return tempView
    }()
    
    fileprivate lazy var detailLabel:UILabel = {
        let label1 = UILabel()
        label1.font = DDSFont(13)
        label1.textColor = kT777
        label1.numberOfLines = 0
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
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(baseView)

        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(15)
            make.right.equalTo(-12)
        }
        
        baseView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.bottom.equalTo(0)
        }
        
      
    }
}
