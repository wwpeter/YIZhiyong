//
//  RecordJKCell.swift
//  SXProject
//
//  Created by 王威 on 2025/2/13.
//

import UIKit

class RecordJKCell: UITableViewCell {

    class func cellID() -> String {
        return "RecordJKCell"
    }
    class func registerCell(tableView: UITableView) {
        tableView.register(RecordJKCell.self, forCellReuseIdentifier: cellID())
    }
    class func cellHeight() -> CGFloat {
        return sxDynamic(147)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        contentView.backgroundColor = kBF8
        self.selectionStyle = .none
        initViews()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - action
    func setTitle(title: String, icon: String) {
        statusBut.setTitle("审核中", for: .selected)
        statusBut.setTitleColor(AssetColors.tff0000.color, for: .normal)
        statusBut.backgroundColor = AssetColors.tff0000.color
    }
    
    func setDataSource(model: RecordModel) {
        ///投递状态 UNCONFIRMED:未确认 PENDING：审核中PENDING  失败 FAILED  - 审核中PENDING  失败 FAILED
        titleLabelR.text = model.orderId
        amountLabelR.text = model.loanAmount
        timeLimitLabelR.text = String.init(format: "%@月", model.loanTime)
        timeLabelR.text = model.createTime
        
        let status = model.status
       if status == "PENDING" {//AssetColors.bfff5F5.color, AssetColors.tff0000.color
            statusBut.setTitle("审核中", for: .normal)
           statusBut.backgroundColor = AssetColors.tfbf4E5.color
           statusBut.setTitleColor(AssetColors.bffaa00.color, for: .normal)
        } else if status == "FAILED" {
            statusBut.setTitle("审核未通过", for: .normal)
            statusBut.backgroundColor = AssetColors.bfff5F5.color
            statusBut.setTitleColor(AssetColors.tff0000.color, for: .normal)
        }
    }

    func initViews() {
        contentView.addSubview(groundView)
        
        groundView.addSubview(titleLabel)
        groundView.addSubview(titleLabelR)
        groundView.addSubview(statusBut)
        
        groundView.addSubview(lineView)
        
        groundView.addSubview(amountLabel)
        groundView.addSubview(amountLabelR)
        
        groundView.addSubview(timeLimitLabel)
        groundView.addSubview(timeLimitLabelR)
        
        groundView.addSubview(timeLabel)
        groundView.addSubview(timeLabelR)
     
    }
    
    override func layoutSubviews() {
        groundView.snp.makeConstraints { make in
            make.left.equalTo(contentView.snp.left).offset(sxDynamic(15))
            make.right.equalTo(contentView.snp.right).offset(sxDynamic(-15))
            make.bottom.equalTo(contentView.snp.bottom)
            make.top.equalTo(contentView.snp.top).offset(sxDynamic(10))
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(groundView.snp.left).offset(sxDynamic(10))
            make.top.equalTo(groundView.snp.top).offset(sxDynamic(15))
            make.height.equalTo(sxDynamic(18))
        }
        titleLabelR.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.right).offset(sxDynamic(10))
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(sxDynamic(200))
        }
        statusBut.snp.makeConstraints { make in
            make.right.equalTo(groundView.snp.right).offset(sxDynamic(-10))
            make.centerY.equalTo(titleLabel.snp.centerY)
            make.width.equalTo(sxDynamic(77))
            make.height.equalTo(23)
        }
        lineView.snp.makeConstraints { make in
            make.left.equalTo(groundView.snp.left).offset(sxDynamic(10))
            make.right.equalTo(groundView.snp.right).offset(sxDynamic(-10))
            make.height.equalTo(sxDynamic(1))
            make.top.equalTo(titleLabel.snp.bottom).offset(sxDynamic(15))
        }
        amountLabel.snp.makeConstraints { make in
            make.left.equalTo(groundView.snp.left).offset(sxDynamic(10))
            make.top.equalTo(lineView.snp.bottom).offset(sxDynamic(10))
            make.height.equalTo(sxDynamic(18))
            make.width.height.equalTo(sxDynamic(50))
        }
        amountLabelR.snp.makeConstraints { make in
            make.left.equalTo(amountLabel.snp.right).offset(sxDynamic(8))
            make.centerY.equalTo(amountLabel.snp.centerY)
            make.right.equalTo(groundView.snp.right).offset(sxDynamic(-20))
        }
        timeLimitLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(amountLabel.snp.bottom).offset(sxDynamic(5))
            make.height.equalTo(sxDynamic(18))
        }
        timeLimitLabelR.snp.makeConstraints { make in
            make.left.equalTo(timeLimitLabel.snp.right).offset(sxDynamic(10))
            make.centerY.equalTo(timeLimitLabel.snp.centerY)
            make.right.equalTo(groundView.snp.right).offset(sxDynamic(-20))
        }
      
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(timeLimitLabel.snp.bottom).offset(sxDynamic(5))
            make.height.equalTo(sxDynamic(18))
        }
        timeLabelR.snp.makeConstraints { make in
            make.left.equalTo(timeLabel.snp.right).offset(sxDynamic(10))
            make.centerY.equalTo(timeLabel.snp.centerY)
            make.right.equalTo(groundView.snp.right).offset(sxDynamic(-20))
        }
    }
    //MARK: - getter
    private lazy var groundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = sxDynamic(8)
        
        return view
    }()
    private lazy var titleLabel: UILabel = {
        let titleLabel = CreateBaseView.makeLabel("借款单号", UIFont.sx.font_t13, kT777, .left, 1)
        
        return titleLabel
    }()
    
    private lazy var titleLabelR: UILabel = {
        let titleLabel = CreateBaseView.makeLabel("--", UIFont.sx.font_t13Blod, kT333, .left, 1)
        
        return titleLabel
    }()
    
    private lazy var statusBut: UIButton = {//bfff5F5
        let but = CreateBaseView.makeBut("审核未通过", AssetColors.bfff5F5.color, AssetColors.tff0000.color, UIFont.sx.font_t16)
        but.layer.cornerRadius = sxDynamic(2)
        
        return but
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        
        view.backgroundColor = kBF2
        
        return view
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = CreateBaseView.makeLabel("借款金额",  UIFont.sx.font_t13, kT777, .left, 1)
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    private lazy var amountLabelR: UILabel = {
        let label = CreateBaseView.makeLabel("--",  UIFont.sx.font_t13, kT333, .left, 1)
        
        return label
    }()
    
    private lazy var timeLimitLabel: UILabel = {
        let label = CreateBaseView.makeLabel("借款期限",  UIFont.sx.font_t13, kT777, .left, 1)
        
        return label
    }()
    
    private lazy var timeLimitLabelR: UILabel = {
        let label = CreateBaseView.makeLabel("--",  UIFont.sx.font_t13, kT333, .left, 1)
        
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = CreateBaseView.makeLabel("借款时间",  UIFont.sx.font_t13, kT777, .left, 1)
        
        return label
    }()
    
    private lazy var timeLabelR: UILabel = {
        let label = CreateBaseView.makeLabel("--",  UIFont.sx.font_t13, kT333, .left, 1)
        
        return label
    }()
   
}
