//
//  SXAHomeCompanyListCell.swift
//  SXProject
//
//  Created by Felix on 2025/5/19.
//

import UIKit

class SXAHomeCompanyListCell: UITableViewCell {
    
    func updateCellWithModel(_ model:SXACompanyModel) {
        self.nameLabel.text = model.name
    }
    
    fileprivate lazy var baseView:UIView = {
        let tempView = UIView()
        tempView.backgroundColor = .white
        return tempView
    }()
    
    fileprivate lazy var nameLabel:UILabel = {
        let label1 = UILabel()
        label1.font = DDSFont(13)
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
        self.backgroundColor = .white
        self.selectionStyle = .none
        self.contentView.backgroundColor = .clear
        
        self.contentView.addSubview(baseView)
        baseView.addSubview(nameLabel)
        
        
        baseView.snp.makeConstraints { make in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(-0)
            make.height.equalTo(44)
        }
        self.nameLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.bottom.equalTo(0)
            make.right.equalTo(-10)
        }
        
    }
}
