//
//  BottomCell.swift
//  SXProject
//
//  Created by 王威 on 2025/4/14.
//

import UIKit

class BottomCell: UITableViewCell {
    class func cellID() -> String {
        return "BottomCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(BottomCell.self, forCellReuseIdentifier: cellID())
    }
    class func cellHeight() -> CGFloat {
        return sxDynamic(330)
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

    
    //MARK: - initializa
    func initViews() {
        addSubview(groundView)
        addSubview(titleLabel)
        addSubview(subLabelT)
        addSubview(lineView)
        addSubview(lineViewT)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        groundView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(sxDynamic(20))
            make.leading.equalTo(self.snp.leading).offset(sxDynamic(20))
            make.trailing.equalTo(self.snp.trailing).offset(sxDynamic(-20))
            make.bottom.equalTo(self.snp.bottom).offset(sxDynamic(-20))
        }
        lineView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(sxDynamic(1))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(groundView.snp.top).offset(sxDynamic(sxDynamic(15)))
            make.width.equalTo(sxDynamic(110))
            make.height.equalTo(sxDynamic(25))
            make.centerX.equalTo(groundView.snp.centerX)
        }
        subLabelT.snp.makeConstraints { make in
            make.left.equalTo(groundView.snp.left).offset(sxDynamic(sxDynamic(15)))
            make.right.equalTo(groundView.snp.right).offset(sxDynamic(sxDynamic(-15)))
            make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(10))
        }
        lineViewT.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.bottom.equalTo(self.snp.bottom).offset(sxDynamic(-10))
            make.height.equalTo(sxDynamic(1))
        }
    }
    
    //MARK: - getter
    private lazy var groundView: UIView = {
        let view = UIView()
        view.backgroundColor = kBF8
        view.layer.cornerRadius = sxDynamic(16)
        
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let label = CreateBaseView.makeLabel("郑重声明", UIFont.sx.font_t13Blod, kT333, .center, 1)
        
        return label
    }()
    /*
     本平台为金融信息平台,所有贷款在未成功放款前，绝不收取任何费用
     请根据个人能力合理贷款，理性消费，避免逾期
     客服热线:0571-22930325
     福建志鸿融资担保有限公司
     闽ICP备2025089972号
     */
    private lazy var subLabelT: UILabel = {
        let label = CreateBaseView.makeLabel(" 本平台为金融信息平台,所有贷款在未成功放款前，绝不收取任何费用\n\n 请根据个人能力合理贷款，理性消费，避免逾期 \n\n 客服热线:0571-22930325\n\n福建志鸿融资担保有限公司\n\n闽ICP备2025089972号", UIFont.sx.font_t13, kT777, .center, 0)
        
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = kBF8
        
        return view
    }()
    private lazy var lineViewT: UIView = {
        let view = UIView()
        view.backgroundColor = kBF8
        
        return view
    }()
}


