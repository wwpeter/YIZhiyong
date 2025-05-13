//
//  SettingCell.swift
//  SXProject
//
//  Created by 王威 on 2025/3/28.
//

import UIKit

class SettingCell: UITableViewCell {

    class func cellID() -> String {
        return "SettingCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(SettingCell.self, forCellReuseIdentifier: cellID())
    }
    class func cellHeight() -> CGFloat {
        return sxDynamic(51)
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

    func setDataSource(dic: [String:String]) {
        titleLabel.text = dic["title"]
        subLabel.text = dic["sub"]
    }
    
    func hiddenIcon(hidden: Bool) {
        rightIcon.isHidden = hidden
        if hidden == true {
            subLabel.snp.remakeConstraints { make in
                make.right.equalTo(contentView.snp.right).offset(sxDynamic(-20))
                make.centerY.equalTo(contentView.snp.centerY)
            }
        }
        
    }
    
    //MARK: - initializa
    func initViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subLabel)
        
        contentView.addSubview(lineView)
        contentView.addSubview(rightIcon)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(20))
            make.centerY.equalTo(contentView.snp.centerY)
        }
        rightIcon.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-20))
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.height.equalTo(sxDynamic(16))
        }
        subLabel.snp.makeConstraints { make in
            make.right.equalTo(rightIcon.snp.left).offset(sxDynamic(-10))
            make.centerY.equalTo(contentView.snp.centerY)
        }
        lineView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(20))
            make.height.equalTo(sxDynamic(1))
            make.right.equalTo(contentView.snp.right)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
    //MARK: - getter
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("", UIFont.sx.font_t13, kT333, .left, 1)
        
        return label
    }()
    
    private lazy var subLabel: UILabel = {
        let label = CreateBaseView.makeLabel("", UIFont.sx.font_t13, kT777, .right, 1)
        
        return label
    }()
    
    private lazy var rightIcon: UIImageView = {
        let img = CreateBaseView.makeIMG("cell_right", .scaleAspectFit)
        
        return img
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kBF8
        
        return view
    }()
}
