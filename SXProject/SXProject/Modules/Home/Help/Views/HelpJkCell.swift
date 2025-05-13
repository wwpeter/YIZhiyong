//
//  HelpJkCell.swift
//  SXProject
//
//  Created by 王威 on 2025/2/14.
//

import UIKit

class HelpJkCell: UITableViewCell {

    class func cellID() -> String {
        return "HelpJkCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(HelpJkCell.self, forCellReuseIdentifier: cellID())
    }
    class func cellHeight() -> CGFloat {
        return sxDynamic(110)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        contentView.backgroundColor = .clear
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
        contentView.addSubview(groundView)
        contentView.addSubview(iconImg)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(subGroundView)
        contentView.addSubview(subLabel)
    }
    
    override func layoutSubviews() {

        groundView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(sxDynamic(10))
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(15))
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-15))
            make.bottom.equalTo(contentView.snp.bottom).offset(sxDynamic(-10))
        }
        
        iconImg.snp.makeConstraints { make in
            make.width.height.equalTo(sxDynamic(13))
            make.left.equalTo(groundView.snp.left).offset(sxDynamic(15))
            make.top.equalTo(groundView.snp.top).offset(sxDynamic(20))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImg.snp.centerY)
            make.left.equalTo(iconImg.snp.right).offset(sxDynamic(5))
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-60))
        }
        
        subGroundView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(10))
            make.left.equalTo(groundView.snp.left).offset(sxDynamic(15))
            make.right.equalTo(groundView.snp.right).offset(sxDynamic(-15))
            make.bottom.equalTo(contentView.snp.bottom).offset(sxDynamic(-15))
        }
        
        subLabel.snp.makeConstraints { make in
          
            make.centerY.equalTo(subGroundView.snp.centerY)
            make.right.equalTo(subGroundView.snp.right).offset(sxDynamic(-20))
            make.left.equalTo(subGroundView.snp.left).offset(sxDynamic(10))
        }
    }
    //MARK: - getter
    
    private lazy var groundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = sxDynamic(8)
        
        return view
    }()
    
    private lazy var iconImg: UIImageView = {
        let icon = CreateBaseView.makeIMG("help_cell_icon", .scaleAspectFit)
        
        return icon
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = CreateBaseView.makeLabel("版本号", UIFont.sx.font_t13, kT333, .left, 1)
        
        return titleLabel
    }()
    
    private lazy var subGroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = sxDynamic(8)
        view.backgroundColor = kBF8
        
        
        return view
    }()
    
    private lazy var subLabel: UILabel = {
        let titleLabel = CreateBaseView.makeLabel("v1.0.0", UIFont.sx.font_t13, kT333, .left, 0)
        
        return titleLabel
    }()
}
