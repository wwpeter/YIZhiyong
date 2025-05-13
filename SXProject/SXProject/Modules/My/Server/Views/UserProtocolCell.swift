//
//  UserProtocolCell.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

class UserProtocolCell: UITableViewCell {

    class func cellID() -> String {
        return "UserProtocolCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(UserProtocolCell.self, forCellReuseIdentifier: cellID())
    }
    class func cellHeight() -> CGFloat {
        return sxDynamic(60)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        contentView.backgroundColor = .white
        self.selectionStyle = .none
        initViews()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - action
    func setTitle(title: String, sub: String) {
        titleLabel.text = title
        subLabel.text = sub
    }

    func initViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        
    }
    
    override func layoutSubviews() {

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(20))
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-60))
        }
        subLabel.snp.makeConstraints { make in
           
            make.height.equalTo(sxDynamic(20))
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-20))
        }
        
     
    }
    //MARK: - getter
    private lazy var titleLabel: UILabel = {
        let titleLabel = CreateBaseView.makeLabel("版本号", UIFont.sx.font_t13, kT333, .left, 1)
        
        return titleLabel
    }()
    
    private lazy var subLabel: UILabel = {
        let titleLabel = CreateBaseView.makeLabel("v1.0.0", UIFont.sx.font_t13, kT333, .left, 1)
        
        return titleLabel
    }()
    

}
