//
//  ProtocolCell.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

class ProtocolCell: UITableViewCell {


    class func cellID() -> String {
        return "ProtocolCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(ProtocolCell.self, forCellReuseIdentifier: cellID())
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
    func setTitle(title: String, icon: String) {
        titleLabel.text = title
        iconImg.image = UIImage(named: icon)
    }

    func initViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(rightImg)
        contentView.addSubview(lineView)
    }
    
    override func layoutSubviews() {

        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(20))
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-60))
        }
        rightImg.snp.makeConstraints { make in
            make.width.equalTo(sxDynamic(6))
            make.height.equalTo(sxDynamic(10))
            make.centerY.equalTo(contentView.snp.centerY)
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-20))
        }
        
        lineView.snp.makeConstraints { make in
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-20))
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(20))
            make.height.equalTo(sxDynamic(1))
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    //MARK: - getter
    private lazy var titleLabel: UILabel = {
        let titleLabel = CreateBaseView.makeLabel("银行卡管理", UIFont.sx.font_t13, kT333, .left, 1)
        
        return titleLabel
    }()
    
    private lazy var iconImg: UIImageView = {
        let icon = CreateBaseView.makeIMG("bank_manager", .scaleAspectFit)
        
        return icon
    }()
    
    private lazy var rightImg: UIImageView = {
        let img = CreateBaseView.makeIMG("iot_regist_right", .scaleAspectFit)
        
        return img
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = kBF2
        
        return view
    }()
}
